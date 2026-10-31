# A proc handed to synchronize as `&pr` on a receiver that holds a Mutex at
# one call and a program object with a synchronize of its own at another
# reaches that object's method with its arguments: Locker#synchronize yields
# 42 to the proc. The Mutex was the receiver's only type while the other
# call's argument was still untyped, and the block forwarded for it then
# took the Mutex's no arguments, so the proc saw nil.
class Locker
  def synchronize
    yield 42
  end
end

def make_locker = Locker.new
def run(l, pr) = l.synchronize(&pr)

pr = proc { |x| x.inspect }
p run(Mutex.new, pr)
p run(make_locker, pr)

def pick(i) = i.zero? ? Mutex.new : Locker.new
def run_block(l, &blk)
  held = blk
  l.synchronize(&held)
end
p run_block(Mutex.new) { |x| [:mutex, x] }
p run_block(pick(1)) { |x| [:picked, x] }
p run_block(pick(0)) { |x| [:picked_mutex, x] }
