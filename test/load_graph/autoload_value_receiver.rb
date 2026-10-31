# autoload on a value no module can be is not a registration: a program's
# own method of the name runs, and Object's private Kernel#autoload raises
# NoMethodError; neither loads the file. A constant holding such a value
# is no different.
class UserAuto
  def autoload(name, path) = puts("user autoload #{name}")
end
UserAuto.new.autoload(:X, File.join(__dir__, "autoload_value_receiver_lib"))
INST = UserAuto.new
INST.autoload(:Z, File.join(__dir__, "autoload_value_receiver_lib"))
begin
  Object.new.autoload(:Y, File.join(__dir__, "autoload_value_receiver_lib"))
rescue NoMethodError => e
  p e.class
end
puts "done"
