# Class-body macros whose body does more than define: a statement the
# compile-time evaluator leaves alone runs where the call stands, in its
# order among the definitions, with the macro's parameters as their values.
class Markdown
  EXTENSIONS = []
  LOG = []

  def self.extension(name)
    EXTENSIONS << name
    define_method(:"#{name}?") { EXTENSIONS.include?(name) }
    LOG.push(EXTENSIONS.size)
  end

  extension :css
  extension :tables
end
p Markdown::EXTENSIONS, Markdown::LOG, Markdown.new.css?

# a String the macro made is one object, which every call of the method
# answers; one the class's name is, is the name's own object
class Model
  def self.key(n)
    k = "#{self.name.downcase}_#{n}"
    nm = self.name
    shown = inspect
    define_method(n) { k }
    define_method(:"#{n}_name") { nm }
    define_method(:"#{n}_shown") { shown }
  end
  k = :body_local
  key :a
  key :b
  p k
end
m = Model.new
p m.a, m.b, m.a.equal?(m.a), m.a.frozen?
m.a << "!"
p m.a, m.b
p m.a_name.equal?(Model.name), m.b_shown
