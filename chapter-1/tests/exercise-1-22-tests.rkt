#lang sicp

(#%require "../exercise-1-22.rkt")
(#%require "../lib/math.rkt")

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
  (display "=== Running Exercise 1.22 Test Suite ===")
  (newline)
  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 1. Core Primality Helper Procedures
  ;; ---------------------------------------------------------------------------
  (display "--- [1] Core Primality Helpers (smallest-divisor & prime?) ---") (newline)

  (assert-equal "smallest-divisor of 2 is 2"
                2
                (smallest-divisor 2))

  (assert-equal "smallest-divisor of 9 is 3"
                3
                (smallest-divisor 9))

  (assert-equal "smallest-divisor of 1999 (prime) is 1999"
                1999
                (smallest-divisor 1999))

  (assert-equal "smallest-divisor of 19999 (composite: 7 * 2857) is 7"
                7
                (smallest-divisor 19999))

  (assert-equal "prime? correctly identifies prime 2"
                true
                (prime? 2))

  (assert-equal "prime? correctly identifies composite 4"
                false
                (prime? 4))

  (assert-equal "prime? correctly identifies prime 1009"
                true
                (prime? 1009))

  (assert-equal "prime? correctly identifies composite 1001"
                false
                (prime? 1001))

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 2. Benchmark Prime Verifications
  ;; ---------------------------------------------------------------------------
  (display "--- [2] Target Primes Verification for Benchmark Ranges ---") (newline)

  ;; Range > 1,000
  (assert-equal "First prime > 1000 is 1009"
                true
                (prime? 1009))
  (assert-equal "Second prime > 1000 is 1013"
                true
                (prime? 1013))
  (assert-equal "Third prime > 1000 is 1019"
                true
                (prime? 1019))

  ;; Range > 10,000
  (assert-equal "First prime > 10000 is 10007"
                true
                (prime? 10007))
  (assert-equal "Second prime > 10000 is 10009"
                true
                (prime? 10009))
  (assert-equal "Third prime > 10000 is 10037"
                true
                (prime? 10037))

  ;; Range > 100,000
  (assert-equal "First prime > 100000 is 100003"
                true
                (prime? 100003))
  (assert-equal "Second prime > 100000 is 100019"
                true
                (prime? 100019))
  (assert-equal "Third prime > 100000 is 100043"
                true
                (prime? 100043))

  ;; Range > 1,000,000
  (assert-equal "First prime > 1000000 is 1000003"
                true
                (prime? 1000003))
  (assert-equal "Second prime > 1000000 is 1000033"
                true
                (prime? 1000033))
  (assert-equal "Third prime > 1000000 is 1000037"
                true
                (prime? 1000037))

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 3. Integration & Timed Search Execution
  ;; ---------------------------------------------------------------------------
  (display "--- [3] search-for-primes Execution ---") (newline)

  (display "Searching > 1,000:")
  (search-for-primes 1000 3)

  (display "Searching > 10,000:")
  (search-for-primes 10000 3)

  (display "Searching > 100,000:")
  (search-for-primes 100000 3)

  (display "Searching > 1,000,000:")
  (search-for-primes 1000000 3)

  (newline)
  (display "=== All Tests Completed ===")
  (newline))

;; Execute suite
(run-tests)