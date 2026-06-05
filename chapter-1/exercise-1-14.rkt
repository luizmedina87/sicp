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

The recursive algorithm for count-change recursively explores 
trees of possibilities, one containing a denomination of coin, 
and one not containing it. This suggests that at the very least, 
every node has the potential to explore trees of depth n/d_i, 
where d_i is the denomination of coin i. This tree will be 
explored in Theta(n/d_i) steps, which is equal do Theta(n). Since
this will be done for all denominations, we expect the number of 
steps to grow as Theta(n^k), where n is the amount to be analyzed
and k is the number of kinds of coins. We therefore use a proof 
by induction to ascertain if that's the case.

Base:
The base was already soft proven on the preamble. The algorithm 
explores a tree which stops in the following leaves:

T(0,k) = 1 (1 step)
T(<0,k) = 0 (1 step)
T(n,0) = 0 (1 step)

As a base case, we focus on what happens with T(n,1):

T(n, 1) = T(n, 0) + T(n-1, 1)
        = T(n, 0) + T(n-1, 0) + T(n-2, 1)
        ...
        = T(n, 0) + T(n-1, 0) + T(n-2, 0) + ... + T(n-n, 1)

So every node gets unpacked n times until reaching the final 
T(0,k) leave, with n T(n,0) stubs for every unpacking (accounting
for dead ends).

This leads to a total 2n + 1 nodes explored (the +1 accounting 
for the T(n,1) itself), which is Θ(n).

Inductive step on k:

Let's assume by induction hypothesis that T(n, k) = Θ(n^k).

T(n, k+1) = T(n, k) + T(n - d_{k+1}, k+1)
          = T(n, k) + T(n - d_{k+1}, k) + T(n - 2d_{k+1}, k+1)
          = T(n, k) + T(n - d_{k+1}, k) + T(n - 2d_{k+1}, k+1)
          = T(n, k) + T(n - d_{k+1}, k) + T(n - 2d_{k+1}, k) + T(n - 3d_{k+1}, k+1)
          = T(n, k) + T(n - d_{k+1}, k) + T(n - 2d_{k+1}, k) + T(n - 3d_{k+1}, k) + ... + T(n - (n/d_{k+1})d_{k+1}, k+1)
          = T(n, k) + T(n - d_{k+1}, k) + T(n - 2d_{k+1}, k) + T(n - 3d_{k+1}, k) + ... + {1 or 0}

               ⌊n/d_{k+1}⌋
          =        Σ        T(n - i·d_{k+1}, k)
                 i = 0

Since T(n, k) is Θ(n^k) per induction hypothesis, 
T(n - i·d_{k+1}, k) is Θ((n - i·d_{k+1})^k), which is still 
Θ(n^k). Substituting the inductive hypothesis:

               ⌊n/d_{k+1}⌋
          =        Σ        Θ((n - i·d_{k+1})^k)
                 i = 0

To prove the summation is Θ(n^k), we can bound the sum from above
and below using the total number of terms, which is 
⌊n/d_{k+1}⌋ + 1 terms. Since the denomination d_{k+1} is a fixed
constant, the number of terms 
scales linearly as Θ(n).

- Upper Bound (Big O):

For all terms in the summation, i ≥ 0, which implies that the 
largest possible value for any single term occurs at i = 0. 
Therefore:

(n - i·d_{k+1})^k ≤ n^k

Replacing every term in the summation with this maximum value 
yields the upper bound:

             ⌊n/d_{k+1}⌋
T(n, k+1) ≤      Σ       Θ(n^k)
               i = 0
               
          ≤ (⌊n/d_{k+1}⌋ + 1) · Θ(n^k)
          ≤ O(n) · Θ(n^k)
          ≤ O(n^{k+1})

- Lower Bound (Big Ω):

To find a lower bound, we can ignore the smaller second half of 
the summation and sum only over the first half of the terms, 
where i ranges from 0 to ⌊n/(2·d_{k+1})⌋. This half still 
contains roughly n/(2·d_{k+1}) terms, which is Ω(n) terms.

For any term within this first half, the maximum amount 
subtracted from n is n/2, meaning:

(n - i·d_{k+1})^k ≥ (n - n/2)^k = (n/2)^k = (1/2^k)·n^k

Since 1/2^k is a constant factor, each of these terms is Ω(n^k). 
Summing these Ω(n) terms provides a lower bound for the total 
sum:

            ⌊n/(2·d_{k+1})⌋
T(n, k+1) ≥        Σ           Ω(n^k)
                 i = 0

      = (⌊n/(2·d_{k+1})⌋ + 1) · Ω(n^k)
      = Ω(n) · Ω(n^k)
      = Ω(n^{k+1})

- Conclusion (Big Θ):

Since the number of steps T(n, k+1) is simultaneously bounded 
above by O(n^{k+1}) and bounded below by Ω(n^{k+1}), it is 
tightly bounded by Big Theta:

T(n, k+1) = Θ(n^{k+1})

This completes the inductive step. By the principle of 
mathematical induction, the number of steps required to change an
amount n using k kinds of coins is Θ(n^k). For this specific 
exercise, the number of coin types is fixed at 5 (k=5), meaning 
the order of growth for the number of steps is Θ(n^5).
|#