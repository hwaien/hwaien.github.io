---
layout: post
title: ".NET Properties vs Methods"
summary: Use methods rather than .NET properties in situations of slowness, conversions, differing results, side effects, copies, and arrays.
---

From time to time, I catch something like the following in code reviews:

```csharp
public class Foo
{
  public string Bar
  {
    get
    {
      return System.IO.File.ReadAllText("bar.txt");
    }
  }
}
```

Having file I/O inside a property getter is bad practice, because it violates the [principle of least astonishment](https://en.wikipedia.org/wiki/Principle_of_least_astonishment). It is less astonishing and more intuitive to do file I/O in a method.

What are some other best practices regarding properties vs methods? Straight from the horse's mouth, [here's what Microsoft recommends](https://msdn.microsoft.com/en-us/library/vstudio/ms229054%28v=vs.100%29.aspx):

## 1. Consider using a property if the member represents a logical attribute of the type.

For example, `BorderStyle` is a property because the style of the border is an attribute of a `ListView`.

## 2. Do use a property, rather than a method, if the value of the property is stored in the process memory and the property would just provide access to the value.

In this case, it is more appropriate to use a property rather than a method. But isn't it more appropriate in this case to use a field rather than a property? This is discussed in [a separate article]({% post_url 2015-09-01-net-properties-vs-fields %}).

## 3. Do use a method, rather than a property, in the following situations:

### 3.1. Slowness

Do use a method rather than a property if the operation is orders of magnitude slower than a field set would be.

If you are even considering providing an asynchronous version of an operation to avoid blocking the thread, it is very likely that the operation is too expensive to be a property. In particular, operations that access the network or the file system (other than once for initialization) should most likely be methods, not properties.

### 3.2. Conversions

Do use a method rather than a property if the operation is a conversion, such as the `Object.ToString` method.

### 3.3. Different Results

Do use a method rather than a property if the operation returns a different result each time it is called, even if the parameters do not change. For example, the `NewGuid` method returns a different value each time it is called.

### 3.4. Side Effects

Do use a method rather than a property if the operation has a significant and observable side effect.

Note that populating an internal cache is not generally considered an observable side effect.

### 3.5. Copies

Do use a method rather than a property if the operation returns a copy of an internal state.

This does not include copies of value type objects returned on the stack.

### 3.6. Arrays

Use a method where the operation returns an array because to preserve the internal array, you would have to return a deep copy of the array, not a reference to the array used by the property. This fact, combined with the fact that developers use properties as though they were fields, can lead to very inefficient code.
