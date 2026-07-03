#lang sicp

#| Exercise 1.27: Demonstrate that the Carmichael numbers
listed in Footnote 1.47 really do fool the Fermat test. That is,
write a procedure that takes an integer n and tests whether
an is congruent to a modulo n for every a < n, and try your
procedure on the given Carmichael numbers. |#


;; =============================================================
;; Unit Testing Framework
;; =============================================================


(define (assert-equal? name expected actual)
  (if (eq? expected actual)
      (begin
        (display "[PASS] ")
        (display name)
        (newline)
        #t)
      (begin
        (display "[FAIL] ")
        (display name)
        (display " | Expected: ")
        (display expected)
        (display ", Got: ")
        (display actual)
        (newline)
        #f)))

(define (run-tests)
  (display "Running Exercise 1.27 Test Suite...")
  (newline)
  (display "----------------------------------")
  (newline)
  
  (let ((results
         (list
          ;; 1. Footnote Carmichael Numbers (Must return #t)
          (assert-equal? "Carmichael 561"  #t (carmichael-test 561))
          (assert-equal? "Carmichael 1105" #t (carmichael-test 1105))
          (assert-equal? "Carmichael 1729" #t (carmichael-test 1729))
          (assert-equal? "Carmichael 2465" #t (carmichael-test 2465))
          (assert-equal? "Carmichael 2821" #t (carmichael-test 2821))
          (assert-equal? "Carmichael 6601" #t (carmichael-test 6601))
          
          ;; 2. Standard Primes (Must return #t)
          (assert-equal? "Prime 2"         #t (carmichael-test 2))
          (assert-equal? "Prime 7"         #t (carmichael-test 7))
          (assert-equal? "Prime 13"        #t (carmichael-test 13))
          (assert-equal? "Prime 101"       #t (carmichael-test 101))
          
          ;; 3. Standard Composites (Must return #f)
          (assert-equal? "Composite 4"     #f (carmichael-test 4))
          (assert-equal? "Composite 9"     #f (carmichael-test 9))
          (assert-equal? "Composite 562"   #f (carmichael-test 562))
          (assert-equal? "Composite 1000"  #f (carmichael-test 1000)))))
    
    (newline)
    (display "All tests completed.")
    (newline)))

;; =============================================================
;; ANSWER
;; =============================================================

(define (square x)
  (* x x))

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

(define (fermat-test a n)
  (= (expmod a n n) a))

(define (carmichael-test-iter a n)
  (or (= a n) 
      (and (fermat-test a n) 
           (carmichael-test-iter (+ 1 a) n))))

(define (carmichael-test n)
  (carmichael-test-iter 1 n))


;; Run the test suite
(run-tests)