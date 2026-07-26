#lang sicp


#| Exercise 1.33: You can obtain an even more general ver-
sion of accumulate (Exercise 1.32) by introducing the no-
tion of a filter on the terms to be combined. That is, combine
only those terms derived from values in the range that sat-
isfy a specified condition. The resulting filtered-accumulate
abstraction takes the same arguments as accumulate, to-
gether with an additional predicate of one argument that
specifies the filter. Write filtered-accumulate as a proce-
dure. Show how to express the following using filtered-
accumulate:

a. the sum of the squares of the prime numbers in the
   interval a to b (assuming that you have a prime? pred-
   icate already written)

b. the product of all the positive integers less than n that
   are relatively prime to n (i.e., all positive integers i < n
   such that GCD(i, n) = 1). |#