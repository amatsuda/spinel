# A constant written `Array.new(n) { Obj.new }` narrows to an object table.
# infer_global_const_types merged the call's general Array type back into the
# constant every round, narrow_object_arrays narrowed it again, and the
# fixpoint ran to its round cap. The program still compiles and prints the
# right answer when that happens, so test/object_array_constant_array_new.rb
# cannot see it; this counts the rounds.
class Cb
  attr_reader :name
  def initialize(name) = (@name = name)
end

NONE = Array.new(0) { Cb.new(nil) }

def first_name(list) = list.empty? ? nil : list[0].name

p NONE.size, first_name(NONE)
