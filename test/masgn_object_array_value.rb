# A multiple assignment whose right side is one Array of a class's objects
# (`h[:a], h[:b] = pair`) hands each target one element, nil past the end.
# The first target took the whole Array and the rest nil when the targets
# were Hash or mixed-Array elements, and attribute targets were refused at
# compile time.

class Node
  attr_reader :id
  def initialize(id) = @id = id
  def inspect = "N#{@id}"
end

class Box
  attr_accessor :l, :r
end

S = Struct.new(:a, :b)

# Hash and mixed-Array element targets
pair = [Node.new(1), Node.new(2)]
h = {}
h[:a], h[:b] = pair
p h
c = [0, "x"]
c[1], c[0] = pair
p c

# attribute and Struct member targets
three = [Node.new(3), Node.new(4), Node.new(5)]
bx = Box.new
bx.l, bx.r = three
p bx.l.id, bx.r.id
s = S.new(nil, nil)
s.a, s.b = three
p s.a.id, s.b.id

# fewer elements than targets: the rest are nil
one = [Node.new(6)]
g = {}
g[:a], g[:b], g[:c] = one
p g
by = Box.new
by.l, by.r = one
p by.l.id, by.r

# a splat between the targets
four = [Node.new(7), Node.new(8), Node.new(9), Node.new(10)]
m = {}
m[:first], *mid, m[:last] = four
p m, mid.map(&:id)
n = {}
n[:first], *rest, n[:y], n[:z] = one
p n, rest

# an Array that can be nil
maybe = [Node.new(11), Node.new(12)]
maybe = nil if four.size > 10
k = {}
k[:a], k[:b] = maybe
p k

# the Array from an instance variable and from a parameter
class Bag
  def initialize = @items = [Node.new(13), Node.new(14)]
  def spread(into) = (into[:p], into[:q] = @items; into)
end
p Bag.new.spread({})
def spread(list, into) = (into[:p], into[:q] = list; into)
p spread([Node.new(15), Node.new(16)], {})
