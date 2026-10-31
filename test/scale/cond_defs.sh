#!/bin/sh
# K define_methods under a run-time condition in one class, K defs in one
# iterator's block of it, K classes with one def and one define_method under
# a condition each, and a call of every name: each is an open history whose
# entry the call plan makes, and each version's statement gets its cell's
# write. The writes of one statement list are placed in one rebuild of it, not
# one copy of the list per write, which grew as K^2 on the one block. (The
# defs under an if or unless of one class body are left out: the pass that
# still lowers them inserts each into its list.)
n=${1:-200}
echo '$c = ARGV.size > 5'
echo 'class One'
i=0
while [ "$i" -lt "$n" ]; do
  echo "  define_method(:d$i) { $i } if \$c"
  i=$((i + 1))
done
echo '  [1].each do'
i=0
while [ "$i" -lt "$n" ]; do
  echo "    def m$i = $i"
  i=$((i + 1))
done
echo '  end'
echo 'end'
i=0
while [ "$i" -lt "$n" ]; do
  echo "class K$i"
  echo "  def m = $i if \$c"
  echo "  define_method(:d) { $i } if \$c"
  echo "end"
  i=$((i + 1))
done
echo 't = 0'
i=0
while [ "$i" -lt "$n" ]; do
  echo "begin; t += One.new.m$i; t += One.new.d$i; rescue NoMethodError; t -= 1; end"
  echo "begin; t += K$i.new.m + K$i.new.d; rescue NoMethodError; t -= 1; end"
  i=$((i + 1))
done
echo 'p t'
