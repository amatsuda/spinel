# A read looks in its lexical scopes before Object: a registration in the
# module comes ahead of a top-level constant of the name, so the read runs
# the file, which does not define LexFirst::X, and then finds the top-level
# constant.
X = 1
module LexFirst
  autoload :X, File.join(__dir__, "autoload_lexical_first_lib")
  def self.get = X
end
p LexFirst.get
p LexFirst::Y
