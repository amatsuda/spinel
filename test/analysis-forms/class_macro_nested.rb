# Class-body macros that call other macros: each runs in a frame of its own,
# with its own parameters and locals, and what it defines lands where the
# outer call stands, in the order the calls ran. A keyword argument passes
# through, and two frames' locals of one name stay apart.
module Fields
  def field(name, kind: :str)
    label = "#{name}:#{kind}"
    define_method(name) { label }
  end

  def stamp(name)
    field :"#{name}_at", kind: :time
    field :"#{name}_by"
  end

  def stamps
    stamp :created
    stamp :updated
  end
end

class Post
  extend Fields
  field :title
  stamps   # the body's last statement: the last method stamps defines answers it
end

post = Post.new
p post.title, post.created_at, post.created_by, post.updated_at, post.updated_by
p Post.instance_methods(false).sort
p post.created_at.equal?(post.created_at), post.created_at.frozen?

# a chain of sixteen macro frames, the most the form runs
class Deep
  def self.m1(n) = m2(n)
  def self.m2(n) = m3(n)
  def self.m3(n) = m4(n)
  def self.m4(n) = m5(n)
  def self.m5(n) = m6(n)
  def self.m6(n) = m7(n)
  def self.m7(n) = m8(n)
  def self.m8(n) = m9(n)
  def self.m9(n) = m10(n)
  def self.m10(n) = m11(n)
  def self.m11(n) = m12(n)
  def self.m12(n) = m13(n)
  def self.m13(n) = m14(n)
  def self.m14(n) = m15(n)
  def self.m15(n) = m16(n)
  def self.m16(n) = define_method(n) { n }
  m1 :deep
end
p Deep.new.deep

