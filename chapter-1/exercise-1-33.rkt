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

(#%require "./exercise-1-28.rkt") ; fast-prime?
(#%require "./exercise-1-20.rkt") ; gcd

; Adapting fast-prime? for use here. 40 is the number of times to
; test the number for primality, which probabilistically ensures
; the number is prime for all relavant purposes.

; ANSWER

;; Helpers
(define (inc x) (+ x 1))
(define (identity x) x)
(define (square x) (* x x))
(define (even? n) (= (remainder n 2) 0))

(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-rec combiner
                                null-value
                                term
                                (next a)
                                next
                                b))))

(define (filtered-accumulate-rec combiner predicate null-value term a next b)
  (if (> a b)
      null-value
      (if (predicate a)
          (combiner (term a)
                    (filtered-accumulate-rec combiner
                                             predicate
                                             null-value
                                             term
                                             (next a)
                                             next
                                             b))
          (filtered-accumulate-rec combiner
                                   predicate
                                   null-value
                                   term
                                   (next a)
                                   next
                                   b))))


(define (sum-squares-primes a b)
	(define (prime? n)
		(cond ((< n 2) false)
					(else (fast-prime? n 40))))
  (filtered-accumulate-rec + prime? 0 square a inc b))

(define (product-relative-prime n)
	(define (relative-prime i)
		(if (= (gcd i n) 1)
				true
				false))
	(filtered-accumulate-rec * relative-prime 1 identity 2 inc n))


(#%provide (all-defined))