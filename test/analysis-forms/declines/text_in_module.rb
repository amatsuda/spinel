# The class-body macro form declines: text a macro runs in a module's body
# (desugar_extend_self and desugar_module_function_aliases read a module's
# defs before the walk).
module Macros
  def reader(name) = module_eval("def #{name} = :#{name}")
end
module Helpers
  extend Macros
  extend self
  reader :help
end
p Helpers.help
