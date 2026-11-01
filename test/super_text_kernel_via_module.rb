# A BasicObject subclass that includes a module which includes Kernel has
# Kernel's text for `def inspect = super`.
module Km
  include ::Kernel
end
class KM < BasicObject
  include ::Km
  def inspect = super
end
::Kernel.puts KM.new.inspect.sub(/0x\h+/, "X")
module Deep
  include ::Km
end
class KD < BasicObject
  include ::Deep
  def to_s = super
end
::Kernel.puts KD.new.to_s.sub(/0x\h+/, "X")
