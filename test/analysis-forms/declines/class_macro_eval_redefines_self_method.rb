# The class-body macro form declines: the macro's first module_eval text
# defines self.module_eval, which its second module_eval then calls.
class Base
  def self.mk(n)
    module_eval "def self.module_eval(*a) = (puts 'own module_eval'; nil)"
    module_eval "def #{n} = 1"
  end
end
class Foo < Base
  mk :ghost
end
p Foo.new.respond_to?(:ghost)
