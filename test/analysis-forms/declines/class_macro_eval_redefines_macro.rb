# The class-body macro form declines: the macro's module_eval text defines
# self.helper, which the macro then calls in place of Base's.
class Base
  def self.helper(n) = define_method(n) { 1 }
  def self.mk(n)
    module_eval "def self.helper(n) = (puts 'own helper'; nil)"
    helper n
  end
end
class Foo < Base
  mk :ghost
end
p Foo.new.respond_to?(:ghost)
