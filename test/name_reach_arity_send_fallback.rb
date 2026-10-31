# A send on a boxed receiver whose class does not define the name runs the
# top-level method of that name, Object's private one, and that method stays
# compiled when it takes another count than the call passes: the call raises
# its ArgumentError. Reachability kept only the methods of the dispatch's
# arms, and the C called a function it no longer had.
def foo(a, b) = "top #{a} #{b}"
def bar(a) = "top bar #{a}"

class A
  def foo(a) = "A #{a}"
  def bar(a) = "A bar #{a}"
end

class B
end

xs = [A.new, B.new]
begin
  puts xs[1].send(:foo, 1)
rescue ArgumentError => e
  puts "ArgumentError: #{e.message}"
end
begin
  puts xs[1].__send__(:foo)
rescue ArgumentError => e
  puts "ArgumentError: #{e.message}"
end
xs.each { |x| puts x.send(:bar, 3) }
