# The class-body macro form declines a macro that copies a String it was
# handed into a local its block reads: the define_method in a method body
# stays a run-time one (the local's identity with the parameter shows only
# there, and CRuby answers "a1!").
class Base
  def self.mk(s0)
    s = s0
    define_method(:px) { s }
  end
end
class Foo < Base
  mk "a#{1}"
end
f = Foo.new
f.px << "!"
p f.px
