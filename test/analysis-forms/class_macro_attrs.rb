# Class-body macros that declare attributes: attr_* on self defines the
# instance's accessors, and on the singleton class (`singleton_class`, or
# `class << self; self; end`) the class's own, in a class or in a module.
module Settings
  def self.setting(name) = (class << self; self; end).attr_accessor(name)
  def self.readonly(name) = singleton_class.attr_reader(name)

  setting :level
  readonly :mode
  @mode = :fast
  self.level = 1
end
Settings.level += 2
p Settings.level, Settings.mode

class Point
  def self.coords(a, b) = attr_accessor(a, b)
  def self.reader(name) = attr_reader(name)
  def self.writer(name) = attr_writer("#{name}")

  coords :x, :y
  reader :tag
  writer :tag

  def initialize = (@x = 1; @y = 2; @tag = :p)
end
pt = Point.new
pt.y = 5
pt.tag = :q
p [pt.x, pt.y, pt.tag]
p Point.public_instance_methods(false).sort

# a singleton reader the instances reach through their class
class Status
  def self.code_reader(n) = (class << self; self; end).attr_reader(n)
  code_reader :code
  def code = self.class.code
end
class Ok < Status
  @code = 200
end
p Ok.new.code, Status.new.code

# a reader over an inherited method
class Base
  def r = :base
end
class Sub < Base
  def self.reader(n) = attr_reader(n)
  reader :r
  def initialize = @r = :sub
end
p Sub.new.r
