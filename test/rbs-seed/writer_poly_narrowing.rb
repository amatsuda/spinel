# An --rbs signature makes an ivar's slot concrete while observed dataflow
# makes the value poly, and the attr WRITER path is where the two meet. The
# local-assignment path narrows a poly rhs into a concrete slot; the writer
# only knew how to coerce the gate's raising token, so the sp_RbVal was
# assigned raw into a const char * and the C build stopped (#4093).
# spinel: rbs-seed-check
class Cand
  attr_accessor :id

  def initialize(id)
    self.id = id
  end

  def to_s
    id
  end

  def to_i
    id
  end
end

class Req
  attr_accessor :verb
  attr_accessor :count
end

def build(v)
  r = Req.new
  r.verb = (v || "GET").to_s
  r.count = (v || 2).to_i
  r
end

r = build(nil)
p r.verb
p r.count
p build("POST").verb
# a Cand whose id is a String answers it for both to_s and to_i, so its
# count would hold a String in a slot the seed declares Integer: the store
# raises TypeError (#10710); a Cand whose id is an Integer does the same
# for verb. Each is built where only the agreeing writer is read.
def build_verb(v)
  r = Req.new
  r.verb = (v || "GET").to_s
  r
end
def build_count(v)
  r = Req.new
  r.count = (v || 2).to_i
  r
end
p build_verb(Cand.new("abc")).verb
p build_count(Cand.new(7)).count
begin
  build(Cand.new("abc"))
rescue TypeError => e
  puts "TypeError: #{e.message}"
end
