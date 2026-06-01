#lang sicp

#| Exercise 1.13:

Prove that Fib(n) is the closest integer to φⁿ/√5, where 
φ = (1 + √5)/2.

Hint: Let ψ = (1 − √5)/2. Use induction and the definition
of the Fibonacci numbers (see Section 1.2.2) to prove that
Fib(n) = (φⁿ − ψⁿ)/√5. |#

#| PROOF: Fib(n) is the nearest integer to φⁿ/√5

  Definitions

    Let φ = (1+√5)/2 and ψ = (1−√5)/2. Both satisfy x² = x + 1.

  Part 1: Proof by induction that Fib(n) = (φⁿ − ψⁿ) / √5

    Base cases:

      Fib(0) = (φ⁰ − ψ⁰)/√5 = (1 - 1)/√5 = 0
      Fib(1) = (φ − ψ)/√5 = ((1+√5)/2 − (1−√5)/2)/√5 = 2√5/2√5 = 1

    Inductive step: 

      Assume:
      Fib(k−1) = (φᵏ⁻¹ − ψᵏ⁻¹)/√5, and 
      Fib(k−2) = (φᵏ⁻² − ψᵏ⁻²)/√5
      
      Then:
      Fib(k) = Fib(k−1) + Fib(k−2)
      (φᵏ − ψᵏ) / √5 = (φᵏ⁻¹ + φᵏ⁻² − ψᵏ⁻¹ − ψᵏ⁻²) / √5
      ⟺ φᵏ − ψᵏ = (φᵏ⁻¹ + φᵏ⁻²) − (ψᵏ⁻¹ + ψᵏ⁻²)
      ⟺ φᵏ − (φᵏ⁻¹ + φᵏ⁻²) = ψᵏ − (ψᵏ⁻¹ + ψᵏ⁻²)
        
      Since φ² = φ + 1, multiplying both sides by φᵏ⁻² gives 
      φᵏ = φᵏ⁻¹ + φᵏ⁻². The same holds for ψ. Therefore:
      φᵏ − (φᵏ) = ψᵏ − (ψᵏ) ⟺ 0 = 0, which is true, so
      Fib(n) = (φⁿ − ψⁿ) / √5

  Part 2: Proof that |ψⁿ/√5| < 1/2

    Base case:
    |ψ/√5| < 1/2
    ⟺ |(1−√5)/2)/√5| < 1/2
    ⟺ |(1−√5)/2√5| < 1/2
    ⟺ |(1−√5)/√5| < 1
    ⟺ |1/√5 − √5/√5| < 1
    ⟺ |1/√5 − 1| < 1

    1 < 2√5, which is true. 
    
    Next: 
    |ψ| = (√5−1)/2 < 1, so for all n ≥ 1:
    |ψⁿ/√5| = |ψ|ⁿ⁻¹ · |ψ/√5| < 1 · 1/2 = 1/2.

  Conclusion

    Fib(n) = φⁿ/√5 − ψⁿ/√5, so the distance between Fib(n) and φⁿ/√5 is exactly |ψⁿ/√5| < 1/2. Since Fib(n) is an integer and no other integer is within 1/2 of φⁿ/√5, it follows that Fib(n) is the nearest integer to φⁿ/√5. □ |#