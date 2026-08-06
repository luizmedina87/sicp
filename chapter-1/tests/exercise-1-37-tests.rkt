#lang sicp

(#%require "../exercise-1-37.rkt")
(#%require "../lib/math.rkt")
(#%require "../lib/test.rkt")


;; =============================================================================
;; Test Helpers
;; =============================================================================

(define phi-inv (/ (- (sqrt 5) 1) 2.0)) ; 1/phi approx 0.6180339887

(define (approx-phi-inv procedure k)
  (procedure (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))

(define (find-min-k procedure tolerance)
  (define (iter k)
    (let ((result (approx-phi-inv procedure k)))
      (if (< (abs (- result phi-inv)) tolerance)
          k
          (iter (+ k 1)))))
  (iter 1))


;; =============================================================================
;; Test Suite Execution
;; =============================================================================

(define (run-tests)
  (newline)
  (display "=== Running Exercise 1.37 Test Suite ===")
  (newline)
  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 1. Recursive vs. Iterative Equivalence
  ;; ---------------------------------------------------------------------------
  (display "--- [1] Structural Equivalence (rec vs iter) ---") (newline)

  (assert-close "k=1: Recursive matches Iterative"
                (approx-phi-inv cont-frac-rec 1)
                (approx-phi-inv cont-frac-iter 1)
                0.00001)

  (assert-close "k=5: Recursive matches Iterative"
                (approx-phi-inv cont-frac-rec 5)
                (approx-phi-inv cont-frac-iter 5)
                0.00001)

  (assert-close "k=11: Recursive matches Iterative"
                (approx-phi-inv cont-frac-rec 11)
                (approx-phi-inv cont-frac-iter 11)
                0.00001)

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 2. Golden Ratio Approximation Accuracy
  ;; ---------------------------------------------------------------------------
  (display "--- [2] 1/phi Approximation Accuracy ---") (newline)

  (assert-close "k=11 gives 1/phi accurate to 4 decimal places (rec)"
                phi-inv
                (approx-phi-inv cont-frac-rec 11)
                0.0001)

  (assert-close "k=11 gives 1/phi accurate to 4 decimal places (iter)"
                phi-inv
                (approx-phi-inv cont-frac-iter 11)
                0.0001)

  (newline)

  ;; ---------------------------------------------------------------------------
  ;; 3. Minimum k Determination
  ;; ---------------------------------------------------------------------------
  (display "--- [3] Minimum k Determination ---") (newline)

  (let ((k-rec  (find-min-k cont-frac-rec 0.0001))
        (k-iter (find-min-k cont-frac-iter 0.0001)))

    (assert-close "Minimum k for recursive process is 10"
                  10
                  k-rec
                  1)

    (assert-close "Minimum k for iterative process is 10"
                  10
                  k-iter
                  1))

  (newline)
  (display "=== All Tests Completed ===")
  (newline))

;; Execute suite
(run-tests)