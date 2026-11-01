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

# the right side runs first: its own error and its side effects come before
# the FrozenError, and a right side that freezes the Hash stops the write
f = {a: 1}.freeze
begin; f[:b] ||= Integer("zz"); rescue => e; p e.class; end
$log = []
def v(x) = ($log << x; x)
h = {a: 1}.freeze
begin; h[:b] ||= v(2); rescue FrozenError; end
begin; h[:a] &&= v(3); rescue FrozenError; end
s = {"a" => "b"}.freeze
begin; s["c"] ||= v("d"); rescue FrozenError; end
fl = {a: 1.5}.freeze
begin; fl[:c] ||= v(2.5); rescue FrozenError; end
begin; h[v(:k)] ||= v(2); rescue FrozenError; end
p $log
g = {a: 1}
begin; g[:b] ||= (g.freeze; 2); rescue FrozenError => e; p e.class; end
p g
k = {"a" => "b"}
begin; k["z"] &&= (k.freeze; "q"); rescue FrozenError => e; p e.class; end
k2 = {"a" => "b"}
begin; k2["a"] &&= (k2.freeze; "q"); rescue FrozenError => e; p e.class; end
p k, k2
