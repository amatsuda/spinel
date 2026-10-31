# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
S = Struct.new(:a) do
  if ENV["NOPE"]
    define_method(:x) { 1 }
  end
end
p S.new(1).respond_to?(:x)
