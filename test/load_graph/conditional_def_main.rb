# A define_method or a def under a condition only the run time decides, in a
# required file, defines its method once its branch has run, as in CRuby.
require_relative "conditional_def_lib"
p Lib.new.a
begin
  p Lib.new.b
rescue NoMethodError => e
  puts e.message
end
p Lib.new.c
