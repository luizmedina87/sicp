#lang sicp

(#%require "../exercise-1-38.rkt")
(#%require "../lib/math.rkt")
(#%require "../lib/test.rkt")

(define (run-tests)
  (newline)
  (display "=== Running Exercise 1.38 Test Suite ===")
  (newline)

  (assert-close "Approximates e ~ 2.71828"
                (exp 1)
                (euler)
                0.0001)

  (newline)
  (display "=== Tests Completed ===")
  (newline))

(run-tests)