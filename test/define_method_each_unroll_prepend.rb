# A define_method an `each` over literals unrolls in a module reads the loop
# variable as each element's literal in every class that prepends the
# module. The prepended copy dropped the substitution, and its C read a
# local the method does not declare, so the program did not compile.
module Twice
  %i[p q].each { |n| define_method(n) { n.to_s * 2 } }
end

class One
  prepend Twice
end
p One.new.p, One.new.q

# prepended to two classes, each copy calling its class's own method
module Wrap
  %i[a b].each { |n| define_method(n) { n.to_s * 2 + super() } }
end
class Two
  prepend Wrap
  def a = "2a"
  def b = "2b"
end
class Three
  prepend Wrap
  def a = "3a"
  def b = "3b"
end
p Two.new.a, Two.new.b, Three.new.a, Three.new.b

# an alias of an included copy keeps the literal where a subclass redefines
# the old name
module Inc
  %i[c d].each { |n| define_method(n) { n.to_s * 2 } }
end
class Four
  include Inc
  alias_method :c2, :c
end
class Five < Four
  def c = "own"
end
p Five.new.c2, Five.new.c, Four.new.c
