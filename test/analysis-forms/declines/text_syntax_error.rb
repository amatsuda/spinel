# The class-body macro form declines: the text a macro runs does not parse.
# CRuby raises SyntaxError where the call runs; the call stays as written.
class Model
  def self.gen(name) = module_eval("def #{name}(")
end
begin
  class Post < Model
    gen :broken
  end
rescue SyntaxError => e
  p e.class
end
