---
layout: post
title: Immutability
summary: Design your types to be as immutable as possible.
---

Today's topic is immutability (not [divine immutability](http://plato.stanford.edu/entries/immutability/), but [immutable objects in computer programming](https://en.wikipedia.org/wiki/Immutable_object)).

## History of Immutability

Immutability is not new idea. For more than half a century, functional programmers have found immutable objects useful in implementing [pure functions](https://en.wikipedia.org/wiki/Functional_programming#Pure_functions). Unfortunately, functional programming never became as popular as [imperative programming](https://en.wikipedia.org/wiki/Imperative_programming). And for as long as C and C++ dominated the computer industry, immutability received little attention in the programming world.

The first mainstream imperative programming language to recognize the [need for immutability](http://www.drdobbs.com/architecture-and-design/the-need-for-immutability/231000092) is Java. It offers immutable classes like [String](http://www3.ntu.edu.sg/home/ehchua/programming/java/j3d_string.html). When Java became popular in the 1990s, more programmers began to understand the benefits of immutability.

Then C# followed suit and took immutability to heart. For example, C# [anonymous types are immutable](http://codebetter.com/patricksmacchia/2008/01/13/immutable-types-understand-them-and-use-them/), and its [auto-implemented property syntax](https://msdn.microsoft.com/en-us/library/bb383979.aspx) allows effortless creation of immutable types. If you want to understand the kinds of immutability in C#, don't miss Eric Lippert's comprehensive [blog post](http://blogs.msdn.com/b/ericlippert/archive/2007/11/13/immutability-in-c-part-one-kinds-of-immutability.aspx).

## Benefits of Immutability

In his influential programming guide _[Effective Java](https://books.google.com/books?id=ka2VUBqHiWkC&pg=PA73)_, Joshua Bloch points out that immutable types are easier to design, implement, and use. They are less prone to error and more secure.

Here are the reasons why:

### Simplicity

Mutable objects can be in arbitrarily many states. To manage such complexity and ensure reliability, mutator methods that alter an object's state must be mindfully designed, meticulously implemented, exhaustively tested, and precisely documented by the author of the class. Then, the users of the type must spend further effort to understand and test their understanding of the type's state transitions, in order to guarantee program correctness.

In contrast, immutable objects can only ever be in one state. There is no room for mistakes related to state transitions. This simplicity makes immutable types straightforward to design, implement, and use.

Also, immutable types [force programmers to factor code into simple functions](http://theerlangelist.blogspot.com/2013/05/working-with-immutable-data.html) with clear inputs and outputs, making software easier to test, and easier to maintain.

### Thread Safety

[Multithreading](https://en.wikipedia.org/wiki/Thread_%28computing%29#Multithreading) is a mainstay of modern computer software: multithreaded applications run faster, appear more responsive, and utilize resources more efficiently.

On the flip side, multithreaded applications are more difficult to design and implement than single-threaded ones. Since threads share the same collection of objects in the process, it is possible for threads to simultaneously perform state transitions on a mutable object, leading to non-intuitive behaviors like [race conditions](https://en.wikipedia.org/wiki/Race_condition) and [deadlocks](https://en.wikipedia.org/wiki/Deadlock). Programmers must predict all possible timings of state transitions, then use a variety of tools (such as [mutexes, semaphores](http://www.barrgroup.com/Embedded-Systems/How-To/RTOS-Mutex-Semaphore), [monitors](https://en.wikipedia.org/wiki/Monitor_%28synchronization%29), [critical sections](https://en.wikipedia.org/wiki/Critical_section), [condition variables](https://computing.llnl.gov/tutorials/pthreads/#ConditionVariables), etc.) to synchronize threads, so that the overall application behaves correctly.

None of this complexity is relevant if objects are immutable. Without state transitions, immutable objects require no synchronization. They can be shared freely and safely among threads.

### Composability

To achieve long-term productivity, stability, and ease of maintenance in software development lifecycles, good programmers commonly follow the best practice of [code reuse](https://en.wikipedia.org/wiki/Code_reuse). Reuse is enabled by creating building block objects that can be used to compose more complex objects.

Mutable objects make poor building blocks due to [temporal coupling](http://www.yegor256.com/2014/06/09/objects-should-be-immutable.html#avoiding-temporal-coupling). To correctly compose more complex objects out of mutable objects, one must thoroughly understand which existing objects already mutate the states of the mutable objects, when the mutations occur, and how they occur. This is often so troublesome to do that programmers make the unfortunate choice to forgo code reuse.

In contrast, immutable objects make great building blocks. For example, composing an object cache is trivial if objects are immutable. Another example is that if objects are immutable, it is possible to compose a map or dictionary [using them as keys](https://www.linkedin.com/pulse/20140528113353-16837833-6-benefits-of-programming-with-immutable-objects-in-java).

### Security

Immutability also improve the security of a software system by removing [TOCTOU](https://en.wikipedia.org/wiki/Time_of_check_to_time_of_use) bugs. For example, consider the following case:

    permissionGranted = checkPermission(filePath);

    if (permissionGranted)
    {
        secret = read(filePath);
    }

If the `filePath` object is mutable, another thread can change it between the `checkPermission` and `read` calls, allowing a file to be read without proper permissions.

This is not a problem if the `filePath` object is immutable.

### Fault Tolerance

When it comes to building high-availability or life-critical systems, [fault tolerance](https://en.wikipedia.org/wiki/Fault_tolerance) is particularly sought-after.

Mutable objects do not have [failure atomicity](http://www.yegor256.com/2014/06/09/objects-should-be-immutable.html#failure-atomicity). If an error occurs in the middle of a mutable object's state transition, the transition will remain incomplete, and the state of the system will become inconsistent, which is difficult to recover from.

If a software system consists of immutable objects, the state of the system is always consistent, because immutable objects are either uncreated, or in an unchanged state. Such [data consistency](http://theerlangelist.blogspot.com/2013/05/working-with-immutable-data.html) makes it much easier to build a fault-tolerant system.

## Implementing Immutability

All of this conceptual knowledge is good. But how do we put concept into practice? Let's learn by example.

### C\#

Following is a mutable C# type. Notice how the multiplication and division operations mutate states.

```csharp
public class Fraction
{
    public int Numerator { get; private set; }
    public int Denominator { get; private set; }
    public Fraction(int numerator, int denominator)
    {
        Numerator = numerator;
        Denominator = denominator;
    }
    public void MultiplyBy(int multiplier)
    {
        Numerator *= multiplier;
    }
    public void DivideBy(int divisor)
    {
        Denominator *= divisor;
    }
}
```

To make this type immutable,

1. Make all its fields read-only, and
2. Make mutator methods return new instances of the type.

```csharp
public class Fraction
{
    public int Numerator { get; }
    public int Denominator { get; }
    public Fraction(int numerator, int denominator)
    {
        Numerator = numerator;
        Denominator = denominator;
    }
    public Fraction MultiplyBy(int multiplier)
    {
        return new Fraction(Numerator * multiplier, Denominator);
    }
    public Fraction DivideBy(int divisor)
    {
        return new Fraction(Numerator, Denominator * divisor);
    }
}
```

And this pattern can be applied in other programming languages as well:

### Java

```java
final public class Fraction {
    final private int numerator;
    final private int denominator;
    public Fraction(int numerator, int denominator) {
        this.numerator = numerator;
        this.denominator = denominator;
    }
    public int getNumerator() {
        return numerator;
    }
    public int getDenominator() {
        return denominator;
    }
    public Fraction MultiplyBy(int multiplier) {
        return new Fraction(numerator * multiplier, denominator);
    }
    public Fraction DivideBy(int divisor) {
        return new Fraction(numerator, denominator * divisor);
    }
}
```

### C++

```c++
class Fraction
{
  private:
    const int numerator;
    const int denominator;
  public:
    Fraction(int numerator, int denominator) :
        numerator(numerator),
        denominator(denominator)
    {
    }
    int Numerator()
    {
        return numerator;
    }
    int Denominator()
    {
        return denominator;
    }
    Fraction MultiplyBy(int multiplier)
    {
        return Fraction(numerator * multiplier, denominator);
    }
    Fraction DivideBy(int divisor)
    {
        return Fraction(numerator, denominator * divisor);
    }
};
```

### JavaScript

```javascript
function Fraction(numerator, denominator) {
  var fraction = {
    getNumerator: function () {
      return numerator;
    },
    getDenominator: function () {
      return denominator;
    },
    multiplyBy: function (multiplier) {
      return Fraction(numerator * multiplier, denominator);
    },
    divideBy: function (divisor) {
      return Fraction(numerator, denominator * divisor);
    },
  };
  Object.freeze(fraction);
  return fraction;
}
```

There you have it. Now you know what immutability is, why it is useful, and how to use it, strive to design your types to be as immutable as possible!
