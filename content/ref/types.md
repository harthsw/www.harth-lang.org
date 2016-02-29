---
date: 2016-02-25T18:30:34-08:00
title: Types
---

# Primitive Types

These types are the most primitive data types. They should be familiar to most programmers.

# Bool

The `Bool` type has two values: `true` or `false`.

# Integer Types

Various integer types:

## Int8, Int16, Int32, Int64, Int128

Fixed N-bit signed integers.

## UInt8, UInt16, UInt32, UInt64, UInt128

Fixed N-bit unsigned integers.

## Size

Fixed unsigned integer with the same number of bits as a pointer; used
to represent size of memory (or disk files).

## IntPtr, UIntPtr

Fixed signed and unsigned integers with same number of bits as a
pointer; used to store a pointer value as an integer. Usually only
used when interfacing with other languages.

## Integer

An "infinite" precision signed integer, includes negative infinity, zero and positive infinity.

## UInteger

An "infinite" precision unsigned integer, includes zero and positive infinity.

# Real Number Types

## Float32

A 32-bit signed floating pointer number.

## Float64

A 64-bit signed floating pointer number.

## Number

An "infinite" precision number.

# Char

The `Char` type is similar to a 32-bit unsigned integer, but
represents any [Unicode] character (technically a `code point`).

Notes:

* Source text can be written in any character encoding, but is converted to [Unicode] internally.
* Any newline and/or carriage return line ending is normalized to just `\n`.

Source characters can be written as-is, or in escaped format:

Character   | Meaning
----------- | -------
x			| Literal character "x"
\n			| Standard escaped character (a newline)
\x_NN_		| Escaped Unicode character of value U+00_NN_
\u_NNNN_	| Escaped Unicode character of value U+_NNNN_
\U000_NNNNN_ | Escaped Unicode character of value U+_NNNNN_


# String

`String` is actually a type alias for `Sequence<Char>` (or `Char*`), which essentially means "zero or more characters in a sequence".

```
type String = Char*
let text : String = "Hello world"
```

There are many concrete sub-classes of `String`, these should not typically be used directly, but are usually the actual type of `String` instances:

* StringArray - a fixed contiguous `Array` of `Char`.
* StringConcat - a concatenation of zero or more `String`.
* StringSlice - a slice (or substring) of another `String'.

Note: The type `Sequence<T>` (or `T*`) means a finite sized sequence of zero or more elements of type `T`.

In most languages this is similar to an array, but it is abstract and immutable; the elements cannot be modified and they may or may not be stored internally as a contiguous piece of memory, and has no firm guarantees on operation performance such as element access, sequence size, or iteration.

Types such as `Array`, `List` are subclasses of `Sequence`).

# Anything

The `Anything` type is the "Top" type; all types are a sub-class of
`Anything` (that is if the inheritance tree was drawn wich sub-classes
going down, Anything is at the Top).

Thus a variable of this type can store any reference or value.

# Nothing

The `Nothing` type is the "Bottom" type; all types are a sub-classed by `Nothing` (that is `Nothing` appears at the bottom of the inheritance tree).

`Nothing` has no instances and is used to mean "cannot be
computed".

The typical use for `Nothing` is to represent a function or method
that cannot return; examples are `abort()` (causes program or thread
to crash) and `return()` (which causes the current function to
return).

# Tuple

The `Tuple` type represents a contiguous immutable type with zero or
more elements of different types.

The type is parametric, and can have zero or more type arguments representing the "slots" in the tuple.

Used for function and method argument types (and return types).

```
class Tuple<T...> { }
function PassThrough(i : Int, s : String) -> (Int, String) { return (i, s) }
```

# Unit

The Unit type represents a valid value which has no real use. It has only one instance: `()`.

Typically this is used as the return type for a function or method that returns nothing useful (only has side-effects).

Unit is actual a type alias for the no parameter `Tuple` type:

```
type Unit = Tuple<>
function HelloWorld() -> Unit { printf("Hello world!\n") }
```

# Box

The Box type represents a single value of type `T`. This is useful for boxing value types.

`Box<T>` is actual a type alias for the single parameter `Tuple<T>` type:

```
type Box<T> = Tuple<T>
```

# Pair

The Pair type represents two value of types `S` and `T`. This is useful returning two values from functions.

`Pair<S, T>` is actual a type alias for the two parameter `Tuple<S, T>` type:

```
type Pair<S, T> = Tuple<S, T>
```

# Null

The `Null` type represents a non-existing reference, it only has one value `null`.

Typically it has to be composed with another type using the `?` suffix
(or using the `|` [Type Union] operator).

```
var optStr : String? = null
var str2 : String|Null = optStr
optStr = "Hello"
```

[Unicode]: https://en.wikipedia.org/wiki/Unicode
[Type Union]: TODO

# Error

`Error` represents errors returned from functions. [Harth] does not support "Exceptions".
