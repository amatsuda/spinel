# A call with arguments on a boxed receiver whose class does not define the
# name runs the Object (or Kernel) reopening's method of that name, and that
# method stays compiled when it takes another count than the call passes:
# the call raises its ArgumentError, through send and public_send too (a
# private one through send), for a builtin receiver as well. The dispatch
# wrote that default itself, so reachability never saw the method and the C
# called a function it no longer had.
class Object
  def foo(a, b) = "obj #{a} #{b}"
  private def qux(a, b) = "private #{a} #{b}"
end

module Kernel
  def baz(a, b) = "kernel #{a} #{b}"
end

class A
  def foo(a) = "A #{a}"
  def baz(a) = "A baz #{a}"
  def qux(a) = "A qux #{a}"
end

class B
end

def try
  puts yield
rescue ArgumentError => e
  puts "ArgumentError: #{e.message}"
end

[A.new, B.new, 5, nil].each do |x|
  try { x.foo(1) }
  try { x.send(:foo, 2) }
  try { x.public_send(:foo, 3) }
  try { x.baz(4) }
  try { x.send(:qux, 5) }
end
