#lang sicp

#| Exercise 1.20: The process that a procedure generates is
of course dependent on the rules used by the interpreter.
As an example, consider the iterative gcd procedure given
above. Suppose we were to interpret this procedure using
normal-order evaluation, as discussed in Section 1.1.5. (The
normal-order-evaluation rule for if is described in Exercise
1.5.) Using the substitution method (for normal order), illus-
trate the process generated in evaluating (gcd 206 40) and
indicate the remainder operations that are actually per-
formed. How many remainder operations are actually per-
formed in the normal-order evaluation of (gcd 206 40)?
In the applicative-order evaluation? |#

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

#| ANSWER: |#
(gcd 206 40)

; Step 1
(if (= 40 0) ; Evaluates to false, 0 remainders 
		206 
		(gcd 40 (remainder 206 40)))

; Step 2
(if (= (remainder 206 40) 0) ; False, 1 remainder
		40 
		(gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

; Step 3
(if (= (remainder 40 (remainder 206 40)) 0)
		(remainder 206 40)
		(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))



(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

