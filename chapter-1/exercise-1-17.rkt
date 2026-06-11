#lang sicp
; (#%require racket/trace)

#| Exercise 1.17: The exponentiation algorithms in this sec-
tion are based on performing exponentiation by means of
repeated multiplication. In a similar way, one can perform
integer multiplication by means of repeated addition. The
following multiplication procedure (in which it is assumed
that our language can only add, not multiply) is analogous
to the expt procedure:

(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

This algorithm takes a number of steps that is linear in b.
Now suppose we include, together with addition, opera-
tions double, which doubles an integer, and halve, which
divides an (even) integer by 2. Using these, design a mul-
tiplication procedure analogous to fast-expt that uses a
logarithmic number of steps. |#

; ANSWER:
; The functions double and halve are implemented here as
; primitives, just like the exercise requests it.

(define (double x)
  (* 2 x))

(define (halve x)
  (/ x 2))

(define (odd? x)
  (= (remainder x 2) 1))

(define (fast-* a b)
  (cond ((< b 0) (- (fast-* a (- b))))
        ((= b 0) 0)
        ((odd? b) (+ a (fast-* a (- b 1))))
        (else (fast-* (double a) (halve b)))))

; --- TEST CASES ---
; (trace fast-*)
(= (fast-* 5 0) 0)     ; Expected: #t (Multiply by zero)
(= (fast-* 7 1) 7)     ; Expected: #t (Multiply by one)
(= (fast-* 4 6) 24)    ; Expected: #t (Even x Even)
(= (fast-* 3 5) 15)    ; Expected: #t (Odd x Odd)
(= (fast-* 8 3) 24)    ; Expected: #t (Even x Odd)
(= (fast-* 3 8) 24)    ; Expected: #t (Odd x Even)
(= (fast-* 10 20) 200) ; Expected: #t (Larger numbers)
(= (fast-* -5 3) -15)  ; Expected: #t (Negative a, positive odd b)
(= (fast-* -4 6) -24)  ; Expected: #t (Negative a, positive even b)
(= (fast-* 5 -3) -15)  ; Expected: #t (Positive a, negative b)
(= (fast-* -4 -6) 24)  ; Expected: #t (Negative a, negative b)