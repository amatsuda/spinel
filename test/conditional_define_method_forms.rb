# define_method and define_singleton_method under a condition only the run
# time decides: the method exists once its branch has run, and keeps its
# block's closure, its parameters and the block a call gives it; in a
# Module.new block, the classes that include or extend the module answer it
# so. An if / else of two define_methods answers the branch that ran.
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
$off = !$on

def try
  p yield
rescue NoMethodError => e
  puts e.message
end

class C
  define_singleton_method(:s_on) { 1 } if $on
  define_singleton_method(:s_off) { 2 } if $off
  x = 41
  define_method(:cap_on) { x + 1 } if $on
  define_method(:cap_off) { x } if $off
  if $on
    define_method(:pick) { :then }
  else
    define_method(:pick) { :else }
  end
  define_method(:blk) { |v, &b| [v, b ? b.call : nil] } if $on
  define_method(:add) { |a, b| a + b } if $on
  define_method(:rest) { |a, *r| [a, r] } if $on
end
try { C.s_on }
try { C.s_off }
try { C.new.cap_on }
try { C.new.cap_off }
try { C.new.pick }
try { C.new.blk(1) { 2 } }
try { C.new.blk(3) }
try { C.new.add(2, 3) }
try { C.new.rest(1, 2, 3) }

M = Module.new do
  define_method(:m_on) { :m } if $on
  define_method(:m_off) { 0 } if $off
end
class I; include M; end
class E; extend M; end
try { I.new.m_on }
try { I.new.m_off }
try { E.m_on }
try { E.m_off }
