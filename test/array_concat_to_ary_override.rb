# spinel: gc-stress
$events = []
class ConcatParentSource
  def to_ary
    $events << :parent
    [1]
  end
end
class ConcatChildSource < ConcatParentSource
  def to_ary
    $events << :child
    [2]
  end
end
parent = ConcatParentSource.new
child = ConcatChildSource.new
a = [0]
a.concat(parent, [3])
p a
b = [0]
b.concat(child, [3])
p b
p $events
