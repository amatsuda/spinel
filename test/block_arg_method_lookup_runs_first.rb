# A Method handed as a block (`&worker.method(:work)`) is looked up before
# the call it is handed to runs, as CRuby evaluates every argument first: a
# receiver that calls something runs once, there. Mutex#synchronize ran
# `worker` under its lock instead, where worker's own synchronize on the
# same Mutex raised ThreadError (recursive locking), and an iterator
# looked the Method up again for each element.
module Locking
  def synchronize = yield
end

M = Mutex.new
$built = 0

class Worker
  def work = M.owned?
  def twice(x) = x * 2
end

def worker
  M.synchronize { $built += 1 }
  Worker.new
end

p M.synchronize(&worker.method(:work))
p $built
p [1, 2, 3].map(&worker.method(:twice))
p $built
w = Worker.new
p [4, 5].map(&w.method(:twice))
p M.synchronize(&w.method(:work))
