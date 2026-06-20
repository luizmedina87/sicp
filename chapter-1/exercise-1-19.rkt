#lang sicp

#| Exercise 1.19: There is a clever algorithm for computing
the Fibonacci numbers in a logarithmic number of steps.
Recall the transformation of the state variables a and b in
the fib-iter process of Section 1.2.2: a ← a + b and b ← a.
Call this transformation T, and observe that applying T
over and over again n times, starting with 1 and 0, produces
the pair Fib(n + 1) and Fib(n). In other words, the Fibonacci
numbers are produced by applying Tⁿ, the nth power of the
transformation T, starting with the pair (1, 0). Now consider
T to be the special case of p = 0 and q = 1 in a family of
transformations T_{pq}, where T_{pq} transforms the pair (a, b)
according to a ← bq + aq + ap and b ← bp + aq. Show
that if we apply such a transformation T_{pq} twice, the effect
is the same as using a single transformation T_{p'q'} of the
same form, and compute p′ and q′ in terms of p and q. This
gives us an explicit way to square these transformations,
and thus we can compute Tⁿ using successive squaring, as
in the fast-expt procedure. Put this all together to complete
the following procedure, which runs in a logarithmic number
of steps: 

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                  ;  ⟨??⟩ ; compute p′
                  ;  ⟨??⟩ ; compute q′
                   (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))
|#

#| ANSWER:
a ← bq + aq + ap
b ← bp + aq

After applying transformation T:

a ← (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
a ← bpq + aq² + bq² + aq² + apq + bpq + apq + ap²
a ← b(q² + 2pq) + a(q² + 2pq) + a(q² + p²)

b ← (bp + aq)p + (bq + aq + ap)q
b ← bp² + apq + bq² + aq² + apq
b ← b(p² + q²) + a(q² + 2pq) 

Therefore:
q' = q² + 2pq
p' = p² + q² |#


(define (even? x)
  (= (remainder x 2) 0))

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                  (+ (* p p) (* q q))
                  (+ (* q q) (* 2 p q))
                   (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))

; TESTS:
(define (check label expected actual)
  (display label)
  (display " | expected: ") (display expected)
  (display " | got: ") (display actual)
  (display " | ")
  (display (if (= expected actual) "PASS" "FAIL"))
  (newline))

(check "fib(0)" 0  (fib 0))
(check "fib(1)" 1  (fib 1))
(check "fib(2)" 1  (fib 2))
(check "fib(3)" 2  (fib 3))
(check "fib(4)" 3  (fib 4))
(check "fib(5)" 5  (fib 5))
(check "fib(6)" 8  (fib 6))
(check "fib(7)" 13 (fib 7))
(check "fib(10)" 55  (fib 10))
(check "fib(20)" 6765 (fib 20))