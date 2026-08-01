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


#| ANSWER:

As shown in the steps below, using normal-order evaluation for 
(gcd 206 40) results in 18 total remainder operations. The 
remainder operations that are performed come from two sources: 
the if test conditions that must be evaluated to determine the 
reduction path (since if is a special form), plus the large chain
of deferred remainder operations that accumulate during the 
expansion phase and are finally evaluated at the end of the 
process. In contrast, if the applicative-order evaluation process
the remainder operation is only performed 4 times.


1. NORMAL-ORDER EVALUATION PROCESS:

	; Start
	(gcd 206 40)

	; Step 1
	(if (= 40 0) ; Evaluates to false. Evaluated 0 remainder operations.
			206 
			(gcd 40 (remainder 206 40)))

	; Step 2
	; a: 40
	; b: (remainder 206 40)
	(if (= (remainder 206 40) 0) ; Results in (= 6 0). Evaluates to false. Evaluated 1 remainder operation.
			40
			(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))) ; Expanded.

	; Step 3
	; a: (remainder 206 40)
	; b: (remainder 40 (remainder 206 40))
	(if (= (remainder 40 (remainder 206 40)) 0) ; Results in (= 4 0). Evaluates to false. Performs 2 remainder operations.
			(remainder 206 40)
			(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) ; Expanded.

	; Step 4
	; a: (remainder 40 (remainder 206 40))
	; b: (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
	(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) ; Results in (= 2 0). Evaluates to false. Performs 4 remainder operations.
			(remainder 40 (remainder 206 40))
			(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))) ; Expanded.

	; Step 5
	; a: (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
	; b: (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
	(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0) ; Results in (= 0 0). Evaluates to true. Performs 7 remainder operations. 
			(remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ; Evaluates to 2. Performs 4 remainder operations.
			(gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))


2. APLICATIVE ORDER EVALUTAION

	; Start
	(gcd 206 40)

	; Step 1
	; a: 206
	; b: 40
	(if (= 40 0)
			206
			(gcd 40 6)) ; Evaluates (remainder 206 40)

	; Step 2
	; a: 40
	; b: 6
	(if (= 6 0)
			40
			(gcd 6 4)) ; Evaluates (remainder 40 6)

	; Step 3
	; a: 6
	; b: 4
	(if (= 4 0)
			6
			(gcd 4 2)) ; Evaluates (remainder 6 4)

	; Step 4
	; a: 4
	; b: 2
	(if (= 2 0)
			4
			(gcd 2 0)) ; Evaluates (remainder 4 2)

	; Step 5
	; a: 2
	; b: 0
	(if (= 0 0)
			2 ; Returns 2
			(gcd 0 (remainder 2 0))) ; Doesn't get evaluated |#

(#%provide gcd)