#lang sicp

(#%require "../exercise-1-35.rkt")
(#%require "../lib/test.rkt")


;; =============================================================================
;; Helpers & Constants
;; =============================================================================

;; Mathematical Golden Ratio: (1 + sqrt(5)) / 2
(define phi-exact (/ (+ 1 (sqrt 5)) 2))

;; =============================================================================
;; Test Suite Execution
;; =============================================================================

(define (run-tests)
  (newline)
  (display "=== Running Exercise 1.35 Test Suite ===")
  (newline)
  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 1. Generic fixed-point Unit Tests
  ;; ---------------------------------------------------------------------------
  (display "--- [1] Generic fixed-point Procedure ---") (newline)

  ;; Fixed point of x -> cos(x) starting at 1.0 is ~0.73908
  (assert-close "Fixed point of x -> cos(x) starting at 1.0"
                0.73908
                (fixed-point cos 1.0)
                0.001)

  ;; Fixed point of y -> (y + 2/y)/2 calculates sqrt(2) ~1.41421
  (assert-close "Fixed point averaging y -> (y + 2/y)/2 converges to sqrt(2)"
                1.41421
                (fixed-point (lambda (y) (/ (+ y (/ 2.0 y)) 2.0)) 1.0)
                0.001)

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 2. Golden Ratio Computation (x -> 1 + 1/x)
  ;; ---------------------------------------------------------------------------
  (display "--- [2] Golden Ratio (phi) Transformation ---") (newline)

  (let ((phi-computed (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)))

    (assert-close "Fixed point of x -> 1 + 1/x matches (1 + sqrt(5))/2 (~1.61803)"
                  phi-exact
                  phi-computed
                  0.0001)

    (assert-close "Verifying fixed-point property: f(phi) approx phi"
                  phi-computed
                  (+ 1 (/ 1 phi-computed))
                  0.00001))

  ;; Convergence from a different initial guess (2.0)
  (assert-close "Converges to golden ratio starting from initial guess 2.0"
                phi-exact
                (fixed-point (lambda (x) (+ 1 (/ 1 x))) 2.0)
                0.0001)

  ;; Convergence from a large initial guess (10.0)
  (assert-close "Converges to golden ratio starting from initial guess 10.0"
                phi-exact
                (fixed-point (lambda (x) (+ 1 (/ 1 x))) 10.0)
                0.0001)

  (newline)
  (display "=== All Tests Completed ===")
  (newline))

;; Execute suite
(run-tests)