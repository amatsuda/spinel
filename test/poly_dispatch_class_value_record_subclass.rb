# A Struct or Data class whose block hands out `self` from a class method
# hands out its subclass when the subclass calls it (`Q.me` is Q), so the
# subclass is a Class value too: a poly slot holding it is kept off the arm
# of the subclass's own `tag` and raises NoMethodError, as CRuby does, where
# it entered the instance arm (a segfault).
class Filler; end

class R
  def initialize(v = 2) = @v = v
  def tag = "R#{@v}"
end

def show_all(xs)
  xs.each do |o|
    begin
      puts o.tag
    rescue NoMethodError => e
      puts "NoMethodError: #{e.message}"
    end
  end
end

P = Struct.new(:n) do
  def self.me = self
end

class Q < P
  def tag = "Q#{n}"
end

D = Data.define(:n) do
  def self.me = self
end

class E < D
  def tag = "E#{n}"
end

show_all([Q.new(1), R.new(2), Q.me])
show_all([E.new(n: 3), R.new(4), E.me])
