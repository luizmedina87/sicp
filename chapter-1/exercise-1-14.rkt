#lang sicp

#| Exercise 1.14: Draw the tree illustrating the process gen-
erated by the count-change procedure of Section 1.2.2 in
making change for 11 cents. What are the orders of growth
of the space and number of steps used by this process as
the amount to be changed increases? |#

#| (define (count-change amount) (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                          kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50))) |#

#| ANSWER:


PART 1: DRAW THE TREE

See ./exercise-1-14.html


PART 2: ORDERS OF GROWTH OF SPACE

The algorithm is implemented recursively, traversing the tree in
a depth-first search (DFS) pattern. Even though the total
number of nodes in the execution tree grows exponentially with n,
the process only maintains a single path from the root to a
leaf in memory at any given moment. Because the call stack
operates as a Last-In, First-Out (LIFO) structure, a branch is
immediately freed from memory once its terminal leaves are fully
explored and it backtracks to the next unresolved path.

The maximum depth of the tree occurs along the path that
minimizes the amount n by the smallest possible increments. This
happens when the algorithm first drops through the coin types
down to the 1-cent penny (k=1), and then decreases the amount n
by 1 at each subsequent step until it reaches a terminal leaf.
Therefore, the maximum stack depth D(n,k) for an amount n and k
coin types is bounded by:

D(n,k) = k + n

For the fixed number of coins in this exercise (k=5), the
maximum depth is 5+n. Since the initial overhead of dropping
through the coin types is a constant (5), it is dropped in
asymptotic analysis. Thus, the order of growth of space is
Θ(n), which is linear in the amount.


PART 3: ORDERS OF GROWTH OF NUMBER OF STEPS

The recursive algorithm for count-change recursively explores trees of possibilities, one containing
a denomination of coin, and one not containing it. This suggests that at the very least, every node 
has the potential to explore trees of depth n/d_i, where d_i is the denomination of coin i. This tree 
will be explored in Theta(n/d_i) steps, which is equal do Theta(n). Since this will be done for all
denominations, we expect the number of steps to grow as Theta(n^k), where n is the amount to be 
analyzed and k is the number of kinds of coins. We therefore use a proof by induction to ascertain if
that's the case.

Base:
The base was already soft proven on the preamble. The algorithm explores a tree which stops in the 
following leaves:

T(0,k) = 1 (1 step)
T(n,0) = 0 (1 step)

As a base case, we focus on what happens with T(n,1):

T(n, 1) = T(n, 0) + T(n-1, 1)
        = T(n, 0) + T(n-1, 0) + T(n-2, 1)
        ...
        = T(n, 0) + T(n-1, 0) + T(n-2, 0) + ... + T(n-n, 1)

So every node gets unpacked n times until reaching the final T(0,k) leave, with n T(n,0) stubs for
every unpacking (accounting for dead ends).

This leads to a total 2n + 1 nodes explored (the +1 accounting for the T(n,1) itself), which is Θ(n).

Induction:



          
          
          

|#