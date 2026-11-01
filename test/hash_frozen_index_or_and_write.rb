# `h[k] ||= v` and `h[k] &&= v` on a frozen Hash raise FrozenError when they
# would write, as `h[k] = v` does; they wrote the key before.
h = {a: 1}.freeze
begin; h[:b] ||= 1; rescue FrozenError => e; p e.class; end
begin; h[:a] ||= 2; p :ok; rescue FrozenError => e; p e.class; end
begin; h[:a] &&= 2; rescue FrozenError => e; p e.class; end
begin; h[:a] += 2; rescue FrozenError => e; p e.class; end
s = {"x" => "y"}.freeze
begin; s["z"] ||= "w"; rescue FrozenError => e; p e.class; end
a = [1, nil].freeze
begin; a[1] ||= 3; rescue FrozenError => e; p e.class; end
p h, s, a
v = {a: nil}.freeze
p(begin; v[:a] ||= 5; rescue FrozenError => e; e.class; end)
p(begin; h[:a] ||= 9; rescue FrozenError => e; e.class; end)
p(begin; h[:q] &&= 9; rescue FrozenError => e; e.class; end)
i = {1 => 2}.freeze
begin; i[3] ||= 4; rescue FrozenError => e; p e.message; end
fl = {x: 1.5}.freeze
begin; fl[:y] ||= 2.5; rescue FrozenError => e; p e.class; end
def g(hh) = (hh[:k] ||= 1)
p(begin; g({k: nil}.freeze); rescue FrozenError => e; e.class; end)
p g({})
w = {a: 1}
w[:b] ||= 2
w[:a] &&= 3
p w
pw = [{a: 1}, "s"][0]
begin; pw.freeze; pw[:z] ||= 1; rescue FrozenError => e; p e.class; end
p pw
