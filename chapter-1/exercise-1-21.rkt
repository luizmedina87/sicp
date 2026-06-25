#lang sicp

#| Exercise 1.21: Use the smallest-divisor procedure to ﬁnd
the smallest divisor of each of the following numbers: 199,
1999, 19999. |#

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(display "199   -> Expected: 199   Got: ") 
(display (smallest-divisor 199))   
(display "   Pass? ")
(display (= (smallest-divisor 199) 199))
(newline)

(display "1999  -> Expected: 1999  Got: ")
(display (smallest-divisor 1999))
(display "  Pass? ")
(display (= (smallest-divisor 1999) 1999))
(newline)

(display "19999 -> Expected: 7     Got: ")
(display (smallest-divisor 19999))
(display "     Pass? ")
(display (= (smallest-divisor 19999) 7))
(newline)