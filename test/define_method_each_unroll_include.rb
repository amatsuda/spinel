# A define_method an `each` over literals unrolls in a module reads the loop
# variable as each element's literal in every class that includes the
# module. The includer's copy of the method dropped the substitution and
# read the variable as an unset local: nil, so `n.to_s * 2` answered "" and
# `n * 10` raised NoMethodError.
module Twice
  %i[p q].each { |n| define_method(n) { n.to_s * 2 } }
end

class One
  include Twice
end
p One.new.p, One.new.q

# a second includer gets its own copy, reading the same literal
class Two
  include Twice
end
p Two.new.p, Two.new.q

# a module built by Module.new
Built = Module.new do
  %i[r s].each { |n| define_method(n) { n.to_s * 2 } }
end
class Three
  include Built
end
p Three.new.r, Three.new.s

# a module that includes the loop module, included in turn
module Outer
  include Twice
end
class Four
  include Outer
end
p Four.new.p, Four.new.q

# a String table and an Integer table
module Tables
  %w[x y].each { |s| define_method("get_#{s}") { s * 3 } }
  [1, 2].each { |i| define_method("times_#{i}") { i * 10 } }
end
class Five
  include Tables
end
f = Five.new
p f.get_x, f.get_y, f.times_1, f.times_2

# the loop variable beside the method's own block argument
module Ops
  %i[add sub].each { |op| define_method(op) { |x| op == :add ? x + 1 : x - 1 } }
end
class Six
  include Ops
end
p Six.new.add(5), Six.new.sub(5)

# an alias of the includer's copy
class Seven
  include Twice
  alias_method :pp2, :p
end
p Seven.new.pp2
