# A constant written `Array.new(n) { Obj.new }` narrows like a literal one
# `NONE = Array.new(0) { Callback.new(nil) }` -- an Array seeded with its
# element class and left empty, so a method reading it is typed -- was
# refused once constants holding object tables narrowed: the constant
# became an sp_PtrArray, the Array.new call was still emitted at its own
# poly type, and no conversion keeps a poly array in that slot. Inference
# also widened the constant back to the call's type every round, so the
# fixpoint never settled. The constant is now built in place at its kind,
# as a local, an ivar and a method's return already are.

class Cb
  attr_reader :name
  def initialize(name) = (@name = name)
end

NONE = Array.new(0) { Cb.new(nil) }
PAIR = Array.new(2) { |i| Cb.new(:"c#{i}") }

module Reg
  EMPTY = Array.new(0) { Cb.new(:x) }
  def self.size = EMPTY.size
end

def first_name(list) = list.empty? ? nil : list[0].name

def names(list)
  out = []
  list.each { |cb| out << cb.name }
  out
end

skips = {}.empty? ? NONE : [Cb.new(:y)]
p NONE.size, first_name(NONE), first_name(skips)
p PAIR.size, first_name(PAIR), names(PAIR)
p Reg.size, Reg::EMPTY.empty?
