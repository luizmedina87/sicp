#lang sicp


#| Exercise 1.29: Simpson’s Rule is a more accurate method
of numerical integration than the method illustrated above.
Using Simpson’s Rule, the integral of a function f between
a and b is approximated as

h/3 * (y₀ + 4y₁ + 2y₂ + 4y₃ + 2y₄ + ... + 2yₙ₋₂ + 4yₙ₋₁ + yₙ)

where h = (b - a)/n, for some even integer n, and yₖ = f(a + kh).
(Increasing n increases the accuracy of the approximation.)
Define a procedure that takes as arguments f, a, b, and n and
returns the value of the integral, computed using Simpson’s Rule.
Use your procedure to integrate cube between 0 and 1 (with n=100
and n=1000), and compare the results to those of the integral
procedure shown above. |#


#| ANSWER Simpson's Rule Implementation
Computes the integral of f from a to b using Simpson's Rule:
  (h / 3) * [ f(a) + f(b) + 4 * sum(odds) + 2 * sum(evens) ]

Implementation Notes:
1. Local variable h is defined as (/ (- b a) n) and reused.
2. Odd terms start at (+ a h), stepping by 2h up to b.
3. Even terms start at (+ a (* 2 h)), stepping by 2h up to
   (- b h). Stopping at (- b h) prevents double counting f(b).

Explanation of Test Results:
Simpson's Rule uses quadratic polynomials for approximation.
Due to symmetry in its error term, it is mathematically exact
for any polynomial up to degree 3.

For f(x) = x^3, theoretical error is zero for any even n >= 2.
The tiny error near 10^-16 seen in the test output is entirely
floating-point rounding noise. Running n = 1000 requires ten
times more additions than n = 100, accumulating slightly more
rounding noise. This is why accuracy appears to drop with a
larger n on cubic functions.

For f(x) = x^4, the fourth derivative is non-zero, so actual
mathematical error exists. Increasing n from 100 to 1000
shrinks that math error by a factor of 10,000 (from 10^-9 down
to 10^-13), which easily dominates the tiny float noise and
causes the accuracy trend test to pass as expected.
|#


(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpsons-integral f a b n)
  (define h (/ (- b a) n))
  (define (inc x) (+ x (* 2 h)))
  (* (/ h 3) (+ (f a)
                (f b)
                (* 4 (sum f (+ a h) inc b))
                (* 2 (sum f (+ a (* 2 h)) inc (- b h))))))


; ====================== TESTS ======================
(define (run-simpson-suite f a b exact-answer)
  (define tolerance 0.00001)

  (define (test-n n)
    (let* ((result (simpsons-integral f a b n))
           (err (abs (- result exact-answer)))
           (passed? (< err tolerance)))
      (display "n = ") (display n)
      (display " | expected: ") (display exact-answer)
      (display " | got: ") (display result)
      (display " | error: ") (display err)
      (display " | test: ") (display (if passed? "PASSED" "FAILED"))
      (newline)
      err))

  (let ((err-100 (test-n 100))
        (err-1000 (test-n 1000)))
    (display "Accuracy Trend Test (n=1000 err < n=100 err): ")
    (if (< err-1000 err-100)
        (display "PASSED (Accuracy increased with larger n)")
        (display "FAILED (Accuracy did NOT increase with larger n)"))
    (newline)))

;; --- Test 1: cube (x^3) from 0 to 1 ---
(display "=== Testing cube (x^3) ===") (newline)
(run-simpson-suite cube 0.0 1.0 0.25)

(newline)

;; --- Test 2: x^4 from 0 to 1 ---
(display "=== Testing x^4 ===") (newline)
(run-simpson-suite (lambda (x) (* x x x x)) 0.0 1.0 0.2)