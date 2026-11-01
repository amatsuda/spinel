# A Proc read out of a mixed Array (a boxed one) renders as a Proc: its
# to_s, its inspect, an interpolation and a join answered "" where CRuby
# prints #<Proc:0xADDR ...>; a curried Proc, typed or boxed, renders as the
# Proc it wraps, lambda or not.
q = proc { |v| v }
l = lambda { |v| v }
add = proc { |a, b| a + b }
c = add.curry
arr = [q, l, c, 1]
p "a #{arr[0]}".start_with?("a #<Proc:0x")
p "b #{arr[1]}".end_with?("(lambda)>")
p arr[0].to_s.start_with?("#<Proc:0x")
p arr[0].inspect.start_with?("#<Proc:0x")
p arr[1].inspect.end_with?(" (lambda)>")
p arr[2].to_s.start_with?("#<Proc:0x"), arr[2].inspect.end_with?("(lambda)>")
lc = lambda { |a, b| a + b }.curry
p lc.inspect.end_with?("(lambda)>"), [lc, 1][0].to_s.end_with?("(lambda)>")
puts [q].join(",").start_with?("#<Proc:0x")
p c.to_s.start_with?("#<Proc:0x"), c.inspect.end_with?("(lambda)>")
pr = proc { |v| "got #{v}" }
p pr.call(q).start_with?("got #<Proc:0x")
