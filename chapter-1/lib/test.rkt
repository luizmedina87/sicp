#lang sicp

(#%provide (all-defined))
(#%require "./math.rkt")


(define (assert-equal test-name expected actual)
  (if (equal? expected actual)
      (begin
        (display " [PASS] ")
        (display test-name)
        (newline))
      (begin
        (display " [FAIL] ")
        (display test-name)
        (newline)
        (display "    Expected: ") (display expected) (newline)
        (display "    Actual:   ") (display actual)   (newline))))

(define (assert-close test-name expected actual tolerance)
  (if (close expected actual tolerance)
      (begin
        (display " [PASS] ")
        (display test-name)
        (newline))
      (begin
        (display " [FAIL] ")
        (display test-name)
        (newline)
        (display "    Expected approx: ") (display expected) (newline)
        (display "    Actual:          ") (display actual)   (newline))))
