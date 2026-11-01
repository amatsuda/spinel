# A super in a user exception's message reaches Exception#message, which
# comes before an Object reopening in the chain.
class Base < StandardError; end
class Child < Base
  def message = super + "!"
end
class Object
  def message = "obj"
  def greet = "hi"
end
begin
  raise Child, "boom"
rescue Child => e
  puts e.message
end
class Plain; end
class L < Plain
  def greet = super + "!"
end
p L.new.greet
