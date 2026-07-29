#lang sicp


#| Exercise 1.31:

a. The sum procedure is only the simplest of a vast number
   of similar abstractions that can be captured as higher-
   order procedures.¹ Write an analogous procedure called
   product that returns the product of the values of a
   function at points over a given range. Show how to de-
   fine factorial in terms of product. Also use product
   to compute approximations to π using the formula²

        π     2 · 4 · 4 · 6 · 6 · 8 ···
       --- = ---------------------------
        4     3 · 3 · 5 · 5 · 7 · 7 ···

b. If your product procedure generates a recursive pro-
   cess, write one that generates an iterative process. If
   it generates an iterative process, write one that gen-
   erates a recursive process.

------------------------------------------------------------
¹The intent of Exercise 1.31 through Exercise 1.33 is to 
demonstrate the expressive power that is attained by using 
an appropriate abstraction to consolidate many seemingly 
disparate operations. However, though accumulation and 
filtering are elegant ideas, our hands are somewhat tied 
in using them at this point since we do not yet have data 
structures to provide suitable means of combination for 
these abstractions. We will return to these ideas in 
Section 2.2.3 when we show how to use sequences as 
interfaces for combining filters and accumulators to build 
even more powerful abstractions. We will see there how 
these methods really come into their own as a powerful 
and elegant approach to designing programs.

²This formula was discovered by the seventeenth-century 
English mathematician John Wallis. |#


; ==========================================
; Answers
; ==========================================

; Implementation of recursive and iteration product

(define (product-rec term a next b)
	(if (> a b)
			1
			(* (term a)
				 (product-rec term (next a) next b))))

(define (product-iter term a next b)
	(define (iter a result)
		(if (> a b)
				result
				(iter (next a) (* (term a) result))))
	(iter a 1))


; Implementation of factorial

(define (inc n) (+ n 1))

(define (identity n) n)

(define (factorial n)
	(product-iter identity 1 inc n))


; Implementation of pi estimate

(define (impr-estimate-factor k)
	(define (even? n) (= (remainder n 2) 0))
	(if (even? k)
			(/ (+ k 2) (+ k 1))
			(/ (+ k 1) (+ k 2))))

(define (pi-estimate n)
	(* 4 (product-iter impr-estimate-factor 1 inc n)))


; ==========================================
; Test Suite Helpers
; ==========================================

(define (test name actual expected)
  (display name)
  (display " ... ")
  (if (= actual expected)
      (begin (display "PASS") (newline))
      (begin
        (display "FAIL")
        (display " (Expected: ")
        (display expected)
        (display ", Got: ")
        (display actual)
        (display ")")
        (newline))))

;; Helper for testing real-number approximations within a tolerance
(define (test-approx name actual expected tolerance)
  (display name)
  (display " ... ")
  (let ((diff (abs (- (exact->inexact actual) (exact->inexact expected)))))
    (if (< diff tolerance)
        (begin (display "PASS") (newline))
        (begin
          (display "FAIL")
          (display " (Expected ~")
          (display (exact->inexact expected))
          (display ", Got: ")
          (display (exact->inexact actual))
          (display ")")
          (newline)))))

;; Helpers for higher-order function tests
(define (square x) (* x x))
(define (add-two x) (+ x 2))

; ==========================================
; Run Tests
; ==========================================

(define (run-product-tests prod-fn fn-name)
  (display "Testing higher-order function: ") (display fn-name) (newline)
  (display "------------------------------------------") (newline)
  
  ; 1. Standard range product (1 * 2 * 3 * 4 * 5)
  (test "Product 1 to 5" 
        (prod-fn identity 1 inc 5) 
        120)

  ; 2. Empty range where a > b (Multiplicative identity check)
  (test "Empty range (10 to 1)" 
        (prod-fn identity 10 inc 1) 
        1)

  ; 3. Single element range (5 to 5)
  (test "Single element range (5 to 5)" 
        (prod-fn identity 5 inc 5) 
        5)

  ; 4. Product of squares 1 to 4 (1 * 4 * 9 * 16)
  (test "Product of squares 1 to 4" 
        (prod-fn square 1 inc 4) 
        576)

  ; 5. Custom step size (product of odd numbers 1 to 5 -> 1 * 3 * 5)
  (test "Product of odd numbers 1 to 5" 
        (prod-fn identity 1 add-two 5) 
        15)

  (newline))

(define (run-factorial-tests)
  (display "Testing standalone procedure: factorial") (newline)
  (display "------------------------------------------") (newline)

  ; 1. Key Edge Case: 0! = 1
  (test "Factorial of 0" 
        (factorial 0) 
        1)

  ; 2. Edge Case: 1! = 1
  (test "Factorial of 1" 
        (factorial 1) 
        1)

  ; 3. Standard case: 5! = 120
  (test "Factorial of 5" 
        (factorial 5) 
        120)

  ; 4. Larger value: 7! = 5040
  (test "Factorial of 7" 
        (factorial 7) 
        5040)

  (newline))

(define (run-pi-tests)
  (display "Testing standalone procedure: pi-estimate") (newline)
  (display "------------------------------------------") (newline)

  ; 1. Single term approximation (n = 1): (2/3) * (4/3) * 4 = 32/9 ≈ 3.5555
  (test-approx "Pi estimate (1 term)" 
               (pi-estimate 1) 
               (/ 32 9) 
               0.0001)

  ; 2. Two terms approximation (n = 2): 32/9 * (4/5) * (6/5) = 256/75 ≈ 3.4133
  (test-approx "Pi estimate (2 terms)" 
               (pi-estimate 2) 
               (/ 256 75) 
               0.0001)

  ; 3. Large n (n = 1000): should converge close to 3.14159
  (test-approx "Pi estimate (1000 terms) ≈ 3.14" 
               (pi-estimate 1000) 
               3.14159 
               0.01)

  (newline))

(define (run-all-tests)
  (newline)
  (display "==========================================") (newline)
  (display "       EXERCISE 1.31 TEST SUITE           ") (newline)
  (display "==========================================") (newline)
  
  (run-product-tests product-rec "product-rec")
  (run-product-tests product-iter "product-iter")
  (run-factorial-tests)
  (run-pi-tests)
  
  (display "==========================================") (newline))

(run-all-tests)