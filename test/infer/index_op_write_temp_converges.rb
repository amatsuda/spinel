# `node = node[key] ||= {}` on a boxed local, in a program with a class of
# its own `[]` and `[]=`, is spelled as temp writes (`__ixr = node; ...`)
# appended after the write. The write pass read the temp still reset on one
# round and settled on the next, so `node` went from a Hash to boxed and back
# every round, and the fixpoint ran to its 128-round cap.
class Box
  def [](k) = nil
  def []=(k, v)
    v
  end
end
Box.new

def add_error(errors, key)
  node = errors
  node = node[key] ||= {}
  errors
end

p add_error({ "s" => 1, :y => "v" }, :a)
