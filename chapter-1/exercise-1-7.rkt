#lang sicp

#|
Exercise 1.7: The good-enough? test used in computing
square roots will not be very eﬀective for finding the square
roots of very small numbers. Also, in real computers, arith-
metic operations are almost always performed with lim-
ited precision. This makes our test inadequate for very large
numbers. Explain these statements, with examples showing
how the test fails for small and large numbers. An alterna-
tive strategy for implementing good-enough? is to watch
how guess changes from one iteration to the next and to
stop when the change is a very small fraction of the guess.
Design a square-root procedure that uses this kind of end
test. Does this work better for small and large numbers?
|#

#|
ANSWER:
The good-enough? procedure uses a fixed tolerance of 0.001, 
comparing the difference between the square of the guess and 
the input against that threshold. This strategy fails at both 
extremes of magnitude.

For very small numbers, the tolerance is too large relative to 
the value being computed. For example, (sqrt 0.002) returns 
0.050131352980478244 instead of the correct 0.04472. The square 
of this estimate is 0.002513, which differs from 0.002 by 
0.000513 — within the 0.001 threshold, so good-enough? accepts 
it. However, this represents a ~25% error in the square root 
estimate itself. The fixed threshold says nothing about the 
error relative to the magnitude of the number being evaluated, 
making it too coarse for small inputs.

For very large numbers, floating point arithmetic has limited 
precision, and the gaps between representable values grow larger 
as the number itself grows. For example, (sqrt 65432546546987654) 
converges to a stuck guess of 255797862.67087466. At this 
magnitude, the next representable floating point number after 
255797862.67087466 is more than 0.001 away, so improve computes 
average(255797862.67087466, 65432546546987654 / 
255797862.67087466) and gets back 255797862.67087466 exactly — 
the same value it started with. The guess is stuck because 
floating point arithmetic at this scale lacks the precision to 
make any further progress, yet good-enough? never returns true 
since the difference between the square of the guess and the 
input is far larger than 0.001. The procedure loops forever.

An alternative good-enough? strategy is to stop when the change 
in the guess from one iteration to the next is a very small 
fraction of the guess itself. This approach scales with the 
magnitude of the input, avoiding both failure modes described 
above.
|#

; TEST FUNCTIONS (UNCOMMENT TO RUN EXAMPLES)

#|
(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))
|#

; EXAMPLE FOR A SMALL NUMBER (UNCOMMENT TO RUN)

#|
(define small-sqrt (sqrt 0.002))
(display "Square-root of 0.002 using the 0.001 precision parameter: ")
(display small-sqrt)
(newline)
(display "The square of the square-root estimation computes to: ")
(display (square small-sqrt))
(newline)
(display "Which differs from 0.002 by: ")
(display (- (square small-sqrt) 0.002))
|#

; EXAMPLE FOR A BIG NUMBER (UNCOMMENT TO RUN)

#|
(define (verbose-sqrt-iter guess x)
  (display guess)
  (newline)
  (if (good-enough? guess x)
      guess
      (verbose-sqrt-iter (improve guess x) x)))

(define (verbose-sqrt x)
  (verbose-sqrt-iter 1.0 x))

(verbose-sqrt 65432546546987654)
|#