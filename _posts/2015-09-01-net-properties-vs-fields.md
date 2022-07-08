---
layout: post
title: ".NET Properties vs Fields"
summary: It is best practice to use .NET properties instead of fields.
---

Previously, we saw [6 cases in which properties should be avoided]({% post_url 2015-07-01-net-properties-vs-methods %}). A natural progression of thought may be:

_Why don't we just always avoid properties?_

To understand this, we must first understand what properties are, and what they are good for.

## What are properties?

Properties are language features found in certain programming languages. For example, C++ and Java do not support properties, while Python and C# do. For C#, [property usage is documented](https://msdn.microsoft.com/en-us/library/w86s7x04.aspx) in detail on MSDN.

Fundamentally, [properties](http://en.wikipedia.org/wiki/Property_%28programming%29) are a special kind of class member, intermediate between member code (methods) and member data (fields). Property reads/writes look syntactically the same as field reads/writes, but property reads/writes are usually translated to accessor method calls. The field-like syntax is more intuitive to program than method calls, yet the interposition of method calls allows for data validation, active updating, read-only "fields", etc.

In other words, properties offer better **usability** than methods, and stronger **encapsulation** than fields.

## When to think twice about using properties?

To avoid unnecessarily complicating the source code, think twice before using properties over fields when properties do not encapsulate anything meaningful.

[There are situations](http://blog.codinghorror.com/properties-vs-public-variables/) in which properties may be preferred even if they do not encapsulate anything meaningful:

- Reflection works differently on variables vs. properties, so if you rely on reflection, it's easier to use all properties.
- You can't databind against a variable.
- Changing a variable to a property is a breaking change.

Possibly in response to community discussions like the one started by Jeff Atwood, Microsoft introduced [auto-implemented properties](https://msdn.microsoft.com/en-us/library/bb384054.aspx) in C# 3.0. Auto-implemented properties are useful and usable, therefore should always be considered when designing new classes.

For more in-depth coverage on this subject, check out Jon Skeet's article on [why properties matter](http://csharpindepth.com/Articles/Chapter8/PropertiesMatter.aspx).
