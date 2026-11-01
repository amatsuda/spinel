# A path builder in a file loaded under a condition that does not hold
# never runs: its class is not defined after the require.
require_relative "class_new_path_write_may/lib" if ARGV.size > 5
p defined?(PwM::B)
p((PwM::B rescue :name_error))
