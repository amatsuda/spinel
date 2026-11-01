# The class-body macro form declines: a def in the text a macro runs holds an
# operator write (desugar_reopened_op_write reads each one before the walk,
# for a program that reopens a builtin's operator).
class Model
  def self.counter(name) = module_eval("def #{name}! = (@#{name} = (@#{name} || 0)) && (@#{name} += 1)")
end
class Post < Model
  counter :hits
end
post = Post.new
post.hits!
p post.hits!
