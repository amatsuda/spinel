# A class's own instance method named const_get (or const_defined?), as an
# options object answers any key by name, is not what a class receiver's
# `const_get(name)` reaches: the run-time name still resolves over the
# program's constants.
class Options
  def initialize = @h = { const_get: "the key", const_defined?: "another" }
  def const_get = @h[:const_get]
  def const_defined? = @h[:const_defined?]
end

module Inflector
  def self.constantize(word) = Object.const_get(word)
end

class String
  def constantize = Inflector.constantize(self)
end

module FooHelper; end
module BarHelper; end

def helpers_for(list)
  list.flatten.map! do |m|
    case m
    when Module then m
    when String, Symbol then "#{m.to_s.capitalize}Helper".constantize
    else raise ArgumentError, "helper must be a String, Symbol, or Module"
    end
  end
end

p helpers_for([[FooHelper], "bar", :foo])
p Object.const_defined?(["Bar", "Helper"].join)
p Object.const_defined?(["Baz", "Helper"].join)
begin
  "BazHelper".constantize
rescue NameError => e
  puts "NameError #{e.name}"
end
o = Options.new
p o.const_get
p o.const_defined?

# an object's own const_get taking a name stays that object's
class Registry
  def initialize = @h = { "FooHelper" => "registered" }
  def const_get(name) = @h.fetch(name, "missing")
end
r = Registry.new
key = ["Foo", "Helper"].join
p r.const_get(key)
p r.const_get(key + "s")
