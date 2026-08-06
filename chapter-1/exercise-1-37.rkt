#lang sicp

(#%provide (all-defined))
(#%require "./lib/math.rkt")


#| Exercise 1.37: a. An infinite continued fraction is 
an expression of the form:

             N_1
    f = --------------
              N_2
        D_1 + --------
                D_2 + ...

As an example, one can show that the infinite continued 
fraction expansion with the N_i and the D_i all equal 
to 1 produces 1/φ, where φ is the golden ratio (described 
in Section 1.2.2). One way to approximate an infinite 
continued fraction is to truncate the expansion after a 
given number of terms. Such a truncation—a so-called 
k-term finite continued fraction—has the form:

             N_1
    ---------------------
             N_2
    D_1 + ---------------
               ... + N_k
                     ---
                     D_k

Suppose that `n` and `d` are procedures of one argument 
(the term index `i`) that return the N_i and D_i of the 
terms of the continued fraction. Define a procedure 
`cont-frac` such that evaluating `(cont-frac n d k)` 
computes the value of the k-term finite continued 
fraction. Check your procedure by approximating 1/φ 
using:

    (cont-frac (lambda (i) 1.0)
               (lambda (i) 1.0)
               k)

for successive values of k. How large must you make k 
in order to get an approximation that is accurate to 
4 decimal places?

b. If your `cont-frac` procedure generates a recursive 
process, write one that generates an iterative process. 
If it generates an iterative process, write one that 
generates a recursive process.
|#


(define (cont-frac-rec n d k)
  (define (rec-aux i)
    (if (> i k)
        0
        (/ (n i) (+ (d i) (rec-aux (+ i 1))))))
  (rec-aux 1))

(define (cont-frac-iter n d k)
  (define (iter-aux i n-d-k)
    (if (< i 1)
        n-d-k
        (iter-aux (- i 1) (/ (n i) (+ (d i) n-d-k)))))
  (iter-aux k 0))


#| (define (count-est-phi-inv procedure)
  (define (approx-phi-inv k)
    (procedure (lambda (i) 1.0)
               (lambda (i) 1.0)
               k))
  (define (find-k k)
    (let ((result (approx-phi-inv k)))
         (if (close result 0.6180 0.0001)
             (begin
               (display "Accurate to 4 decimal places at k = ")
               (display k)
               (newline))
             (find-k (+ k 1)))))
  (find-k 1))

(display "[recursion] ")
(count-est-phi-inv cont-frac-rec)

(display "[iteration] ")
(count-est-phi-inv cont-frac-iter) |#


#| ANSWER

1. Minimum k for 4 Decimal Places:
   To approximate 1/phi (~0.61803398) with an error less than 0.0001, 
   k must be at least 10:

     k = 9  : 34/55  ~ 0.6181818  (error ~ 0.000148, exceeds 0.0001)
     k = 10 : 55/89  ~ 0.6179775  (error ~ 0.000056, strictly < 0.0001)
     k = 11 : 89/144 ~ 0.6180555  (error ~ 0.000021)

2. Process Comparison:
   - Part A (`cont-frac-rec`): Generates a RECURSIVE process.
     It evaluates top-down from i = 1 to k, building up a chain of deferred 
     additions and divisions proportional to k before unwinding.

   - Part B (`cont-frac-iter`): Generates an ITERATIVE process.
     It evaluates bottom-up from i = k down to 1, carrying the running term 
     in an accumulator state parameter (`n-d-k`), executing in O(1) space. |#