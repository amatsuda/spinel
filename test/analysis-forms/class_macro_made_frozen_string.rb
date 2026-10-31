# A class-body macro whose block answers a frozen String a method made (the
# class's name): the call's statements read the name again, the same object.
class Base
  def self.label(n)
    s = self.name
    define_method(n) { s }
  end
end
class Foo < Base
  label :who
end
x = Foo.new.who
p x, x.frozen?, x.equal?(Foo.name), x.equal?("Foo")
