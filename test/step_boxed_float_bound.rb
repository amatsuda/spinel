# An Integer's step with a limit or step that is boxed (its kind is known
# only at run time) walks Floats when that value is a Float, as CRuby does.
# The Integer loop cut a step of 1.5 to 1 and a step of 0.5 to 0.
y = 1
y = y + 0.5
p 1.step(3, y).to_a
1.step(3, y) { |v| p v }

def walk(s) = 1.step(3, s).to_a
p walk(1)
p walk(0.5)
p walk(2r)

l = 1
l = l + 1.5
p 1.step(l).to_a
1.step(l) { |v| p v }

s = 2
s = s * 1.0
p 1.step(5, s).map { |x| x * 2 }
p 3.step(1, -s).to_a
r = 0
1.step(5, s) { |x| r += x }
p r

t = 0.1
t = t + 0 * s
p 1.step(2, t).to_a

k = [nil, 1.5][0]
1.step(k, 2) { |v| p v; break if v > 4 }
1.step(k, 0.5) { |v| p v; break if v > 1 }

z = [2, 0.0][1]
begin
  1.step(3, z) { }
rescue ArgumentError => e
  p e.message
end
