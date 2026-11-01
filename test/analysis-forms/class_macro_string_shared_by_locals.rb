# Two locals of a macro that hold one String are one object, however it was
# copied; two Strings of equal bytes are two. A String no other local held is
# still written as a new String of its bytes.
class Alias
  def self.mk(n)
    t = "a#{n}"
    s = t
    define_method(n) { s }
    define_method(:"#{n}_t") { t }
  end
end
class AliasUse < Alias
  mk :x
end
f = AliasUse.new
f.x << "!"
p f.x, f.x_t, f.x.equal?(f.x_t)

class ToS
  def self.mk(n)
    t = n.to_s
    s = t
    define_method(:"#{n}_s") { s }
    define_method(:"#{n}_t") { t }
  end
end
class ToSUse < ToS
  mk :y
end
g = ToSUse.new
g.y_t << "?"
p g.y_s, g.y_t

class Chain
  def self.mk(n)
    t = "c#{n}"
    s = t
    u = s
    define_method(:"#{n}_u") { u }
    define_method(:"#{n}_t") { t }
  end
end
class ChainUse < Chain
  mk :z
end
h = ChainUse.new
h.z_u << "+"
p h.z_t, h.z_u.equal?(h.z_t)

class Apart
  def self.mk(n)
    t = "d#{n}"
    s = "d#{n}"
    define_method(:"#{n}_s") { s }
    define_method(:"#{n}_t") { t }
  end
end
class ApartUse < Apart
  mk :w
end
i = ApartUse.new
i.w_s << "!"
p i.w_s, i.w_t, i.w_s.equal?(i.w_t)

class Rebound
  def self.mk(n)
    t = "e#{n}"
    s = t
    t = "f#{n}"
    u = "g#{n}"
    s = u
    define_method(n) { s }
    define_method(:"#{n}_t") { t }
    define_method(:"#{n}_u") { u }
  end
end
class ReboundUse < Rebound
  mk :q
end
k = ReboundUse.new
k.q << "!"
k.q_t << "?"
p k.q, k.q_t, k.q_u, k.q.equal?(k.q_u)
