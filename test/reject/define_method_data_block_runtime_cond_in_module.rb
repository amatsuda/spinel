# spinel: reject-subclass: a method defined under a condition only the run time decides is not answered for
module Box
  D = Data.define(:a) do
    if ENV["NOPE"]
      define_method(:hi) { 1 }
    end
  end
end
p Box::D.new(a: 1).respond_to?(:hi)
