+++
date = "2016-03-21T08:51:00-07:00"
title = "Types, Traits and Classes"
keywords = ["harth", "type", "trait", "class"]
+++

# Introduction

Programming languages typically categorize data using the concept of
[Type]. Even if a language has dynamic types or even a few simple data
structures.

In this blog we'll look at the probable design of the [Type System] for [Harth]:

* [Type] - which describe the relationships between types (sub-typing)
  and sets of functions that types allow.
* [Trait] - which usually provide function, method and property implementations, but no state.
* [Class] - which typically can generate actual instances, and have state.

# Type Theory

For programming languages, [Type Theory] is the study the rules used
to build a solid and consistent type system. My recommended source,
which probably requires a Master's level or equivalent experience to
read in-depth is:

* Pierce, Benjamin C. (2002). Types and Programming Languages. MIT Press. ISBN [978-0-262-16209-8](https://en.wikipedia.org/wiki/Special:BookSources/978-0-262-16209-8)

See the Wikipedia article [Type System] for more information on the subject.

For the purposes of Harth's type system, we will attempt to follow
the guiding principles from this book as closely as possible. However
much of the complexity should either be familiar or hidden at first
glance.

My _feeling_ is that if you get the Type System right, it's very
orthogonal and helps you express some things in a much more intuitive
manner. We shall see.

# Types, Traits and Classes

## Type

There are many definitions of what [Type] could be, and Wikipedia
tries hard to explain them in various places. In programming
languages, people often confuse
[Class vs. Type](https://en.wikipedia.org/wiki/Class_\(computer_programming\)#Class_vs._type)
for example.

For Harth I'm going with the notion that a Type provides a few major concepts:

* Describes the set of functions, methods and properties that are valid.
* Describes how types relate to each other; sub-typing, equivalence, etc.
* Usually supplies a [Name](/post/names-identities.md), Path and Identity for that type.
* May have zero or more parent super-types; that is Type supports multiple-inheritance.
  * Multiple-inheritance of Type is *not* as dangerous as you might fear.
  * It is very useful when you introduce the Trait concept as shown below.

In Harth note that a Type is *not* the same as a Class; it does
not provide state or a way to generate instances. However, Class
does sub-type Type, but provides state and usually a way to generate
instances.

```C++
var x : Int = 1
```

In the above example `Int` is the name of a Type (actually a Class); the expression says
"variable `x` has type `Int` and is assigned the value 1".

```C++
class Type
{
    property Functions : Sequence<Function>
    property SuperTypes : Sequence<Type>
    property Path : Path?

    method IsSuperType(other : Type) -> Bool
    method IsSubType(other : Type) -> Bool
}
```

There would probably be many other methods and properties on a
Type. For Harth two types are reference equivalent only if they are
the exact same type. Two different types may be structurally
equivalent however.

## Trait

In essence for Harth, a [Trait] is:

* A specialized Type which may provide function, method or property implementations.
* Does not provide state; properties (and their accessor and/or settor methods) are used instead.
* May have zero or more parent traits (multiple inheritance).
* May be composed with other traits via various operations (described below or later).

The key here is that Trait provides composable implementations of
Type interfaces, but without any state. Multiple inheritance of
functionality is easier to implement using virtual functions and
lookup tables; state is very tricky to do well (see C++).

A papers I've read on Traits is:

* [Traits: Composable Units of Behaviour](http://scg.unibe.ch/archive/papers/Scha03aTraits.pdf)

The Wikipedia [Trait] link contains many other references and details.

```C++
class Trait extends Type
{
    property FunctionDefinitions : Sequence<FunctionDefinition>
}
```

## Class

In essence for Harth, a [Class] is:

* A specialized Type which has one super-classes (single inheritance)
* Composed with zero or more Traits (multiple inheritance)
* Typically provides state to back any properties.
* Typically provides constructors to initialize properties and state.
* Typically provides a way to allocate and free instances of the class.

```C++
class Class extends Type
{
    property SuperClass : Class
    property Traits : Sequence<Trait>
    property States : Sequence<State>
    property Constructors : Sequence<ConstructorDefinition>

    method Allocate() -> Object
    method Free(o : Object)
}
```

# Special Types

For the Harth type system, there are a few particularly interesting
Types (or Classes) described below.

## Anything (Top)

Usuaully a well formed Type System will have a
[Top](https://en.wikipedia.org/wiki/Top_type) type which represents
the super-type of all types.

In Harth this is called `Anything` (rather than the less obvious
`Top`, although that may be an alias). All Types are sub-types of
`Anything`.

A few, possibly, non-obvious uses for `Anything` are:

* Every instance is of type `Anything` (since it is a super-type of all types).
* Used as the return type on a function means "this function can return anything".
* The union of `Anything` with any type `T` is simply the type `Anything`.

## Nothing (Bottom)

Similarly a well formed Type System will have a
[Bottom](https://en.wikipedia.org/wiki/Bottom_type) type which represents
the sub-type of all types.

In Harth this is called `Nothing` (rather than the less obvious
`Bottom`, although that may be an alias). All Types are super-types of
`Nothing`.

A few, possibly, non-obvious uses for `Nothing` are:

* There can be no instances of `Nothing` (since it is a sub-type of all types).
* Used as the return type on a function means "this function cannot return".
* The union of `Nothing` with any type `T` is simply the type `T`.

## Null

The `Null` type has only one value `null`, which represents the null
pointer or reference from most languages. This type is further
explained below.

## Unit

The `Unit` type has only one value `unit`, which represents the empty
tuple '()'. This is usually the return value for any method or
function that has no useful result (ie. is a procedure, and/or has
side-effects only).

Many programming languages call this `void`, but it is often
overloaded to mean "does not return". See C and C++.

## Error

The `Error` type is used as the base class of any error condition. In
Harth there will be no exceptions for good reasons (see [Houston We Have An Error](http://www.610yesnolovely.org/blog/2015/02/07/houston-we-have-an-error/) and [Houston We Have An Error Part 2](http://www.610yesnolovely.org/blog/2015/02/16/houston-we-have-an-error-part-2/).

## `S|T` (Union or Or Type Constructor)

The type syntax `S|T` means "the type `S` *or* the type `T`" and is
essentially a type theoretic union of each type. Initially this may
not seem that useful, but it allows us to compose `Null` and `Error`
and other types to express some useful concepts.

## `T?` (Optional)

The short hand `T?` is the equivalent to `T|Null`; that is "the type
`T` *or* `Null`. For example, when used as a method return type it
signifies that the result is optionally of type `T` or `null`, and is
a type-safe way of expressing nullability of values.

Most languages allow the value "null" to be assigned to any type, by
extracting this notion into the type system we can use `T` to mean
"definitely never null", and `T?` to mean "may be null".

## `T%` (Error)

The short hand `T%` is the equivalent to `T|Error`; that is "the type
`T` *or* `Error`. For example, when used as a method return type it
signifies that the result is either type `T` or some `Error`, and is
a type-safe way of expressing functions that may return errors.

Most languages provide "Exceptions" as a way to handle errors, but
this has proven to be somewhat of a disaster. In Harth, errors are handled as follows:

* By returning an optional value: `T?`.
  * Use if not finding the result is typical or correct.
  * The calling function must handle or pass on the null.
* By returning an error value: `T%`.
  * Use if some non-fatal error occurs.
  * The calling function must handle or pass on the error.
* By calling `abort()` to terminate the thread, task, or process.
  * Use as a last resort, when all else fails.

# Conclusion

Again, not much new here, if you are very familiar with type systems and theory.

Some differences:

* The type system is used to represent errors.
* Functional composition and handling of errors as values turns out to
  be very powerful.
* It's also very familiar; just return `null` or the `Error` as required.

Some thoughts:

* There are other type constructors that may be useful
  "under-the-hood" in implementing various features. However I doubt
  people would use these in day-to-day programming in Harth:

  * Intersection `A&B`
  * Difference `A\B`
    * Note that complement `~B` is essentially `Anything\B`.
  * Multiple inheritance isn't all bad.
  * Exceptions are mostly bad.

I'm probably stepping on a few toes, but that's the beauty of
designing your own language. I may change my mind if you can persuade
me with good arguments, theory and practice.

[Harth]: /
[Type]: https://en.wikipedia.org/wiki/Data_type
[Type System]: https://en.wikipedia.org/wiki/Type_system
[Trait]: https://en.wikipedia.org/wiki/Trait_(computer_programming)
[Class]: https://en.wikipedia.org/wiki/Class_(computer_programming)
[Type Theory]: https://en.wikipedia.org/wiki/Type_theory
