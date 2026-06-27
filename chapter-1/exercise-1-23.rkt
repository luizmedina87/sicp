#lang sicp

#| Exercise 1.24: Modify the timed-prime-test procedure of
Exercise 1.22 to use fast-prime? (the Fermat method), and
test each of the 12 primes you found in that exercise. Since
the Fermat test has Θ(log n) growth, how would you expect
the time to test primes near 1,000,000 to compare with the
time needed to test primes near 1000? Do your data bear
this out? Can you explain any discrepancy you ﬁnd? |#

; FROM EXERCISE 1.22

(define (timed-prime-test n times)
	(newline)
	(display n)
	(start-prime-test n (runtime) times)) ; Adapted

(define (start-prime-test n start-time times) ; Adapted
	(if (fast-prime? n times) ; Adapted
			(report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
	(display " *** ")
	(display elapsed-time))

(define (square x)
  (* x x))


; ---- INSERTING FERMAT TEST ----


(define (expmod base exp m)
	(cond ((= exp 0) 1)
				((even? exp)
				 (remainder
				  (square (expmod base (/ exp 2) m))
          m))
				(else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


; ------- END FERMAT TEST -------


(define (search-for-primes start count times) ; Adapted 
	(cond ((= count 0) (newline))
				((even? start) (search-for-primes (+ start 1) count times)) ; Adapted
				((fast-prime? start times) ; Adapted
					(timed-prime-test start times) ; Adapted
					(search-for-primes (+ start 2) (- count 1) times)) ; Adapted
				(else (search-for-primes (+ start 2) count times)))) ; Adapted

(search-for-primes 1000 3 5)
(search-for-primes 10000 3 5)
(search-for-primes 100000 3 5)
(search-for-primes 1000000 3 5)


#| ANSWER:

The runtime for the process run in the same machine as 
exercise 1.22 was:

1009 *** 7
1013 *** 5
1019 *** 7

10007 *** 8
10009 *** 5
10037 *** 5

100003 *** 6
100019 *** 6
100043 *** 6

1000003 *** 7
1000033 *** 6
1000037 *** 10

The tendency was for the process to be apparently Θ(1). While
counterintuitive, computers in 2013 were orders of magnitude
faster than computers in use when the book was published. The
amount of operations required to compute fast-prime? is not
significant for 1000, and grows slowly due to the nature of 
log, which explains the apparent constant runtime. |#