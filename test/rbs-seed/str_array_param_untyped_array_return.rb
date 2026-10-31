# A parameter --rbs declares Array[String], answered by a method declared
# to return Array[untyped] through a branch an is_a?(Array) test decides:
# the String Array is rebuilt as the general Array the signature returns.
# The begin holding the method's value was handed back as it was, an
# sp_StrArray * through an sp_PolyArray * signature, and the C build
# stopped (#10680).
module StrArrayUntypedReturnSeed
  def self.as_array(value)
    if value.is_a?(Array)
      value
    else
      [value]
    end
  end
end
p StrArrayUntypedReturnSeed.as_array(["a", "b"])
p StrArrayUntypedReturnSeed.as_array([])
