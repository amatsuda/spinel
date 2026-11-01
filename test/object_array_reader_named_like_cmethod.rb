# A reader call on an element, named like a class method whose body walks
# the elements, kept the Array boxed and the call a dispatch by name
# (#10700): narrow_object_arrays killed the slot the class method's
# parameter is when the element's `amount` resolved to no method scope,
# an attribute reader being none, and its name's kill took every slot of
# the name. A reader of the element's class is a read of its ivar: no
# edge, no kill. A Symbol an attr_reader / attr_accessor spells declares
# the reader and reads nothing, so it keeps no walk's value "read" either.
class Deal
  attr_reader :amount
  attr_accessor :tag
  def initialize(a) = (@amount = a; @tag = :none)
end
class Other
  def amount = 100
end
module Fn
  def self.amount(list, out)
    sum = 0
    list.each do |d|
      sum += d.amount
      out << d
    end
    sum
  end
  def self.tag(list) = list.each { |d| d.tag = :seen }
  def self.first_amount(list) = list[0].amount
end
out = []
p Fn.amount([Deal.new(1), Deal.new(2)], out)
p out.length
Fn.tag(out)
p out.map(&:tag)
p Fn.first_amount(out)
# a mixed list still dispatches by class
mixed = [Deal.new(5), Other.new]
p Fn.amount(mixed, [])
# a Symbol that really reads the name
p out.sum(&:amount)
p out.first.send(:amount)
