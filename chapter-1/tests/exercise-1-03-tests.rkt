#lang sicp

(#%require "../exercise-1-03.rkt")

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
  (display "=== Running Exercise 1.03 Test Suite ===")
  (newline)
  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 1. sum-of-two-largest-squares
  ;; ---------------------------------------------------------------------------
  (display "--- [1] Testing sum-of-two-largest-squares ---") (newline)

  (assert-equal "All distinct, ascending order (1, 2, 3 -> 2^2 + 3^2 = 13)"
                13
                (sum-of-two-largest-squares 1 2 3))

  (assert-equal "All distinct, descending order (3, 2, 1 -> 3^2 + 2^2 = 13)"
                13
                (sum-of-two-largest-squares 3 2 1))

  (assert-equal "All distinct, mixed order (2, 1, 3 -> 2^2 + 3^2 = 13)"
                13
                (sum-of-two-largest-squares 2 1 3))

  (assert-equal "Two largest equal, third smallest (3, 3, 2 -> 3^2 + 3^2 = 18)"
                18
                (sum-of-two-largest-squares 3 3 2))

  (assert-equal "Two largest equal, different position (2, 3, 3 -> 3^2 + 3^2 = 18)"
                18
                (sum-of-two-largest-squares 2 3 3))

  (assert-equal "Two largest equal, mixed position (3, 2, 3 -> 3^2 + 3^2 = 18)"
                18
                (sum-of-two-largest-squares 3 2 3))

  (assert-equal "All three values equal (3, 3, 3 -> 3^2 + 3^2 = 18)"
                18
                (sum-of-two-largest-squares 3 3 3))

  (assert-equal "Two smallest values equal (1, 1, 2 -> 1^2 + 2^2 = 5)"
                5
                (sum-of-two-largest-squares 1 1 2))

  (newline)
  (display "=== All Tests Completed ===")
  (newline))

;; Execute suite
(run-tests)