---
layout: post
title: Proof Obligation
summary: The only effective way to program is to (1) be mindful of proving software correctness before software construction, and (2) let this mindfulness influence software designs during software construction.
---

[E. W. Dijkstra](http://en.wikipedia.org/wiki/Edsger_W._Dijkstra) spent much of his career researching [formal verification](http://en.wikipedia.org/wiki/Formal_verification), an approach to software verification that is irrelevant to most software teams because it is cost prohibitive. What _is_ relevant to most software teams is the central idea behind Dijkstra's work—the idea of **proof obligation**.

The obligation of programmers to prove the correctness of their program caught Dijkstra's attention as the 1950's, as he recounted in [EWD1308](https://www.cs.utexas.edu/~EWD/transcriptions/EWD13xx/EWD1308.html):

> In 1959, ... I had posed my colleagues at the Mathematical Centre [a] problem. … Solutions came pouring in, but all wrong …
>
> Within a few hours, Th. J. Dekker handed in a true solution with its correctness argument. Dekker had **first analysed the proof obligations, then chosen the shape of an argument that would meet them, and then constructed the program to which this argument was applicable**.

Based on observations like this, Dijkstra concluded in [EWD340](https://www.cs.utexas.edu/~EWD/transcriptions/EWD03xx/EWD340.html) that

> The only effective way to raise the confidence level of a program significantly is to give a convincing proof of its correctness. But one should not first make the program and then prove its correctness, because then the requirement of providing the proof would only increase the poor programmer's burden. On the contrary: **the programmer should let correctness proof and program grow hand in hand**.

In [EWD1305](https://www.cs.utexas.edu/~EWD/transcriptions/EWD13xx/EWD1305.html), Dijkstra implored programmers not to consider software quality assurance as separate from software development, cautioning that [a house divided against itself cannot stand](http://en.wikipedia.org/wiki/Lincoln%27s_House_Divided_Speech):

> A programmer has to be able to demonstrate that his program has the required properties. If this comes as an afterthought, it is all but certain that he won't be able to meet this obligation: only if he allows this obligation to influence his design, there is hope he can meet it. Pure a posteriori verification denies you that whole-some influence and is therefore putting the cart before the horse, but that is exactly what happens in the software houses where 'programming' and 'quality assurance' are done by different groups. [Needless to say, those houses deliver without warranty.]

Successful programmers have always made proof obligation a habit, long before software consultants turned [TDD](http://en.wikipedia.org/wiki/Test-driven_development) into a buzzword. An example is [NASA's Mercury project from the 1960s](http://www.craiglarman.com/wiki/downloads/misc/history-of-iterative-larman-and-basili-ieee-computer.pdf):

> Project Mercury ran with very short (half-day) iterations that were time boxed. The development team conducted a technical review of all changes, and, interestingly, applied the Extreme Programming practice of test-first development, **planning and writing tests before each micro-increment**. They also practiced top-down development with stubs.

When approaching proof obligation, do not let fancy words like dependency inversion, mock objects, or code coverage scare you away. In its essence, proof obligation is just the responsibility to

1. Be mindful of proving correctness before construction, and
2. Let this mindfulness influence designs during construction.

It is better to do it by manual testing or convincing a teammate that your code is correct in a peer review, than to not do it because you haven't had time to refactor untestable code or set up continuous build server with integrated unit test runner.

Embrace proof obligation today, and be on your way to become a master programmer.

![Proof Obligation]({{ site.url }}/assets/proof.jpg)
