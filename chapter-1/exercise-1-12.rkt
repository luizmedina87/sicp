#lang sicp

#| Exercise 1.12: The following pattern of numbers is called
Pascal's triangle.

        1
       1 1
      1 2 1
     1 3 3 1
    1 4 6 4 1
      . . .

The numbers at the edge of the triangle are all 1, and each
number inside the triangle is the sum of the two numbers
above it. Write a procedure that computes elements of
Pascal's triangle by means of a recursive process. |#


; ANSWER:
(define (pascal-triangle row pos)
  (cond ((= row 2) 1)
        ((= pos 1) 1)
        ((= row pos) 1)
        (else (+ (pascal-triangle (- row 1) (- pos 1))
                 (pascal-triangle (- row 1) pos)))))

; TESTS:
(define (run-test row pos expected)
  (let ((result (pascal-triangle row pos)))
    (display "pascal-triangle(row=") (display row)
    (display ", pos=") (display pos) (display ")")
    (display "  expected: ") (display expected)
    (display "  got: ") (display result)
    (display "  → ") (display (if (= result expected) "PASS" "FAIL"))
    (newline)))

(run-test 1 1 1)
(run-test 2 1 1)
(run-test 2 2 1)
(run-test 3 1 1)
(run-test 3 2 2)
(run-test 3 3 1)
(run-test 4 1 1)
(run-test 4 2 3)
(run-test 4 3 3)
(run-test 4 4 1)
(run-test 5 1 1)
(run-test 5 2 4)
(run-test 5 3 6)
(run-test 5 4 4)
(run-test 5 5 1)