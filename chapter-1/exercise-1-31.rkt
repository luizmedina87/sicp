#lang sicp


#| Exercise 1.31:

a. The sum procedure is only the simplest of a vast number
   of similar abstractions that can be captured as higher-
   order procedures.¹ Write an analogous procedure called
   product that returns the product of the values of a
   function at points over a given range. Show how to de-
   fine factorial in terms of product. Also use product
   to compute approximations to π using the formula²

        π     2 · 4 · 4 · 6 · 6 · 8 ···
       --- = --------------------------- .
        4     3 · 3 · 5 · 5 · 7 · 7 ···

b. If your product procedure generates a recursive pro-
   cess, write one that generates an iterative process. If
   it generates an iterative process, write one that gen-
   erates a recursive process.

------------------------------------------------------------
¹The intent of Exercise 1.31 through Exercise 1.33 is to 
demonstrate the expressive power that is attained by using 
an appropriate abstraction to consolidate many seemingly 
disparate operations. However, though accumulation and 
filtering are elegant ideas, our hands are somewhat tied 
in using them at this point since we do not yet have data 
structures to provide suitable means of combination for 
these abstractions. We will return to these ideas in 
Section 2.2.3 when we show how to use sequences as 
interfaces for combining filters and accumulators to build 
even more powerful abstractions. We will see there how 
these methods really come into their own as a powerful 
and elegant approach to designing programs.

²This formula was discovered by the seventeenth-century 
English mathematician John Wallis. |#