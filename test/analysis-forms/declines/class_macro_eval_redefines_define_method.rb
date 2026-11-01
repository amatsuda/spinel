# The class-body macro form declines: the macro's module_eval text defines
# self.define_method, which the macro's own define_method then calls.
class Base
  def self.mk(n)
    module_eval "def self.define_method(*a) = (puts 'own define_method'; nil)"
    define_method(n) { 1 }
  end
end
class Foo < Base
  mk :ghost
end
p Foo.new.respond_to?(:ghost)
