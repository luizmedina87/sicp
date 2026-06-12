#lang sicp
; (#%require racket/trace)

#| Exercise 1.18: Using the results of Exercise 1.16 and Exer-
cise 1.17, devise a procedure that generates an iterative pro-
cess for multiplying two integers in terms of adding, dou-
bling, and halving and uses a logarithmic number of steps. |#

(define (double x)
  (* x 2))

(define (halve x)
  (/ x 2))

(define (odd? x)
  (= (remainder x 2) 1))

(define (iter* m a b)
  (cond ((< b 0) (iter* m (- a) (- b)))
        ((= b 0) m)
        ((odd? b) (iter* (+ m a) a (- b 1)))
        (else (iter* m (double a) (halve b)))))

(define (fast* a b)
  (iter* 0 a b))

; --- TEST CASES ---
; (trace fast*)
(= (fast* 5 0) 0)     ; Expected: #t (Multiply by zero)
(= (fast* 7 1) 7)     ; Expected: #t (Multiply by one)
(= (fast* 4 6) 24)    ; Expected: #t (Even x Even)
(= (fast* 3 5) 15)    ; Expected: #t (Odd x Odd)
(= (fast* 8 3) 24)    ; Expected: #t (Even x Odd)
(= (fast* 3 8) 24)    ; Expected: #t (Odd x Even)
(= (fast* 10 20) 200) ; Expected: #t (Larger numbers)
(= (fast* -5 3) -15)  ; Expected: #t (Negative a, positive odd b)
(= (fast* -4 6) -24)  ; Expected: #t (Negative a, positive even b)
(= (fast* 5 -3) -15)  ; Expected: #t (Positive a, negative b)
(= (fast* -4 -6) 24)  ; Expected: #t (Negative a, negative b)