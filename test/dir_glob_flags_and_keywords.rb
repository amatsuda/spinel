require "tmpdir"
dir = File.join(Dir.tmpdir, "sp_glob_flags_kw_#{Process.pid}")
Dir.mkdir(dir)
begin
  Dir.mkdir(File.join(dir, "sub"))
  File.write(File.join(dir, "a.txt"), "a")
  File.write(File.join(dir, ".hidden"), "h")
  File.write(File.join(dir, "sub", "b.html"), "b")
  p Dir.glob("*", File::FNM_DOTMATCH, base: dir).sort
  p Dir.glob("sub/*", File::FNM_DOTMATCH, base: dir, sort: true)
  p Dir.glob("*", 0, base: dir).sort
  flags = File::FNM_DOTMATCH
  p Dir.glob("*", flags, base: dir).sort
  # the flags: keyword wins over the positional flags
  p Dir.glob("*", File::FNM_DOTMATCH, flags: 0, base: dir).sort
ensure
  File.delete(File.join(dir, "sub", "b.html"))
  Dir.rmdir(File.join(dir, "sub"))
  File.delete(File.join(dir, "a.txt"))
  File.delete(File.join(dir, ".hidden"))
  Dir.rmdir(dir)
end
