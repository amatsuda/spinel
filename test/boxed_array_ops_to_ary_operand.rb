# spinel: gc-stress
# A boxed Array's operator or set method converts an object operand
# through its #to_ary, as CRuby does: concat beside its own class's arm,
# `|`, `&`, union and intersection (sp_poly_bitop), and product, which read
# the operand's elements as an Enumerable's (a Hash's pairs, nothing for an
# object with no #each) and answered pairs or [].
class OpSource
  def to_ary = [2]
end
class OpBadSource
  def to_ary = 5
end
def boxed = [Exception.new, [1]][1]
def try(name)
  r = yield
  puts "#{name}: #{r.inspect}"
rescue => e
  puts "#{name}: #{e.class} #{e.message}"
end
try("concat2") { boxed.concat(OpSource.new, [3]) }
try("concat1") { boxed.concat(OpSource.new) }
try("plus") { boxed + OpSource.new }
try("minus") { boxed - OpSource.new }
try("or") { boxed | OpSource.new }
try("and") { boxed & OpSource.new }
try("replace") { boxed.replace(OpSource.new) }
try("product") { boxed.product(OpSource.new) }
try("union") { boxed.union(OpSource.new) }
try("difference") { boxed.difference(OpSource.new) }
try("intersection") { boxed.intersection(OpSource.new) }
try("zip") { boxed.zip(OpSource.new) }
try("product hash") { boxed.product({a: 1}) }
try("product range") { boxed.product(1..2) }
try("product nil") { boxed.product(nil) }
try("or hash") { boxed | {a: 1} }
try("or bad") { boxed | OpBadSource.new }
try("product bad") { boxed.product(OpBadSource.new) }
