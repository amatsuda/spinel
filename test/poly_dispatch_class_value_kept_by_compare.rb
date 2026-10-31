# A Class value handed to a comparison the program defines itself (an
# object's own `==`, a `===` a `case` calls on its subject) may be kept by
# it, so the classes are values: a poly slot that ends up holding the kept
# class is kept off the arm of the class's own `tag` and raises
# NoMethodError, as CRuby does, where it entered the instance arm (a
# segfault).
class Filler; end

class A
  def initialize(v) = @v = v
  def tag = "A#{@v}"
end

class B
  def tag = "B"
end

class Sink
  attr_reader :kept
  def ==(o)
    @kept = o
    false
  end
end

class Matcher
  attr_reader :kept
  def ===(o)
    @kept = o
    false
  end
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

s = Sink.new
x = A.new(1)
p(s == x.class)
show_all([A.new(2), B.new, s.kept])

m = Matcher.new
r = case x.class
    when m then "m"
    when A then "a"
    else "other"
    end
puts r
show_all([A.new(3), B.new, m.kept])
