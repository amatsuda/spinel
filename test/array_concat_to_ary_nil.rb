# spinel: gc-stress
$events = []
class ConcatNilSource
  def to_ary
    $events << :convert
    nil
  end
end
a = [0]
begin
  a.concat(ConcatNilSource.new, [3])
rescue => error
  p error.class
  p error.message
end
p a
p $events
