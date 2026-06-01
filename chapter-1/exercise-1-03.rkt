#lang sicp

#| 
Exercise 1.3: Define a procedure that takes three numbers
as arguments and returns the sum of the squares of the two
larger numbers.
|#

; ANSWER:
(define (square a) (* a a))

(define (sum-of-squares a b) (+ (square a) (square b)))

(define (sum-of-two-largest-squares a b c)
  (cond ((and (<= a b) (<= a c)) (sum-of-squares b c))
        ((and (<= b a) (<= b c)) (sum-of-squares a c))
        (else (sum-of-squares a b))))

; Tests for sum-of-two-largest-squares
(= (sum-of-two-largest-squares 1 2 3) 13) ; all different, ascending
(= (sum-of-two-largest-squares 3 2 1) 13) ; all different, descending
(= (sum-of-two-largest-squares 2 1 3) 13) ; all different, mixed
(= (sum-of-two-largest-squares 3 3 2) 18) ; two largest are equal
(= (sum-of-two-largest-squares 2 3 3) 18) ; two largest are equal, different position
(= (sum-of-two-largest-squares 3 2 3) 18) ; two largest are equal, different position
(= (sum-of-two-largest-squares 3 3 3) 18) ; all equal
(= (sum-of-two-largest-squares 1 1 2) 5)  ; two smallest are equal
