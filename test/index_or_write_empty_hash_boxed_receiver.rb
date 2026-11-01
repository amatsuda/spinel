# `node = node[key] ||= {}` on a boxed local, in a program with a class of its
# own `[]` and `[]=`, is spelled as calls through the box. The empty `{}` it
# stores had no slot its later key operations reached, so it took the
# String-keyed default and the next level's Symbol key raised TypeError.
class Box
  def [](k) = nil
  def []=(k, v)
    v
  end
end
Box.new

h = {}
node = h
node = node[:a] ||= {}
node = node[:b] ||= {}
node[:c] = 1
p h
