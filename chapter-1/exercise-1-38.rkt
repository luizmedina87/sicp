#lang sicp


(#%provide (all-defined))
(#%require "./lib/math.rkt")
(#%require "./exercise-1-37.rkt")

#| Exercise 1.38: In 1737, the Swiss mathematician Leonhard
Euler published a memoir De Fractionibus Continuis, which
included a continued fraction expansion for e − 2, where
e is the base of the natural logarithms. In this fraction, the
N_i are all 1, and the D_i are successively 1, 2, 1, 1, 4, 1, 1,
6, 1, 1, 8, ... . Write a program that uses your cont-frac
procedure from Exercise 1.37 to approximate e, based on
Euler’s expansion. |#


(define (euler) 
  (define (d i)
    (let ((n (+ i 1)))
      (if (divides? 3 n)
          (expt 2 (/ n 3))
          1)))
  (+ 2 (cont-frac-iter (lambda (i) 1.0)
                       d 
                       20)))