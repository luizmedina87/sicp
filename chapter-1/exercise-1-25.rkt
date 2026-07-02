#lang sicp

#| Exercise 1.25: Alyssa P. Hacker complains that we went to
a lot of extra work in writing expmod. After all, she says,
since we already know how to compute exponentials, we
could have simply written

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

Is she correct? Would this procedure serve as well for our
fast prime tester? Explain. |#

#| ANSWER:

Is she correct? Mathematically, yes. Alyssa’s procedure is 
correct in theory because (an)(modm) yields the same result
 as the original expmod.

Would this procedure serve as well for our fast prime tester?
No, it would fail catastrophically in practice due to bignum
inflation.

1- Memory Efficiency: The original expmod interleaves a 
remainder operation at every recursive step, keeping 
intermediate products tightly bounded (never exceeding m2).
Alyssa’s version calls fast-expt first, which computes the 
astronomical value of baseexp completely before applying the 
modulo. For large primes, this requires a massive, wasteful 
allocation of memory to store integers that are thousands of 
bits long.

2- Time Efficiency: While Alyssa's approach still takes a 
logarithmic number of steps (O(logn) multiplications), the 
cost of each multiplication is no longer constant. In the 
original expmod, multiplying small numbers takes O(1) time. 
In Alyssa's version, multiplying increasingly gargantuan 
numbers takes O(k2) time relative to the bit-length.

Conclusion: By forcing the system to handle giant 
intermediate numbers, Alyssa’s version degrades a highly 
efficient O(logn) algorithm into a computationally heavy, 
slow process that defeats the entire purpose of a fast prime 
tester. |#