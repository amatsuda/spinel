# The class-body macro form declines: a statement it would leave as written
# writes an instance variable of the class (a module body's are rewritten
# before the walk).
module Reg
  def self.mk(n)
    @last = n
    define_method(n) { 1 }
  end
  mk :a
  def self.last = @last
end
p Reg.last
