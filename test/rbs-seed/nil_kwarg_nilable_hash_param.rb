# A literal nil passed to a keyword parameter --rbs declares as a nilable
# Hash (`?h: Hash[Symbol, untyped]?`): the argument is held boxed before the
# Hash is read out of it, and the nil was written as the C scalar 0, which
# the boxed temp's initializer does not take, so the build failed (#10677).
module NilKwargHashSeed
  def self.size_of(h: nil)
    h.nil? ? "none" : h.size.to_s
  end
end
p NilKwargHashSeed.size_of(h: { a: 1 })
p NilKwargHashSeed.size_of(h: nil)
p NilKwargHashSeed.size_of
