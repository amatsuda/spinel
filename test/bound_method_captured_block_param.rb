# A method called through its bound Method, whose iteration block's parameter
# an inner block captures (the inner block runs through a call on a value of
# more than one class): the parameter's cell and the plain slot the loop binds
# are each declared once in the bound method's frame. (WEBrick's
# TimeoutHandler#watch, started as Thread.start(&method(:watch)).)
class Pair
  def initialize(*a) = @a = a
  def each(&b) = @a.each(&b)
end

class Handler
  def initialize = @info = { 1 => [[0.0, :e]], 2 => Pair.new([0.5, :f]), 3 => nil }

  def watch
    out = []
    @info.each { |thread, ary|
      next unless ary
      ary.each { |info| out.push [thread, info[1]] }
    }
    out
  end
end

h = Handler.new
p h.method(:watch).call
p Thread.start(&h.method(:watch)).value
