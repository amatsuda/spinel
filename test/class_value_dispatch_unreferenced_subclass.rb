# A class method that reads a class instance variable is copied into each
# class; a subclass nothing names gets no copy, so a `superclass.flag` or
# `self.class.flag` dispatch must not call one for it.
class Base
  def self.flag
    return @flag if @set
    return true if self == Base
    superclass.flag
  end

  def self.flag=(v)
    @flag = v
    @set = true
  end

  def cached?
    self.class.flag
  end
end

class App < Base; end
class Things < App; end
class Unnamed < Base; end
class AlsoUnnamed < App; end

p Things.new.cached?
App.flag = false
p Things.new.cached?
p Base.flag
