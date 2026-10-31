# spinel: gc-stress
# A single converted Integer Array uses the same append as a typed one:
# nil bits and self operands survive the move.
class ConcatSource
  def initialize(xs)
    @xs = xs
  end
  def to_ary
    GC.start
    @xs
  end
end
def concat_boxed(a, x)
  a.concat(x)
end
xs = [1, 2, 3]
xs[1] = nil
x = [ConcatSource.new(xs), 0].first
a = [4, 5]
a.shift
p concat_boxed(a, x).equal?(a)
p a
y = [ConcatSource.new(xs), 0].first
p concat_boxed(xs, y)

# An empty operand does not modify the receiver. Freezing it during the
# conversion therefore raises only when the operand contributes elements.
$concat_target = [7]
class ConcatFreezer
  def to_ary
    $concat_target.freeze
    xs = [9]
    xs.clear
    GC.start
    xs
  end
end
z = [ConcatFreezer.new, 0].first
p concat_boxed($concat_target, z)
p $concat_target.frozen?

# Empty, singleton and pair sources use their captured length. Numeric nils,
# shifted sources and destinations, and the receiver itself keep their values.
def concat_integer(a, b)
  a.concat(b)
end
p concat_integer([0], [])
p concat_integer([0], [1])
p concat_integer([0], [1, 2])
single = [1, 2]
single.shift
single[0] = nil
dest = [3, 4]
dest.shift
p concat_integer(dest, single)
p concat_integer(single, single)
p concat_boxed([0], [[], 0].first)
p concat_boxed([0], [[1], 0].first)
p concat_boxed([0], [[1, 2], 0].first)
