# The class-body macro form declines: the text a macro runs holds a statement
# other than a def (an attr, which steps before the walk read in a class
# body). Only defs are taken from text.
class Model
  def self.prop(name) = class_eval("attr_accessor :#{name}\ndef #{name}? = !#{name}.nil?")
end
class Post < Model
  prop :title
end
post = Post.new
post.title = "x"
p post.title, post.title?
