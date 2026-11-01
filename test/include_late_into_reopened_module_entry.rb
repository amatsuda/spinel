# A module reopened after code ran, to include another module, with a
# class that includes the outer module: the module's own copies of the
# included methods are guarded, and only its includers' clones are
# emitted, each with its own guard entry. An entry built on the module
# itself called a copy no function existed for (Action View's Helpers
# module reopened to include OutputSafetyHelper, AssetUrlHelper, ...).
module OutputSafety
  def safe_join(a, sep = ",") = a.join(sep)
end
module Helpers
  def list(a) = safe_join(a)
end
class View
  include Helpers
end
class Other
  def safe_join(a, sep = ",") = "other"
end
def render(o, a) = o.safe_join(a)
p render(Other.new, [1])
module Helpers
  include OutputSafety
end
p View.new.list([1, 2]), render(View.new, [3, 4]), render(Other.new, [5])
