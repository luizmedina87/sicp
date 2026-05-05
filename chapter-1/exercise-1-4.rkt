#lang sicp

#|
Exercise 1.4: Observe that our model of evaluation allows
for combinations whose operators are compound expres-
sions. Use this observation to describe the behavior of the
following procedure:
|#

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; TEST
(= (a-plus-abs-b 3 2) 5) ; b positive, returns a + b
(= (a-plus-abs-b 3 -2) 5) ; b negative, returns a - b = a + |b|
(= (a-plus-abs-b 0 0) 0) ; both zero
(= (a-plus-abs-b 3 0) 3) ; b is zero
(= (a-plus-abs-b -3 2) -1) ; a negative, b positive
(= (a-plus-abs-b -3 -2) -1) ; a negative, b negative

#|
ANSWER: The function evaluates the combination (+ a b) if b > 0, 
and (- a b) otherwise. This is equivalente to returning
a + |b| since it makes b positive in case it is a negative
number.
|#