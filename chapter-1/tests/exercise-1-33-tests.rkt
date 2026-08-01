#lang sicp

(#%require "../exercise-1-33.rkt")

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
  (display "=== Running Exercise 1.33 Test Suite ===")
  (newline)
  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 1. Core filtered-accumulate-rec Unit Tests
  ;; ---------------------------------------------------------------------------
  (display "--- [1] Generic filtered-accumulate-rec ---") (newline)

  (assert-equal "Base case (a > b) returns null-value"
                0
                (filtered-accumulate-rec + even? 0 identity 5 inc 1))

  (assert-equal "Sum of even numbers in range 1..10 (2+4+6+8+10 = 30)"
                30
                (filtered-accumulate-rec + even? 0 identity 1 inc 10))

  (assert-equal "All elements filtered out returns null-value"
                1
                (filtered-accumulate-rec * even? 1 identity 1 (lambda (x) (+ x 2)) 5)) ; range: 1, 3, 5

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 2. Part A: sum-squares-primes
  ;; ---------------------------------------------------------------------------
  (display "--- [2] Part A: sum-squares-primes ---") (newline)

  (assert-equal "Range 1..10 -> Primes: 2, 3, 5, 7 (4 + 9 + 25 + 49 = 87)"
                87
                (sum-squares-primes 1 10))

  (assert-equal "Range 1..1 (No primes >= 2) -> returns 0"
                0
                (sum-squares-primes 1 1))

  (assert-equal "Range 2..2 -> Prime: 2 (2^2 = 4)"
                4
                (sum-squares-primes 2 2))

  (assert-equal "Range 10..20 -> Primes: 11, 13, 17, 19 (121+169+289+361 = 940)"
                940
                (sum-squares-primes 10 20))

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 3. Part B: product-relative-prime
  ;; ---------------------------------------------------------------------------
  (display "--- [3] Part B: product-relative-prime ---") (newline)

  ;; For n = 10: numbers < 10 relatively prime to 10 are 1, 3, 7, 9
  ;; 1 * 3 * 7 * 9 = 189
  (assert-equal "Relatively prime to 10 (1 * 3 * 7 * 9 = 189)"
                189
                (product-relative-prime 10))

  ;; For n = 6: numbers < 6 relatively prime to 6 are 1, 5
  ;; 1 * 5 = 5
  (assert-equal "Relatively prime to 6 (1 * 5 = 5)"
                5
                (product-relative-prime 6))

  ;; For prime n = 7: all numbers 1..6 are relatively prime to 7
  ;; 1 * 2 * 3 * 4 * 5 * 6 = 720 (6!)
  (assert-equal "Relatively prime to prime 7 (6! = 720)"
                720
                (product-relative-prime 7))

  (newline)
  (display "=== All Tests Completed ===")
  (newline))

;; Execute suite
(run-tests)