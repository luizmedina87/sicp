#lang sicp

(#%provide (all-defined))
(#%require "./lib/math.rkt")
(#%require "./exercise-1-37.rkt")

#| Exercise 1.39:

A continued fraction representation of the tangent 
function was published in 1770 by the German mathematician
J.H. Lambert:

                   x
    tan x = ---------------
             1 -     x^2
                 ----------
                  3 -   x^2
                      -----
                      5 - ...

where x is in radians. Define a procedure (tan-cf x k)
that computes an approximation to the tangent function
based on Lambert's formula. k specifies the number of
terms to compute, as in Exercise 1.37.
|#


(define (tan-cf x k)
  (define (n i)
    (if (= i 1) x (- (square x))))
  (define (d i) (+ 1 (* (- i 1) 2)))
  (cont-frac-iter n d k))