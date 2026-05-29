#lang sicp

#| Exercise 1.11: A function f is defined by the rule that

f(n) =   { n                             if n < 3
         { f(n-1) + 2f(n-2) + 3f(n-3)    if n >= 3

Write a procedure that computes f by means of a recursive
process. Write a procedure that computes f by means of an
iterative process. |#


; ANSWER:
; (RECURSIVE PROCESS)
(define (f-rec n)
  (if (< n 3)
      n
      (+ (f-rec (- n 1))
         (* 2 (f-rec (- n 2)))
         (* 3 (f-rec (- n 3))))))

; TESTS
(newline)
(display "Tests for the recursive process procedure")
(newline)
(display "-----------------------------------------")
(newline)
(display "(f-rec 0): ") (display (= (f-rec 0) 0)) (newline)
(display "(f-rec 1): ") (display (= (f-rec 1) 1)) (newline)
(display "(f-rec 2): ") (display (= (f-rec 2) 2)) (newline)
(display "(f-rec 3): ") (display (= (f-rec 3) 4)) (newline)
(display "(f-rec 4): ") (display (= (f-rec 4) 11)) (newline)
(display "(f-rec 5): ") (display (= (f-rec 5) 25)) (newline)


; ANSWER:
; (ITERATIVE PROCESS)
(define (f-iter n) ; iterative process
  (define (f-iter-rec a b c count) ; recursive procedure
    (if (= count 0)
        c
        (f-iter-rec (+ a (* 2 b) (* 3 c)) a b (- count 1))))
  (f-iter-rec 2 1 0 n))

; TESTS
(newline)
(display "Tests for the iterative process procedure")
(newline)
(display "-----------------------------------------")
(newline)
(display "(f-iter 0): ") (display (= (f-iter 0) 0)) (newline)
(display "(f-iter 1): ") (display (= (f-iter 1) 1)) (newline)
(display "(f-iter 2): ") (display (= (f-iter 2) 2)) (newline)
(display "(f-iter 3): ") (display (= (f-iter 3) 4)) (newline)
(display "(f-iter 4): ") (display (= (f-iter 4) 11)) (newline)
(display "(f-iter 5): ") (display (= (f-iter 5) 25)) (newline)