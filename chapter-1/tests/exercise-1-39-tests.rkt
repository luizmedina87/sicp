#lang sicp

(#%require "../exercise-1-39.rkt")
(#%require "../lib/math.rkt")
(#%require "../lib/test.rkt")

(define pi 3.141592653589793)

(define (run-tests)
  (newline)
  (display "=== Running Exercise 1.39 Test Suite ===")
  (newline)

  (assert-close "tan(0) = 0"
                0.0
                (tan-cf 0.0 10)
                0.0001)

  (assert-close "tan(pi/4) ~ 1.0"
                1.0
                (tan-cf (/ pi 4) 10)
                0.0001)

  (assert-close "tan(1.0) ~ 1.5574"
                1.5574077
                (tan-cf 1.0 10)
                0.0001)

  (newline)
  (display "=== Tests Completed ===")
  (newline))

(run-tests)