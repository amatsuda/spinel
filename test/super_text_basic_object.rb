# A BasicObject subclass has no Kernel: its `def inspect = super` raises.
class B < BasicObject
  def inspect = super
end
begin; B.new.inspect; ::Kernel.puts "no error"; rescue ::NoMethodError; ::Kernel.puts "NoMethodError"; end

# With `include ::Kernel` it has Kernel's text, but still no Object.
class Object; def greet = "og"; end
class KB < BasicObject
  include ::Kernel
  def inspect = super
end
class KC < KB
  def greet = super
end
::Kernel.puts KB.new.inspect.sub(/0x\h+/, "X")
begin; KC.new.greet; ::Kernel.puts "no error"; rescue ::NoMethodError; ::Kernel.puts "NoMethodError"; end
