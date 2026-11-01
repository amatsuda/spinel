# A `*rest` parameter written inside a block, in a method that opens with a
# def: the copy prepended to the body swaps numbers with the first statement
# that is not a def, so the `...` forwarder defined first still forwards.
def outer(*args)
  def helper(...) = target(...)
  def target(a, b) = p(a + b)
  [1].each { args = args.map { |x| x + 1 } }
  p args
end
outer(1, 2)
helper(3, 4)
