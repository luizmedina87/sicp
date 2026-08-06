#lang sicp

(#%require "./lib/math.rkt")
(#%provide (all-defined))

#| Exercise 1.22: Most Lisp implementations include a prim-
itive called runtime that returns an integer that speciﬁes
the amount of time the system has been running (mea-
sured, for example, in microseconds). The following timed-
prime-test procedure, when called with an integer n, prints
n and checks to see if n is prime. If n is prime, the procedure
prints three asterisks followed by the amount of time used
in performing the test.

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

Using this procedure, write a procedure search-for-primes
that checks the primality of consecutive odd integers in a
speciﬁed range. Use your procedure to ﬁnd the three small-
est primes larger than 1000; larger than 10,000; larger than
100,000; larger than 1,000,000. Note the time needed to test
each prime. Since the testing algorithm has order of growth
of Θ(√n), you should expect that testing for primes around
10,000 should take about √10 times as long as testing for
primes around 1000. Do your timing data bear this out?
How well do the data for 100,000 and 1,000,000 support the
Θ(√n) prediction? Is your result compatible with the notion
that programs on your machine run in time proportional to
the number of steps required for the computation? |#

; FROM EXERCISE
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

; FROM BOOK:
(define (smallest-divisor-naive n) (find-divisor-naive n 2))

(define (find-divisor-naive n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor-naive n (+ test-divisor 1)))))

(define (prime? n)
	(= n (smallest-divisor-naive n)))

; ANSWER
(define (search-for-primes start count)
	(cond ((= count 0) (newline))
				((even? start) (search-for-primes (+ start 1) count))
				((prime? start)
					(timed-prime-test start)
					(search-for-primes (+ start 2) (- count 1)))
				(else (search-for-primes (+ start 2) count))))


#| ANSWER:

The exercise yields the following times in my early 2013
Macbook Pro retina 13" 8gb RAM running Linux Ubuntu:

1009 *** 13
1013 *** 1
1019 *** 1

10007 *** 4
10009 *** 3
10037 *** 3

100003 *** 7
100019 *** 6
100043 *** 7

1000003 *** 20
1000033 *** 20
1000037 *** 20

The times roughly increase √10 for each time n increases 
ten-fold. The procedure runtime is probably not as 
precise as an indicator as it was when the book was 
written since processors, memory, concurrent OS process,
and other factors serve as confounding variables.

The result while not perfectly accurate corroborates the
notion that programs on a machine run in time proportional
to the number of steps required for the computation? |#