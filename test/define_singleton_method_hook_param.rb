# A define_singleton_method on a hook's parameter (`base` in `self.included`
# or `self.extended`) defines its method on whatever the hook is run for, not
# on main: no bare call, respond_to? or private_method_defined? at the top
# level sees it, and a top-level method of the same name stays that method.

def helper(x) = "main #{x}"

module Greeting
  def self.included(base)
    base.define_singleton_method(:helper) { |x| "single #{x}" }
    base.define_singleton_method(:kind) { base.name.downcase }
  end
end

module Peeking
  def self.extended(base)
    base.define_singleton_method(:peek) { :peeked }
  end
end

module Keyed
  def self.included(base, tag: 1)
    base.define_singleton_method(:keyed) { :keyed }
  end
end

module Blocky
  def self.included(base, &blk)
    base.define_singleton_method(:blocky) { :blocky }
  end
end

module InBlock
  def self.included(base)
    [1].each { base.define_singleton_method(:inblock) { :ib } }
  end
end

class A; include Greeting; end
class B; include Greeting; end
class P; extend Peeking; end
class K; include Keyed; end
class L; include Blocky; end
class M; include InBlock; end

puts helper(1)
puts A.helper(2)
puts A.kind, B.kind
puts P.peek
puts K.keyed, L.blocky, M.inblock

# nothing was defined at main, on Object, or on a class the hook never ran for
puts((begin; kind; rescue NameError => e; e.class; end))
puts((begin; peek(); rescue NoMethodError => e; e.class; end))
puts((begin; Object.new.send(:peek); rescue NoMethodError => e; e.class; end))
puts "kind: #{respond_to?(:kind, true)} #{Object.private_method_defined?(:kind)} #{Object.new.respond_to?(:kind, true)}"
puts "peek: #{respond_to?(:peek, true)} #{Object.private_method_defined?(:peek)} #{Object.new.respond_to?(:peek, true)}"
puts "keyed: #{respond_to?(:keyed, true)} #{Object.private_method_defined?(:keyed)} #{Object.new.respond_to?(:keyed, true)}"
puts "blocky: #{respond_to?(:blocky, true)} #{Object.private_method_defined?(:blocky)} #{Object.new.respond_to?(:blocky, true)}"
puts "inblock: #{respond_to?(:inblock, true)} #{Object.private_method_defined?(:inblock)}"
puts [A.respond_to?(:peek), P.respond_to?(:kind), A.respond_to?(:helper)].inspect

# a local bound to one object stays a traced singleton
class Foo; end
o = Foo.new
o.define_singleton_method(:one) { 1 }
puts o.one
puts Foo.new.respond_to?(:one)
puts respond_to?(:one, true)
