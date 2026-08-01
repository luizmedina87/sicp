#lang sicp

(#%require "../exercise-1-04.rkt")

;; =============================================================================
;; Test Harness
;; =============================================================================

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

;; =============================================================================
;; Test Suite Execution
;; =============================================================================

(define (run-tests)
  (newline)
  (display "=== Running Exercise 1.04 Test Suite ===")
  (newline)
  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 1. a-plus-abs-b
  ;; ---------------------------------------------------------------------------
  (display "--- [1] Testing a-plus-abs-b ---") (newline)

  (assert-equal "b is positive: uses + operator (3 + |2| = 5)"
                5
                (a-plus-abs-b 3 2))

  (assert-equal "b is negative: uses - operator (3 - (-2) = 5)"
                5
                (a-plus-abs-b 3 -2))

  (assert-equal "Both a and b are zero (0 + |0| = 0)"
                0
                (a-plus-abs-b 0 0))

  (assert-equal "b is zero: uses - operator (3 - 0 = 3)"
                3
                (a-plus-abs-b 3 0))

  (assert-equal "a is negative, b is positive (-3 + |2| = -1)"
                -1
                (a-plus-abs-b -3 2))

  (assert-equal "a is negative, b is negative (-3 - (-2) = -1)"
                -1
                (a-plus-abs-b -3 -2))

  (newline)
  (display "=== All Tests Completed ===")
  (newline))

;; Execute suite
(run-tests)