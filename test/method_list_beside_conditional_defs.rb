# A list of methods a class body makes of its own methods, in a program
# where another class defines a method under an if/else the run time
# decides (Active Support's clock_time, ERB::Util's escape_html): the
# list's receiver is the class the body opens, whose chain holds no
# conditional method, so it answers as CRuby does. A list on the class
# that holds the conditional method is still refused (test/reject).
$on = ENV["SPINEL_TEST_UNSET_VARIABLE"].nil?
class Clock
  if $on
    def now = 1
  else
    def now = 2
  end
end

class Wrap
  def a = 1
  def b = 2
  API = public_instance_methods(false).sort
  OWN = self.instance_methods(false).sort
end

p Clock.new.now, Wrap::API, Wrap::OWN
