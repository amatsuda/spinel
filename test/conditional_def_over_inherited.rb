# A def under a condition only the run time decides, of a name a superclass,
# an inherited reader, Kernel's to_s or an included module answers: when its
# branch did not run, that method answers, as in CRuby; so does the
# NoMethodError past them, also through a module a module includes, past a
# prepended module, and naming a Class.new class as CRuby names it.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
$off = !$on

class Base
  def hi = 10
end
class Skip < Base
  def hi = super + 1 if $off
end
class Take < Base
  def hi = super + 1 if $on
end
p Skip.new.hi, Take.new.hi

class Plain
  def to_s = "plain" if $off
end
class Named
  def to_s = "named" if $on
end
p Plain.new.to_s.start_with?("#<Plain")
p Named.new.to_s

class A
  def foo = :a
end
class B < A
  if $off
    def foo = :b
  end
end
p B.new.foo

class Parent
  attr_reader :bar
  def initialize = @bar = :inherited
end
class Child < Parent
  if $off
    def bar = :child
  end
end
p Child.new.bar

module Mixed
  def m = 1 if $off
  def n = 2
end
class Own
  include Mixed
  def m = 3
end
class Bare
  include Mixed
end
p Own.new.m, Bare.new.n
begin
  Bare.new.m
rescue NoMethodError => e
  puts e.message
end
module Deep
  [].each { def dm = :dm }
end
module Deeper
  include Deep
end
class Holder
  include Deeper
end
begin
  Holder.new.dm
rescue NoMethodError => e
  puts e.message
end
class PBase
  def pm = :base
end
module Pre
  def pm = :pre if $off
end
class PSub < PBase
  prepend Pre
end
p PSub.new.pm
anon = Class.new { def am = 1 if $off }
begin
  anon.new.am
rescue NoMethodError => e
  puts e.message.sub(/0x\h+/, "0x")
end
