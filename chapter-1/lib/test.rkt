#lang sicp

(#%provide (all-defined))


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