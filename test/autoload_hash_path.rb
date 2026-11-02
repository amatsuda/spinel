# A `#` in a required file's path (`aep/index#1.rb`): the path forms the
# parser rewrites into a require_relative it splices into the source
# (autoload with File.expand_path or "#{__dir__}/...", require with
# File.expand_path, require_relative) refused such a path, since a `#` in a
# double-quoted literal could open an interpolation. The splice now quotes
# such a path with single quotes, where a `#` is literal.
autoload :Aep, File.expand_path('autoload_hash_path/aep/index#1', __dir__)
autoload :Second, "#{__dir__}/autoload_hash_path/aep/second#2"
require File.expand_path('autoload_hash_path/aep/third#3', __dir__)
require_relative 'autoload_hash_path/aep/fourth#4'
puts Aep.hi
puts Second.hi
puts Third.hi
puts Fourth.hi
p Aep::INDEX
