# Methods whose versions may not have run, beside the forms the named
# entry leaves alone or answers by the receiver: a prepended module's
# method still runs first and its super reaches the version; an
# initialize the constructor calls directly; a class body with a rescue
# clause; reflection on a class that holds no such history; and the forms
# that keep their answer as they had it: an `if` def in an iterator's
# block, also of a builtin's name, asked by reflection, an `if` group in
# a Class.new block, a method a bare call names, Method and
# UnboundMethod objects of a version that ran, and a module's version
# that ran, through a module that includes it or included twice.
$t = ARGV.size == 0
$f = !$t

module Pre
  def m = [:pre, super]
end
class A
  prepend Pre
  [1].each { def m = :a }
end
p A.new.m

class B
  [1].each { def initialize(x) = @x = x }
  def x = @x
end
p B.new(5).x

class C
  [1].each { define_method(:m) { 1 } }
  define_method(:k) { 2 } if $t
rescue
end
p C.new.m
p C.new.k

class D
  $f ? (def q = 1) : nil
  case ARGV.size
  when 5 then def zz = 1
  end
end
class E
  def q = 2
end
class F
  def k = 3
end
p E.new.respond_to?(:q)
p E.method_defined?(:q)
p E.instance_methods(false)
p F.instance_methods(false)
p F.new.respond_to?(:k)
begin
  p D.new.q
rescue NoMethodError => e
  puts e.message
end

class G
  [1].each { if $t then def m = 1 end }
  [1].each { if $t then def hash = 7 end }
end
p G.new.respond_to?(:m)
p G.instance_methods(false).sort
p G.new.method(:m).call
p G.new.hash
H = Class.new do
  if $t then def m = 1 else def m = 2 end
end
p H.new.respond_to?(:m)
p H.new.m
class J
  [1].each { def j = :j }
  def go = j
end
p J.new.go
class K
  [1].each { def n = 2 }
end
p K.instance_method(:n).name
p K.instance_method(:n).bind(K.new).call
p K.new.method(:n).unbind.bind(K.new).call
p K.new.method(:n).arity
module KM
  [1].each { def km = :km }
end
module KM2
  include KM
end
class KC
  include KM2
end
class KD
  include KM
  include KM
end
p KC.new.km, KD.new.km
