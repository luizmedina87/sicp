#lang sicp

#|
Exercise 1.6: Alyssa P. Hacker doesn’t see why if needs to
be provided as a special form. “Why can’t I just define it as
an ordinary procedure in terms of cond?” she asks. Alyssa’s
friend Eva Lu Ator claims this can indeed be done, and she
defines a new version of if:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

Eva demonstrates the program for Alyssa:

(new-if (= 2 3) 0 5)
; 5
(new-if (= 1 1) 0 5)
; 0

Delighted, Alyssa uses new-if to rewrite the square-root
program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

What happens when Alyssa attempts to use this to compute
square roots? Explain.
|#


#|
ANSWER:

When new-if is used, Scheme's applicative-order evaluation 
causes all three arguments — the predicate, the then-clause, 
and the else-clause — to be evaluated before new-if is 
applied. This means that (sqrt-iter (improve guess x) x) is 
always evaluated regardless of whether the predicate is 
satisfied, causing infinite recursion.

The built-in if avoids this problem because it is a special 
form, not a regular procedure. Special forms do not follow 
applicative-order evaluation — they evaluate the predicate 
first, and only then evaluate either the then-clause or the 
else-clause, never both. By turning if into an ordinary 
procedure, Alyssa loses this conditional evaluation behavior, 
and the program loops forever. |#

#| 
; TEST FUNCTIONS
(Will enter an infinite loop)

(#%provide (all-defined))
(#%require "./lib/math.rkt")

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 4)
|#