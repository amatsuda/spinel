# A class-body macro that runs text it computes as its class's code
# (module_eval / class_eval of a String): the text's defs, instance and
# singleton, take effect where the call stands, and `__FILE__` and
# `__LINE__` in the text answer the file and line the call gives.
class Model
  def self.field(name, types)
    module_eval <<-RUBY, __FILE__, __LINE__ + 1
      def #{name}
        [#{types.inspect}, __LINE__]
      end
      def self.#{name}_type = #{types.first.inspect}
    RUBY
  end

  def self.stamp(name)
    class_eval("def #{name}_at = [__FILE__, __LINE__]\n\ndef self.#{name}_where = __LINE__", "gen.rb", 40)
  end

  def self.timestamps
    stamp :created
    stamp :updated
  end

  def self.counter(name) = module_eval("def self.#{name}(x) = x + 1")
end

class Post < Model
  field :title, %i[string null]
  timestamps
  counter :bump
  LEVEL = bump(2)    # the class method the text defined, reached from the body
end

post = Post.new
p post.title, Post.title_type
p post.created_at, post.updated_at, Post.created_where
p Post.bump(41), Post::LEVEL
p Post.instance_methods(false).sort, Post.singleton_methods.sort
