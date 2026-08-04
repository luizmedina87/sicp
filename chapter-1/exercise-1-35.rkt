#lang sicp

(#%provide (all-defined))

#| Exercise 1.35: Show that the golden ratio ϕ (Section 1.2.2)
is a fixed point of the transformation x → 1 + 1/x, and
use this fact to compute ϕ by means of the fixed-point
procedure. |#


#| ANSWER:
The golden ratio is given by the solutions to the equation:

φ² = φ + 1

Dividing both sides by φ yields:

φ = 1 + 1/φ 

Meaning the golden ratio can be found by finding the fixed 
point of the transformation x → 1 + 1/x. |#

(define tolerance 0.00001)
(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2))
			 tolerance))
	(define (try guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
					next
					(try next))))
	(try first-guess))

#| The solution to the equation can be found by:
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0) |#