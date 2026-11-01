# spinel: rbs-seed-check
# A String handed to a parameter the seed declares Array[String], through
# two parameters the seed leaves untyped: every call of each hands on the
# String, so the inner call is the direct call's contradiction a few steps
# removed and is refused the same way, naming the parameter the value came
# through (#10681). Where an Array can reach the parameter too, the call
# compiles and the run-time check raises (str_array_param_through_untyped).
module SeedThroughUntyped
  def self.as_array(value)
    if value.is_a?(Array) then value else [value] end
  end

  def self.wrap(value) = as_array(value)

  def self.outer(v) = wrap(v)
end

p SeedThroughUntyped.outer("x")
