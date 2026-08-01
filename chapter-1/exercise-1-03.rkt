#lang sicp

(#%require "./lib/math.rkt")
(#%provide (all-defined))

#| 
Exercise 1.3: Define a procedure that takes three numbers
as arguments and returns the sum of the squares of the two
larger numbers.
|#

; ANSWER:
(define (sum-of-two-largest-squares a b c)
  (define (sum-of-squares a b) (+ (square a) (square b)))
  (cond ((and (<= a b) (<= a c)) (sum-of-squares b c))
        ((and (<= b a) (<= b c)) (sum-of-squares a c))
        (else (sum-of-squares a b))))
