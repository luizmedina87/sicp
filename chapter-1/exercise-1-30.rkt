#lang sicp

#| Exercise 1.30: The sum procedure above generates a linear 
recursion. The procedure can be rewritten so that the sum 
is performed iteratively. Show how to do this by filling in 
the missing expressions in the following definition:

(define (sum term a next b)
  (define (iter a result)
    (if <??>
        <??>
        (iter <??> <??>)))
  (iter <??> <??>)) 
  
Note: the exercise is refering to the following summation:

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b)))) |#

; =================== ANSWER ===================
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))


; ==================== TESTS ====================

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

; Helper helper functions for testing
(define (inc x) (+ x 1))
(define (identity x) x)
(define (square x) (* x x))
(define (cube x) (* x x x))
(define (add-two x) (+ x 2))

(define (run-tests)
  ;; 1. Standard range sum
  (test "Sum integers 1 to 10" 
        (sum identity 1 inc 10) 
        55)

  ;; 2. Empty range where a > b
  (test "Empty range (10 to 1)" 
        (sum identity 10 inc 1) 
        0)

  ;; 3. Single element range where a = b
  (test "Single element range (5 to 5)" 
        (sum identity 5 inc 5) 
        5)

  ;; 4. Sum of squares
  (test "Sum of squares 1 to 5" 
        (sum square 1 inc 5) 
        55)  ; 1 + 4 + 9 + 16 + 25

  ;; 5. Sum of cubes
  (test "Sum of cubes 1 to 10" 
        (sum cube 1 inc 10) 
        3025)

  ;; 6. Custom step size (sum of odd numbers)
  (test "Sum odd numbers 1 to 9" 
        (sum identity 1 add-two 9) 
        25)  ; 1 + 3 + 5 + 7 + 9

  ;; 7. Range with negative numbers
  (test "Sum range -3 to 3" 
        (sum identity -3 inc 3) 
        0))  ; -3 + -2 + -1 + 0 + 1 + 2 + 3

(run-tests)