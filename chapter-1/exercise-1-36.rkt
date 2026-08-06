#lang sicp

(#%require "./lib/math.rkt")
(#%provide (all-defined))


#| Exercise 1.36: Modify fixed-point so that it prints the
sequence of approximations it generates, using the newline
and display primitives shown in Exercise 1.22. Then find
a solution to x^x = 1000 by finding a fixed point of x →
log(1000)/log(x). (Use Scheme’s primitive log procedure,
which computes natural logarithms.) Compare the number
of steps this takes with and without average damping. (Note
that you cannot start fixed-point with a guess of 1, as this
would cause division by log(1) = 0.) |#


; ===================== IMPLEMENTATION =====================
(define (fixed-point-verbose f first-guess tolerance verbose)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2))
			 tolerance))
	(define (print-verbose count)
		(if verbose
			 (begin 
			 	 (display "Process required ")
				 (display count)
				 (display " iterations, with an error margin of ")
				 (display tolerance)
				 (display ", to reach the estimate of "))
			 false))
	(define (try guess count)
		(let ((next (f guess))
					(count (+ count 1)))
			(if (close-enough? guess next)
					(begin
						(print-verbose count)
						next)
					(try next count))))
	(try first-guess 1))

#| (display "Avg damping:") (newline)
(fixed-point-verbose (lambda (x) 
										 (average x 
															(/ (log 1000) 
																 (log x))))
						 				 1.5
										 0.00001
										 true)

(display "Non avg damping:") (newline)
(fixed-point-verbose (lambda (x) 
										 (/ (log 1000) 
												(log x)))
						         1.5
						         0.00001
										 true) |#

#| ======================== ANSWER ========================

Average damping yielded faster results, taking only 12 
steps compared to 36 steps without damping.

Averaging x and f(x) dampens the oscillations around the
fixed point (~4.5555), driving much faster convergence. |#