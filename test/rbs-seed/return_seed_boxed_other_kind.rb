# spinel: rbs-seed-run
# A value reaches a return the seed declares String through another call,
# or through a block, whose answer the body does not show as an Integer: the
# String passes, and the Integer raises TypeError at the return, as a
# seeded parameter's does (#10154, #10681). It was read as a `const char *`
# and the program crashed (#10710). CRuby, which reads no seed, prints the
# Integer; the signature is the program's contract here, as the same
# Integer written in the body is refused at compile time.
class ReturnSeedBox
  def self.raw(s)
    s == "a" ? 42 : s.upcase
  end

  def self.wrap = yield

  def self.pick(s)
    raw(s)
  end

  def self.pick_block(s)
    wrap { s == "a" ? 42 : s.upcase }
  end
end

def try_pick(v)
  p ReturnSeedBox.pick(v)
rescue TypeError => e
  puts "TypeError: #{e.message}"
end

def try_block(v)
  p ReturnSeedBox.pick_block(v)
rescue TypeError => e
  puts "TypeError: #{e.message}"
end

try_pick("b")
try_pick("a")
try_block("b")
try_block("a")
