# The class-body macro form declines: a block in a statement it would leave
# as written reads a local the macro writes again afterwards. The block may
# run after the macro returns (here a lambda kept in a constant), when it
# reads the local as the macro left it, not as it stood at the statement.
HANDLERS = []
class A
  def self.m(n)
    i = 1
    HANDLERS << -> { i }
    i = 100
    define_method(n) { i }
  end
  m :a
end
p HANDLERS.map(&:call), A.new.a
