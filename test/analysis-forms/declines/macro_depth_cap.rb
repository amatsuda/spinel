# The class-body macro form declines: a chain of macro calls deeper than
# sixteen frames.
class Deep
  def self.m1(n) = m2(n)
  def self.m2(n) = m3(n)
  def self.m3(n) = m4(n)
  def self.m4(n) = m5(n)
  def self.m5(n) = m6(n)
  def self.m6(n) = m7(n)
  def self.m7(n) = m8(n)
  def self.m8(n) = m9(n)
  def self.m9(n) = m10(n)
  def self.m10(n) = m11(n)
  def self.m11(n) = m12(n)
  def self.m12(n) = m13(n)
  def self.m13(n) = m14(n)
  def self.m14(n) = m15(n)
  def self.m15(n) = m16(n)
  def self.m16(n) = m17(n)
  def self.m17(n) = define_method(n) { n }
  m1 :deep
end
p Deep.new.deep
