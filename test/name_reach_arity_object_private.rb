# A call with arguments on a boxed receiver whose class does not define the
# name, where the Object reopening's method of that name takes another
# count and is private or protected: an explicit receiver is refused for
# the method's visibility before its count (NoMethodError, the receiver
# named as CRuby names it; a method made private before the call can run
# counts as private), public_send refuses a protected one too, and send or
# a protected call from any caller reaches the count's ArgumentError. The
# dispatch's default called a method reachability had dropped, and the C
# did not compile. A Kernel private name (test, syscall) reopened private
# on Object reads "private method 'name' called for ..." on both paths: the
# poly dispatch's default and the boxed refusal of a count that fits.
class Object
  private def foo(a, b) = "private #{a} #{b}"
  protected def bar(a, b) = "protected #{a} #{b}"
  def baz(a, b) = "made private #{a} #{b}"
  private :baz
end

class A
  def foo(a) = "A #{a}"
  def bar(a) = "A bar #{a}"
  def baz(a) = "A baz #{a}"
end

class B
end

def try
  puts yield
rescue NoMethodError, ArgumentError => e
  puts "#{e.class}: #{e.message}"
end

[A.new, B.new, 5, nil, true, Integer].each do |x|
  try { x.foo(1) }
  try { x.public_send(:foo, 2) }
  try { x.send(:foo, 3) }
  try { x.bar(4) }
  try { x.public_send(:bar, 5) }
  try { x.baz(6) }
end

class Object
  private def syscall(a, b, c) = "kernel name #{a} #{b} #{c}"
end

class A
  def syscall(a) = "A syscall #{a}"
end

[A.new, B.new, 5, nil, Integer].each do |x|
  try { x.syscall(1) }
  try { x.send(:syscall, 2) }
end

class Object
  private def test(a) = "kernel name #{a}"
end

[B.new, 5, nil, true, Integer].each do |x|
  try { x.test(1) }
  try { x.send(:test, 2) }
end
