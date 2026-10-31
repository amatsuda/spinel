# spinel: gc-stress
$events = []
class BoxedConcatSource
  def to_ary
    $events << :convert
    [2]
  end
end
items = [1, "s"]
a = [items, 0].first
a.concat(BoxedConcatSource.new, [3])
p a
p $events
$events = []
items = [1, "s"]
a = [items, 0].first
result = a.concat(BoxedConcatSource.new, [3])
p result
p result.equal?(a)
p $events

# A run-time choice keeps this Integer Array receiver boxed.
def boxed_concat_int_receiver(a)
  ARGV.empty? ? a : 0
end
class BoxedConcatMutator
  def initialize(a) = @a = a
  def to_ary
    $events << :convert
    @a << 9
    [2]
  end
end
$events = []
ints = [1]
a = boxed_concat_int_receiver(ints)
result = a.concat(BoxedConcatMutator.new(a), [3])
p a
p result.equal?(a)
p $events
