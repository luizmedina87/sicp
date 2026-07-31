#lang sicp


#| Exercise 1.32:

a. Show that sum and product (Exercise 1.31) are both
   special cases of a still more general notion called accumulate
   that combines a collection of terms, using some gen-
   eral accumulation function:

   (accumulate combiner null-value term a next b)

   accumulate takes as arguments the same term and
   range specifications as sum and product, together with
   a combiner procedure (of two arguments) that speci-
   fies how the current term is to be combined with the
   accumulation of the preceding terms and a null-value
   that specifies what base value to use when the terms
   run out. Write accumulate and show how sum and
   product can both be defined as simple calls to accumulate.

b. If your accumulate procedure generates a recursive
   process, write one that generates an iterative process.
   If it generates an iterative process, write one that gen-
   erates a recursive process. 
   

Note: the exercise is refering to the following summation and
product procedures:

* Recursive and Iterative Sum:

	(define (sum term a next b)
		(if (> a b)
				0
				(+ (term a)
					(sum term (next a) next b)))) 
					
	(define (sum term a next b)
		(define (iter a result)
			(if (> a b)
					result
					(iter (next a) (+ (term a) result))))
		(iter a 0))

* Recursive and Iterative Product:

	(define (product term a next b)
		(if (> a b)
			1
			(* (term a)
					(product term (next a) next b)))) 

	(define (product-iter term a next b)
		(define (iter a result)
			(if (> a b)
					result
					(iter (next a) (* (term a) result))))
		(iter a 1)) |#




; ===============================================================
; Answer
; ===============================================================

(define (accumulate-rec combiner null-value term a next b)
	(if (> a b)
			null-value
			(combiner (term a)
								(accumulate-rec combiner 
																null-value 
																term 
																(next a) 
																next
																b))))

(define (accumulate-iter combiner null-value term a next b)
	(define (iter a result)
		(if (> a b)
				result
				(iter (next a) (combiner (term a) result))))
	(iter a null-value))




; ===============================================================
; Test Harness
; ===============================================================

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

; ===============================================================
; Helpers & Derived Definitions
; ===============================================================

(define (inc x) (+ x 1))
(define (identity x) x)
(define (square x) (* x x))

; Derived implementations using accumulate-rec
(define (sum-rec term a next b)
  (accumulate-rec + 0 term a next b))

(define (product-rec term a next b)
  (accumulate-rec * 1 term a next b))

; Derived implementations using accumulate-iter
(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

; ===============================================================
; Test Suite Execution
; ===============================================================

(define (run-tests)
  (newline)
  (display "=== Running Exercise 1.32 Test Suite ===")
  (newline)
  (newline)

  ; -------------------------------------------------------------
  ; 1. accumulate-rec Tests
  ; -------------------------------------------------------------
  (display "--- [1] Testing accumulate-rec ---") (newline)
  
  (assert-equal "rec: Base case (a > b) returns null-value"
                42
                (accumulate-rec + 42 identity 5 inc 1))

  (assert-equal "rec: Single element range (a = b)"
                10
                (accumulate-rec + 0 identity 10 inc 10))

  (assert-equal "rec: Sum of integers 1 to 5"
                15
                (accumulate-rec + 0 identity 1 inc 5))

  (assert-equal "rec: Product of integers 1 to 4"
                24
                (accumulate-rec * 1 identity 1 inc 4))

  ; Non-commutative test (fold-right order: cons 1 onto (cons 2 
	; onto (cons 3 '())))
  (assert-equal "rec: Non-commutative cons produces right-fold '(1 2 3)"
                '(1 2 3)
                (accumulate-rec cons '() identity 1 inc 3))

  (newline)

  ; -------------------------------------------------------------
  ; 2. accumulate-iter Tests
  ; -------------------------------------------------------------
  (display "--- [2] Testing accumulate-iter ---") (newline)

  (assert-equal "iter: Base case (a > b) returns null-value"
                42
                (accumulate-iter + 42 identity 5 inc 1))

  (assert-equal "iter: Single element range (a = b)"
                10
                (accumulate-iter + 0 identity 10 inc 10))

  (assert-equal "iter: Sum of integers 1 to 5"
                15
                (accumulate-iter + 0 identity 1 inc 5))

  (assert-equal "iter: Product of integers 1 to 4"
                24
                (accumulate-iter * 1 identity 1 inc 4))

  ; Non-commutative test (fold-left order: conses into 
	; accumulator, reversing input)
  (assert-equal "iter: Non-commutative cons produces left-fold '(3 2 1)"
                '(3 2 1)
                (accumulate-iter cons '() identity 1 inc 3))

  (newline)

  ; -------------------------------------------------------------
  ; 3. Equivalence Tests (rec vs. iter on commutative operations)
  ; -------------------------------------------------------------
  (display "--- [3] Direct Equivalence Checks ---") (newline)

  (assert-equal "rec and iter yield same sum for 1..100"
                (accumulate-rec + 0 identity 1 inc 100)
                (accumulate-iter + 0 identity 1 inc 100))

  (assert-equal "rec and iter yield same sum of squares 1..10"
                (accumulate-rec + 0 square 1 inc 10)
                (accumulate-iter + 0 square 1 inc 10))

  (assert-equal "rec and iter yield same product for 1..6"
                (accumulate-rec * 1 identity 1 inc 6)
                (accumulate-iter * 1 identity 1 inc 6))

  (newline)

  ; -------------------------------------------------------------
  ; 4. Derived Functions (sum & product)
  ; -------------------------------------------------------------
  (display "--- [4] Derived sum and product Procedures ---")
	(newline)

  (assert-equal "sum-rec: 1 + 4 + 9 = 14"
                14
                (sum-rec square 1 inc 3))

  (assert-equal "sum-iter: 1 + 4 + 9 = 14"
                14
                (sum-iter square 1 inc 3))

  (assert-equal "product-rec: 2 * 4 * 6 = 48"
                48
                (product-rec identity 2 (lambda (x) (+ x 2)) 6))

  (assert-equal "product-iter: 2 * 4 * 6 = 48"
                48
                (product-iter identity 2 (lambda (x) (+ x 2)) 6))

  (newline)
  (display "=== All Tests Completed ===")
  (newline))

; Run the suite
(run-tests)