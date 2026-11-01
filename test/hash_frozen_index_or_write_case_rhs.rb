# the right side of a Hash slot's ||= holds a case/in
h = {a: 1}
v = [1, 2]
h[:b] ||= case v
          in [x, y] then x + y
          end
h[:a] &&= case v
          in [x, *] then x * 10
          end
p h
f = {a: 1}.freeze
begin
  f[:b] ||= case v
            in [x, y] then x + y
            end
rescue FrozenError => e
  p e.class
end
p f
