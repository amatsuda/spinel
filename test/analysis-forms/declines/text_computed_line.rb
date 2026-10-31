# The class-body macro form declines: the file and line a macro passes with
# its text are values it computes, not ones read where they are written
# (`__FILE__`, a String, `__LINE__`, `__LINE__ + k`, an Integer).
class Model
  def self.gen(name, line) = module_eval("def #{name} = __LINE__", "gen.rb", line)
end
class Post < Model
  gen :at, 7
end
p Post.new.at
