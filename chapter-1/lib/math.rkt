#lang sicp

(#%provide (all-defined))


(define (average x y) (/ (+ x y) 2))

(define (close a b tolerance) (< (abs (- a b)) tolerance))

(define (cube x) (* x x x))

(define (divides? a b) (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (define (next test-divisor)
    (if (even? test-divisor)
        (+ 1 test-divisor)
        (+ 2 test-divisor)))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (smallest-divisor n) (find-divisor n 2))

(define (square x) (* x x))

