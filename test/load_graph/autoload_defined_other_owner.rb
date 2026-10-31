# A top-level defined?(X) looks in Object alone: a module's registration of
# X does not keep it pending, so the guarded branch folds away as it does
# without the registration (its body is never compiled).
module OtherOwner
  autoload :X, File.join(__dir__, "autoload_defined_other_owner_lib")
end
if defined?(X)
  binding.local_variable_set(ARGV[0].to_sym, 1)
end
puts "done"
p defined?(OtherOwner::X)
