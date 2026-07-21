A warm off-white mathematical-paper card announces a theorem for OEIS
A211420. It defines
`a_n = (8n)! n! / ((4n)! (3n)! (2n)!)` and
`L_r = lcm(1,2,...,8r-1)`, then states that for every `n >= 0`, `r >= 1`,
and `k` equal to 1, 2, or 3, the product of `k*n+i` from `i=1` through `r`
divides `L_r^r * a_n`. The explicit constant is uniform in `n` and is not
claimed to be sharp. The formalization was checked by Lean's kernel.
