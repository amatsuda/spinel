# spinel: int64 -- -2**63 is an Integer past 2^31; not run on a 32-bit target
# Integer#pow(e, m) with the modulus -2**63, the one modulus whose magnitude
# is past the machine integer: the residue takes the modulus's sign (0, or a
# negative number above the modulus), as with any other negative modulus.
# Negating that modulus overflowed, and the reduction then ran against a
# negative one and answered an unreduced product.
n = ARGV.size
m = -9223372036854775807 - (n + 1)
p 7.pow(3, m)
p 7.pow(0, m)
p 0.pow(5, m)
p (-7).pow(3, m)
p 3.pow(200, m)
p (m + 1).pow(2, m)
p m.pow(3, m)
p 7.pow(3, m + 1)
p (-3).pow(41, m)
p 3.pow(41, m)
