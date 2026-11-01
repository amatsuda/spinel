# A builder block's parameter, written conditionally after a read: the
# body's `k = self`, numbered after the body, came after the reads it feeds
# in the write-type fold, and the fixpoint ran to its cap.
Z = Class.new do |k|
  def self.tag = "z"
  s = k.tag
  k = s * 2 if s
  p k, k.size
end
