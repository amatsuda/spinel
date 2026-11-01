# The class-body macro form declines: a def in the text a macro runs reads a
# constant (qualify_colliding_consts and refuse_unreachable_bare_constants
# read every constant reference before the walk).
class Model
  KINDS = %i[a b].freeze
  def self.kind_reader(name) = module_eval("def #{name} = KINDS.first")
end
class Post < Model
  kind_reader :kind
end
p Post.new.kind
