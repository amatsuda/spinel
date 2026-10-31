# A class-body macro's statements left as written read each local as it
# stood when the statement ran, as CRuby's do; its define_method blocks read
# the local as the macro left it, the binding they close over.
LOG = []
class Counter
  def self.m(n, tag = :t, f = true)
    x = 1
    LOG << x                  # 1, though x is 3 when the macro returns
    x = 2
    LOG << [n, x]
    define_method(n) { x }    # 3: the block reads the binding afterwards
    x = 3
    LOG.push(tag)             # a parameter, before it is rebound
    tag = :"#{tag}_2"
    LOG.push(tag)
    k = :one
    if f
      LOG << k                # inside a branch the macro takes
      k = :two
    end
    LOG << k
    i = 10
    [1, 2].each { |v| LOG << v + i }   # a block that runs at once, i not rewritten
  end
  m :a
  m :b, :u, false
end
p LOG
p Counter.new.a, Counter.new.b

class Twice
  def self.mk(n)
    s = "a#{n}"
    LOG << "#{s}:"            # its bytes at this point
    s = "b#{n}"
    define_method(n) { s }    # the String the second write made, one object
  end
  mk :x
end
t = Twice.new
t.x << "!"
p t.x, LOG.last
