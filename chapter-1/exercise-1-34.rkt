#lang sicp


#| Exercise 1.34: Suppose we define the procedure

(define (f g) (g 2))

Then we have

(f square)
4
(f (lambda (z) (* z (+ z 1))))
6

What happens if we (perversely) ask the interpreter to eval-
uate the combination (f f)? Explain. |#


#| ANSWER:
Evaluating (f f) using applicative-order evaluation proceeds 
step-by-step:

1. (f f)  --> (f 2)
  The outer `f` applies to `f`, replacing parameter `g` with `f`
  in `(g 2)`.

2. (f 2)  --> (2 2)
  `f` now applies to `2`, replacing parameter `g` with `2` in 
  `(g 2)`.

3. (2 2)  --> ERROR
  The interpreter attempts to evaluate `(2 2)`, treating the 
  number `2` as a procedure. Because 2 is not a procedure, 
  execution halts with:
  "application: not a procedure; given: 2" |#