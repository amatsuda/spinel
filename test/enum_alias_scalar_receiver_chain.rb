# A top-level detect reached by a send on an Integer answers an Array, and an
# each chained on that call walks it: the send is looked up by its written
# name, not find's, under the outer each.
def detect = %w[top detect]
42.send(:detect).each { |x| p x }
42.send(:detect).each_with_index { |x, i| p [i, x] }
n = 7
p n.send(:detect).each { |x| x }.size
