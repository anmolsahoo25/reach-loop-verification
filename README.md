# Using loop invariants for verification in Reach

Reach is a domain specific language (DSL) which makes it easy to write smart contracts. One of the most important features of Reach is that Reach programs can be formally verified. This can be used to prove assertions about the program statically and allow us to be confident that a large class of bugs will never manifest in practice.

Even with the ability to automatically verify programs, loops are one of the trickier parts of a program to verify. Verification of loops requires something called a loop invariant, which requires some programmer effort. Thus, in this tutorial we will explore what loop invariants are and how they can be used for verifying loops and we will illustrate these points using Reach programs.

The agenda for this tutorial is as follows -

1. Discuss the difference between testing and verification
2. See what loop invariants are and how they are used to verify loops
3. Write a skeleton program to test our Reach setup
4. Write a simple (incorrect) loop and its invariant and see how it fails verification
5. Correct the previous loop and see the verification succeed
6. See how loop invariants help us prove assertions that hold after the loop completes
7. Discuss how to choose the right loop invariant required for verification
8. Write a nested loop and its invariant
9. Study a (simplified) real-world application of loops and invariants
10. Thanks!
