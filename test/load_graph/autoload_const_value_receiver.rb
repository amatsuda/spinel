# Values no module can be: Object.new, an instance of a program class (or
# its subclass) whose chain reaches Object through program classes alone,
# directly or through a constant. Their autoload is Object's private
# Kernel#autoload, which raises NoMethodError and loads nothing.
class Plain; end
class PlainSub < Plain; end
INST = Object.new
PLAIN = PlainSub.new
begin
  INST.autoload(:X, File.join(__dir__, "autoload_const_value_receiver_lib"))
rescue NoMethodError => e
  p e.class
end
begin
  Plain.new.autoload(:X, File.join(__dir__, "autoload_const_value_receiver_lib"))
rescue NoMethodError => e
  p e.class
end
begin
  PLAIN.autoload(:X, File.join(__dir__, "autoload_const_value_receiver_lib"))
rescue NoMethodError => e
  p e.class
end
p defined?(X)
puts "done"
