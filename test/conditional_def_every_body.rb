# A def or a define_method under a condition only the run time decides
# defines its method once its branch has run, in every body that holds
# one: a class's, a Struct.new or Data.define block, a Class.new block.
# Called when its branch did not run, it raises NoMethodError, as in CRuby.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
$off = !$on

def try
  p yield
rescue NoMethodError => e
  puts e.message
end

class Plain
  def on = 1 if $on
  def off = 2 if $off
  define_method(:dm_on) { 3 } if $on
  define_method(:dm_off) { 4 } if $off
end
try { Plain.new.on }
try { Plain.new.off }
try { Plain.new.dm_on }
try { Plain.new.dm_off }

S = Struct.new(:a) do
  def on = a + 1 if $on
  def off = 0 if $off
  define_method(:dm_on) { a + 2 } if $on
  define_method(:dm_off) { 0 } if $off
end
try { S.new(1).on }
try { S.new(1).off }
try { S.new(1).dm_on }
try { S.new(1).dm_off }

D = Data.define(:a) do
  def on = a * 10 if $on
  def off = 0 if $off
end
try { D.new(a: 2).on }
try { D.new(a: 2).off }

K = Class.new do
  def on = :k if $on
  def off = 0 if $off
  define_method(:dm_on) { :kd } if $on
  define_method(:dm_off) { 0 } if $off
end
try { K.new.on }
try { K.new.off }
try { K.new.dm_on }
try { K.new.dm_off }
