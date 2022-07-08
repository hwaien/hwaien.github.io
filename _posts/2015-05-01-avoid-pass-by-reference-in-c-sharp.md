---
layout: post
title: "Avoid Pass-by-Reference in C#"
---

When designing C# libraries for a general audience, avoid the `out` and `ref` keywords.

## What is pass-by-reference?

In programming, arguments can be passed to functions using 1 of 2 evaluation strategies: (1) by value or (2) by reference.

When arguments are [passed by value](http://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_value), the argument expression is evaluated, and the resulting value is bound to the corresponding variable in the function.

When arguments are [passed by reference](http://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_reference), a function receives an implicit reference to a variable used as argument, rather than a copy of its value.

[Here is an analogy](http://stackoverflow.com/a/430958) to illustrate the difference:

> Say I want to share a web page with you.
>
> If I tell you the URL, I'm passing by reference. You can use that URL to see the same web page I can see. If that page is changed, we both see the changes. If you delete the URL, all you're doing is destroying your reference to that page - you're not deleting the actual page itself.
>
> If I print out the page and give you the printout, I'm passing by value. Your page is a disconnected copy of the original. You won't see any subsequent changes, and any changes that you make (e.g. scribbling on your printout) will not show up on the original page. If you destroy the printout, you have actually destroyed your copy of the object - but the original web page remains intact.

## Does C# pass by value or reference?

If you are looking for a comprehensive explanation, please check out Lee Richardson's article on [parameter passing in C#](http://www.leerichardson.com/2007/01/parameter-passing-in-c.html).

To simplify, C# defaults to the **pass-by-value** evaluation strategy, but offers the `out` and `ref` keywords for programmers to switch to the pass-by-reference evaluation strategy in special cases. These special cases should be avoided.

## Why avoid pass-by-reference in C#?

[As explained by Microsoft](https://msdn.microsoft.com/en-us/library/ms182131.aspx), passing types by reference (using `out` or `ref`) requires experience with pointers, understanding how value types and reference types differ, and handling methods with multiple return values.

Also, the difference between `out` and `ref` parameters is not widely understood. The correct application of `out` and `ref` parameters requires intermediate design and coding skills.

Library architects who design for a general audience should not expect users to master working with `out` or `ref` parameters.

## How to avoid pass-by-reference in C#?

To avoid passing value types by reference, have the method return the object as its return value. If the method must return multiple values, redesign it to return a single instance of an object that holds the values.

To avoid passing reference types by reference, make sure that the desired behavior is to return a new instance of the reference. If it is, the method should use its return value to do this.
