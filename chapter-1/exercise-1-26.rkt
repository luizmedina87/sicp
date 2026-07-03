#lang sicp

#| Exercise 1.26: Louis Reasoner is having great diﬃculty do-
ing Exercise 1.24. His fast-prime? test seems to run more
slowly than his prime? test. Louis calls his friend Eva Lu
Ator over to help. When they examine Louis’s code, they
ﬁnd that he has rewritten the expmod procedure to use an
explicit multiplication, rather than calling square:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base
                       (expmod base (- exp 1) m))
                    m))))

“I don’t see what diﬀerence that could make,” says Louis.
“I do.” says Eva. “By writing the procedure like that, you
have transformed the Θ(log n) process into a Θ(n) process.”
Explain. |#

#| ANSWER:

The degradation in performance happens because Scheme uses 
applicative-order evaluation and lacks built-in memoization.
When evaluating Louis's rewritten even? branch:

(remainder (* (expmod base (/ exp 2) m)
              (expmod base (/ exp 2) m))
           m)

The interpreter must fully evaluate all arguments to the * 
operator before applying it. Because the code explicitly 
calls expmod twice, the interpreter is forced to compute 
each branch independently from scratch.In contrast, when 
using the abstracted square procedure:

(square (expmod base (/ exp 2) m))

Applicative-order evaluation requires that the single inner 
(expmod ...) sub-expression is evaluated exactly once into 
a primitive number. That single numeric result is then 
passed into the $O(1)$ multiplication inside square.

Mathematical Proof of Complexity:

By calling expmod twice at each step, the process is 
transformed from a linear recursion into a tree recursion.

- Tree Depth: Because the exponent is halved at every step, 
the maximum depth of the recursive tree remains log_2 n.

- Branching Factor: At each level of the tree, the process 
splits into $2$ identical recursive calls.This creates a 
balanced binary tree of depth log_2 n. The total number 
of operations required to evaluate this process is 
proportional to the total number of nodes in the tree, 
which is dominated by its leaves:

2^(log_2(n)) = n

Thus, the explicit duplication of the procedure call 
multiplies the work exponentially relative to the tree 
depth, transforming the highly efficient Theta(log n) 
process into a linear Theta(n) process. |#