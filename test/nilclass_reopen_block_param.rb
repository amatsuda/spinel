# A NilClass method that takes a block parameter, called on nil, gets the
# block (or nil) in that parameter: ActiveSupport's `def try(*, &) = nil`.
class NilClass
  def try(*, &)
    nil
  end

  def with_block(x = 0, &blk)
    blk ? blk.call(x) : "no block #{x}"
  end

  def anon_only(&) = :anon
end

p nil.try
p nil.try(:name, 1)
p nil.try { 1 }
p nil.with_block
p nil.with_block(3)
p nil.with_block(4) { |v| v * 10 }
pr = proc { |v| v + 1 }
p nil.with_block(5, &pr)
p nil.anon_only
def maybe(i) = [nil, 1][i]
p maybe(0).try(:succ)
