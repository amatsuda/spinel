# super(args, &s) with s a local holding a Symbol hands the parent's &b,
# yield or a kept proc the Symbol's block, reading s where super runs:
# after an argument that rebinds s, and sending every value the parent
# yields (`yield 255, 16` with :to_s is 255.to_s(16)).
class A
  def m(a, &b)
    b ? b.call(a) : "no block"
  end

  def each_up(xs, &b)
    xs.map(&b)
  end

  def y(a)
    yield a
  end

  def keep(&b)
    @kept = b
  end

  def run(x)
    @kept.call(x)
  end
end

class B < A
  def m(a)
    s = :upcase
    super(a, &s)
  end

  def each_up(xs)
    s = :reverse
    super(xs, &s)
  end

  def y(a)
    s = :length
    super(a, &s)
  end

  def keep
    s = :capitalize
    r = super(&s)
    s = :upcase
    r
  end
end

b = B.new
puts b.m("hi")
p b.each_up(["ab", "cd"])
p b.y("four")
b.keep
puts b.run("ruby")
class C < A
  def m(a)
    out = []
    2.times do |i|
      s = i == 0 ? :swapcase : :downcase
      out << super(a, &s)
    end
    out
  end
end
p C.new.m("MiX")
class E
  def y = yield(255, 16)
  def m(a, &b) = b.call(a)
end
class F < E
  def y
    s = :to_s
    super(&s)
  end
  def m(a)
    s = :upcase
    super((s = :downcase; a), &s)
  end
end
p F.new.y
p F.new.m("Hi")
# a method of the program that hands its block on with super passes a
# Symbol's block the values the method super calls yields
class G
  def f = yield(255, 16)
  def g(&b) = b.call(255, 16)
  def h(c) = yield(255)
end
class H < G
  def f = super
  def g(&b) = super(&b)
  def h(c)
    return yield(255, 16) if c
    super
  end
end
t = :to_s
p H.new.f(&t)
p H.new.g(&t)
p H.new.h(false, &t)
