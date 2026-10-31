require "tmpdir"
dir = File.join(Dir.tmpdir, "sp_glob_dot_rec_#{Process.pid}")
Dir.mkdir(dir)
begin
  Dir.mkdir(File.join(dir, "sub"))
  Dir.mkdir(File.join(dir, "sub", "x"))
  Dir.mkdir(File.join(dir, ".hid"))
  File.write(File.join(dir, "a.txt"), "a")
  File.write(File.join(dir, "sub", "b.html"), "b")
  File.write(File.join(dir, "sub", "x", "c.txt"), "c")
  File.write(File.join(dir, ".hid", "d.txt"), "d")
  # "." only where the pattern begins, none below a **
  p Dir.glob("**/*", base: dir, flags: File::FNM_DOTMATCH).sort
  p Dir.glob("**/*", base: dir, flags: File::FNM_DOTMATCH).sort
  p Dir.glob(File.join(dir, "**", "*"), File::FNM_DOTMATCH).map { |f| f.delete_prefix(dir) }.sort
  # a literal directory after ** lists its own "."
  p Dir.glob("**/x/*", base: dir, flags: File::FNM_DOTMATCH).sort
  p Dir.glob("**/.*", base: dir, flags: File::FNM_DOTMATCH).sort
  # without the flag nothing hidden appears
  p Dir.glob("**/*", base: dir).sort
ensure
  File.delete(File.join(dir, ".hid", "d.txt"))
  File.delete(File.join(dir, "sub", "x", "c.txt"))
  File.delete(File.join(dir, "sub", "b.html"))
  File.delete(File.join(dir, "a.txt"))
  Dir.rmdir(File.join(dir, ".hid"))
  Dir.rmdir(File.join(dir, "sub", "x"))
  Dir.rmdir(File.join(dir, "sub"))
  Dir.rmdir(dir)
end
