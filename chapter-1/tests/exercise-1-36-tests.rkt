#lang sicp

(#%require "../exercise-1-36.rkt")
(#%require "../lib/math.rkt")
(#%require "../lib/test.rkt")


;; =============================================================================
;; Test Suite Execution
;; =============================================================================

(define (run-tests)
  (newline)
  (display "=== Running Exercise 1.36 Test Suite ===")
  (newline)
  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 1. Core fixed-point-verbose Unit Tests
  ;; ---------------------------------------------------------------------------
  (display "--- [1] Generic fixed-point-verbose ---") (newline)

  ;; Test with Golden Ratio: x -> 1 + 1/x (Golden Ratio phi approx 1.61803)
  (assert-close "Finds Golden Ratio (1 + 1/x) ~ 1.61803"
                1.61803
                (fixed-point-verbose (lambda (x) (+ 1 (/ 1.0 x)))
                                     1.0
                                     0.00001
                                     false)
                0.0001)

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 2. Part A: Solution without Average Damping
  ;; ---------------------------------------------------------------------------
  (display "--- [2] Non-Average Damped fixed point ---") (newline)

  (let ((result (fixed-point-verbose (lambda (x) (/ (log 1000) (log x)))
                                     1.5
                                     0.00001
                                     false)))
    (assert-close "Calculates x for x^x = 1000 (~ 4.55553)"
                  4.55553
                  result
                  0.0001)

    (assert-close "Verifies solution property: x^x approx 1000"
                  1000.0
                  (expt result result)
                  1.0))

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 3. Part B: Solution with Average Damping
  ;; ---------------------------------------------------------------------------
  (display "--- [3] Average Damped fixed point ---") (newline)

  (let ((result (fixed-point-verbose (lambda (x) 
                                       (average x (/ (log 1000) (log x))))
                                     1.5
                                     0.00001
                                     false)))
    (assert-close "Calculates x with damping (~ 4.55553)"
                  4.55553
                  result
                  0.0001)

    (assert-close "Verifies solution property: x^x approx 1000"
                  1000.0
                  (expt result result)
                  1.0))

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 4. Convergence Equivalence Check
  ;; ---------------------------------------------------------------------------
  (display "--- [4] Cross-Method Consistency ---") (newline)

  (let ((undamped (fixed-point-verbose (lambda (x) (/ (log 1000) (log x))) 
                                       1.5 0.00001 false))
        (damped   (fixed-point-verbose (lambda (x) (average x (/ (log 1000) (log x)))) 
                                       1.5 0.00001 false)))
    (assert-close "Both methods converge to the same value within tolerance"
                  undamped
                  damped
                  0.0001))

  (newline)
  (display "=== All Tests Completed ===")
  (newline))

;; Execute suite
(run-tests)