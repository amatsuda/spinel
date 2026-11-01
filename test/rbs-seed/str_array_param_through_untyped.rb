# spinel: rbs-seed-run
# A value reaches a parameter the seed types Array[String] through a
# parameter the seed leaves untyped: an Array passes, and a String raises
# TypeError at the call, as a seeded Array[untyped] parameter's does: the
# seed check's contradiction found at run time. It was read as nil and the
# program answered nil in silence (#10681).
# CRuby, which reads no seed, wraps the String; the signature is the
# program's contract here, as a direct call with a String is refused.
module ThroughUntypedSeed
  def self.as_array(value)
    if value.is_a?(Array)
      value
    else
      [value]
    end
  end

  def self.wrap(value)
    as_array(value)
  end
end

def try_wrap(v)
  p ThroughUntypedSeed.wrap(v)
rescue TypeError => e
  puts "TypeError: #{e.message}"
end

try_wrap(["a", "b"])
try_wrap("x")
