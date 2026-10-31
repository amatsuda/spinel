class Lib
  def a = 1
  define_method(:b) { 2 } if ENV["SPINEL_TEST_UNSET_VARIABLE"]
  def c = 3 if ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
end
