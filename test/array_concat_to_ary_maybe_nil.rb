# spinel: gc-stress
$events = []
class ConcatOptionalSource
  def initialize(items) = @items = items
  def to_ary
    $events << :convert
    @items
  end
end
a = [0]
a.concat(ConcatOptionalSource.new([1]), [3])
p a
b = [0]
begin
  b.concat(ConcatOptionalSource.new(nil), [3])
rescue => error
  p error.class
  p error.message
end
p b
p $events
