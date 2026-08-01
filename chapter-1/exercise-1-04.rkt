#lang sicp

(#%provide (all-defined))

#|
Exercise 1.4: Observe that our model of evaluation allows
for combinations whose operators are compound expres-
sions. Use this observation to describe the behavior of the
following procedure:
|#

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

#|
ANSWER: The function evaluates the combination (+ a b) if b > 0, 
and (- a b) otherwise. This is equivalente to returning
a + |b| since it makes b positive in case it is a negative
number.
|#