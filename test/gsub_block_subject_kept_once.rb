# gsub with a block, in a program that reads a capture: every match sets
# `$~`, which keeps its target, and a live String's bytes are kept as a
# copy. The subject is kept once ahead of the loop, not copied per match:
# 20,000 matches over a 600 KB subject copied it 20,000 times, 12 GB, and
# ran the collector thousands of times for a 2 MB live set.
t = String.new
20000.times { |i| t << "<td>{{ K#{i} }}</td>|" }
c0 = GC.count
out = t.gsub(/{{(.*?)}}/) { $1.strip.size.to_s }
p out.bytesize
p GC.count - c0 < 500
