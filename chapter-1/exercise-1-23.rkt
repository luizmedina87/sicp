#lang sicp

#| Exercise 1.23: The smallest-divisor procedure shown at
the start of this section does lots of needless testing: After it
checks to see if the number is divisible by 2 there is no point
in checking to see if it is divisible by any larger even num-
bers. This suggests that the values used for test-divisor
should not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, ... 

To implement this change, deﬁne a procedure next that re-
turns 3 if its input is equal to 2 and otherwise returns its in-
put plus 2. Modify the smallest-divisor procedure to use
(next test-divisor) instead of (+ test-divisor 1).
With timed-prime-test incorporating this modiﬁed ver-
sion of smallest-divisor, run the test for each of the 12
primes found in Exercise 1.22. Since this modiﬁcation halves
the number of test steps, you should expect it to run about
twice as fast. Is this expectation conﬁrmed? If not, what is
the observed ratio of the speeds of the two algorithms, and
how do you explain the fact that it is diﬀerent from 2? |#

; NEW PROCEDURE
(define (next test-divisor)
  (if (even? test-divisor)
  (+ 1 test-divisor)
  (+ 2 test-divisor)))

; FROM EXERCISE 1.22
(define (timed-prime-test n)
	(newline)
	(display n)
	(start-prime-test n (runtime)))

(define (start-prime-test n start-time)
	(if (prime? n)
			(report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
	(display " *** ")
	(display elapsed-time))

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor))))) ; Changed

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
	(= n (smallest-divisor n)))

(define (search-for-primes start count) 
	(cond ((= count 0) (newline))
				((even? start) (search-for-primes (+ start 1) count))
				((prime? start)
					(timed-prime-test start)
					(search-for-primes (+ start 2) (- count 1)))
				(else (search-for-primes (+ start 2) count)))
)

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)

#| ANSWER:
As expected, the algorithm ran about twice as fast, especially
for larger inputs. For smaller inputs, the processor is too
powerful to see any real differences, and other processes
running in the background serves as additional noise. 

The output obtained was:
1009 *** 4
1013 *** 2
1019 *** 1

10007 *** 3
10009 *** 3
10037 *** 2

100003 *** 5
100019 *** 5
100043 *** 6

1000003 *** 12
1000033 *** 12
1000037 *** 12 |#
