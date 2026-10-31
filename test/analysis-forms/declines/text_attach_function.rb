# The class-body macro form declines: the text a macro runs declares an ffi
# function (desugar_ffi_library_functions reads each attach_function before
# the walk, and text a macro computes is only known in it).
require "ffi"
module Binder
  def bind(name)
    module_eval <<-RUBY, __FILE__, __LINE__ + 1
      def self.attach_#{name} = attach_function(:#{name}, [:long], :long)
    RUBY
  end
end
class Libc
  extend FFI::Library
  extend Binder
  bind :labs
  ffi_lib FFI::Library::LIBC
  attach_labs
end
p Libc.labs(-4)
