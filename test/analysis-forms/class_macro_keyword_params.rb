# Class-body macros with optional and keyword parameters: an optional one
# takes its default when the call leaves it out, a keyword default can read
# the parameters before it, and a passed keyword wins over its default.
class Column
  def self.column(name, type = :string, null: true, default: "#{name}_#{type}", width: default.size)
    define_method(name) { "#{default}/#{width}/#{null}" }
    define_method(:"#{name}_type") { type }
  end

  column :title
  column :count, :integer
  column :body, null: false
  column :tag, :symbol, default: "x", width: 9
end

c = Column.new
p c.title, c.count, c.body, c.tag
p c.title_type, c.count_type, c.tag_type

module Flags
  def flag(name, on: false) = define_method(:"#{name}?") { on }
end
class Opts
  extend Flags
  flag :color
  flag :pager, on: true
end
p [Opts.new.color?, Opts.new.pager?]
