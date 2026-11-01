# The class-body macro form declines: the text a macro runs defines a hook
# (desugar_inherited_hooks reads `def self.inherited` before the walk).
class Model
  def self.track = module_eval("def self.inherited(sub) = (@subs ||= []) << sub.name")
  def self.subs = @subs
end
class Base < Model
  track
end
class Leaf < Base; end
p Base.subs
