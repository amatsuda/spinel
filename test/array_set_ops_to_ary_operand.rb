# Array#replace, #union, #difference and #intersection with a program
# object whose class answers #to_ary with an Array: the operand converts
# through it, as for + - | & and concat (desugar_array_op_to_ary), where
# the call raised NoMethodError.
$conversions = 0
class SetSource
  def initialize(items) = @items = items

  def to_ary
    $conversions += 1
    @items
  end
end
a = [1, 2, 3]
p a.union(SetSource.new([3, 4]))
p a.difference(SetSource.new([2]))
p a.intersection(SetSource.new([2, 3, 5]))
b = [9]
p b.replace(SetSource.new([7, 8]))
p b
p $conversions
