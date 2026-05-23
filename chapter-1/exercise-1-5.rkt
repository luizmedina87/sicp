#lang sicp

#| 
Exercise 1.5: Ben Bitdiddle has invented a test to determine
whether the interpreter he is faced with is using applicative-
order evaluation or normal-order evaluation. He defines the
following two procedures:
|#

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

; Then he evaluates the expression

(test 0 (p))

#| 
What behavior will Ben observe with an interpreter that
uses applicative-order evaluation? What behavior will he
observe with an interpreter that uses normal-order evalu-
ation? Explain your answer. (Assume that the evaluation
rule for the special form if is the same whether the in-
terpreter is using normal or applicative order: the predi-
cate expression is evaluated first, and the result determines
whether to evaluate the consequent or the alternative ex-
pression.)
|#

#|
ANSWER: If the interpreter uses applicative-order evaluation, 
it will try to evaluate all arguments before applying test. 
This means it will attempt to evaluate (p), which calls itself
recursively with no stopping condition, causing an infinite 
loop. The interpreter will hang and never reach the if 
expression.

If the interpreter uses normal-order evaluation, it will 
substitute the unevaluated arguments into the body of test and
only evaluate them when needed. Since (= x 0) evaluates to 
true, the if returns 0 immediately, and (p) is never evaluated 
— avoiding the infinite loop altogether.
|#