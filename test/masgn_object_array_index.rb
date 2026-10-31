# A multiple assignment stores into the elements of an Array of one class's
# objects (`list[0], list[1] = list[1], list[0]`), which was refused at
# compile time: a swap, a rotation, indices read before the stores, negative
# indices, an index past the end, and the IndexError of an index below the
# start.

class Node
  attr_reader :id, :links
  def initialize(id) = (@id = id; @links = [])
end

def ids(list) = list.map(&:id)

nodes = Array.new(4) { |i| Node.new(i) }
nodes.each_with_index do |node, i|
  a = nodes[(i + 1) % 4]
  b = nodes[(i + 2) % 4]
  node.links << a
  node.links << b
end

first = nodes[0]
first.links[0], first.links[1] = first.links[1], first.links[0]
p ids(first.links)
total = 0
first.links.each { |l| total += l.id }
p total

# a swap by computed indices, and a rotation of three
a = [Node.new(10), Node.new(11), Node.new(12)]
i = 0
j = a.size - 1
a[i], a[j] = a[j], a[i]
p ids(a)
a[0], a[1], a[2] = a[1], a[2], a[0]
p ids(a)

# an index is read before any target is assigned, as CRuby reads it
i = 0
i, a[i] = 1, Node.new(13)
p i, ids(a)
j = 2
a[j], j = Node.new(14), 0
p j, ids(a)
k = 0
k, a[k], a[k + 1] = 2, a[1], a[0]
p k, ids(a)

# negative indices, and a store past the end that grows the Array
a[-1], a[-3] = a[-3], a[-1]
p ids(a)
b = [Node.new(20)]
b[1], b[0] = b[0], Node.new(21)
p ids(b), b.size

# the elements read back as their class
p a[0].id + b[1].id

# an index below the start raises IndexError
begin
  b[-5], b[0] = b[0], b[1]
rescue IndexError => e
  p e.message
end
p ids(b)
