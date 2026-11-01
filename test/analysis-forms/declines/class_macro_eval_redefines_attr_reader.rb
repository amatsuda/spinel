# The class-body macro form declines: the macro's module_eval text defines
# self.attr_reader, which the macro's own attr_reader then calls.
class Base
  def self.mk(n)
    module_eval "def self.attr_reader(*a) = (puts 'own attr_reader'; nil)"
    attr_reader n
    define_method(:"#{n}_set") { |v| @x = v }
  end
end
class Foo < Base
  mk :ghost
end
p Foo.new.respond_to?(:ghost)
