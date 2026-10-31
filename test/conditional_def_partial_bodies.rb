# A def or a define_method in a body the load phase may not run whole -- an
# iterator's block, a case's branch, a begin body after a raise -- defines
# its method only when that code runs, as in CRuby.
def try
  p yield
rescue NoMethodError => e
  puts e.message
end

class Iter
  [].each { def none = 1 }
  [1].each { def once = 2 }
end
try { Iter.new.none }
try { Iter.new.once }

$v = ENV["SPINEL_TEST_UNSET_VARIABLE"].to_s.size
class Branch
  case $v
  when 5 then def five = 5
  when 0 then def zero = 0
  end
end
try { Branch.new.five }
try { Branch.new.zero }

class Raised
  begin
    raise "x"
    def after_raise = 1
  rescue
  end
  begin
    Integer("zz")
    define_method(:after_fail) { 2 }
  rescue ArgumentError
  end
end
try { Raised.new.after_raise }
try { Raised.new.after_fail }
