# `&recv.method(name)` looks the Method up once, before the loop runs. The
# receiver and the name are read once when the method the Method names (or a
# closure it calls) changes what they read: a global, an instance variable,
# a local a lambda rewrites. A plain local, a constant, a literal or self is
# still read where the block runs.
$flip = true
class Flip
  def first(x) = ($flip = false; "first #{x}")
  def second(x) = "second #{x}"
end
f = Flip.new
p [1, 2, 3].map(&f.method($flip ? :first : :second))

class W
  def initialize(t, owner = nil) = (@t = t; @owner = owner)
  def go(x) = (@owner&.swap; "#{@t}#{x}")
end
class Holder
  def initialize = @w = W.new("a", self)
  def swap = @w = W.new("b", self)
  def run(items) = items.map(&@w.method(:go))
end
p Holder.new.run([1, 2, 3])

class GW
  def go(x) = ($w = GW2.new; "a#{x}")
end
class GW2
  def go(x) = "b#{x}"
end
$w = GW.new
p [1, 2, 3].map(&$w.method(:go))

SET = []
class Pick
  def a(x) = (SET[0].call(:b); "a#{x}")
  def b(x) = "b#{x}"
end
m = :a
SET << ->(v) { m = v }
pk = Pick.new
p [1, 2, 3].map(&pk.method(m))

# a local nothing rewrites, a constant, a literal name and self stay as they were
class Show
  def show(x) = "show #{x}"
  def each_show(items) = items.map(&method(:show))
end
printer = Show.new
p [1, 2].map(&printer.method(:show))
SHOWER = Show.new
p [3, 4].map(&SHOWER.method("show"))
p Show.new.each_show([5, 6])
def plain_local(items)
  s = Show.new
  items.map(&s.method(:show))
end
p plain_local([7, 8])

# The receiver and the arguments run before the block argument is looked up,
# and may change what it reads.
class H
  def initialize = @w = W.new("a")
  def items = (@w = W.new("b"); [1, 2])
  def bump = (@w = W.new("c"); 2)
  def run = items.map(&@w.method(:go))
  def run_arg = [1, 2, 3].first(bump).map(&@w.method(:go))
end
p H.new.run
p H.new.run_arg

# An argument that acts may rewrite the receiver's read: the receiver is read first.
class H2
  def initialize = (@w = W.new("a"); @arr = [1, 2])
  def memo = (@arr = [9]; @w = W.new("b"); [])
  def run = @arr.each_with_object(memo, &@w.method(:go2))
end
class W
  def go2(x, memo) = (memo << "#{@t}#{x}")
end
p H2.new.run

# A splat argument that acts runs before the block argument is looked up.
class W3
  def initialize(t) = @t = t
  def go(x) = puts("#{@t}#{x}")
end
class H3
  def initialize = (@w = W3.new("a"); @arr = [1, 2])
  def sz = (@w = W3.new("b"); [1])
  def run = @arr.each_slice(*sz, &@w.method(:go))
end
H3.new.run
