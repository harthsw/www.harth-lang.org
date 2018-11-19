+++
date = "2016-03-15T10:50:43-07:00"
title = "Names and Identities"
keywords = ["harth", "name", "path", "guid", "definition", "reference", "binding", "scope"]
+++

# Introduction

An important aspect of new programming languages and their design is _Naming and Identities_.

Essentially:

* How do we name our new language's definitions (classes, functions, etc).
* How does the language uniquely identify these same things (classes, functions, etc).

# Names

Software Engineers, usually English speaking, typically use easy to
remember and descriptive names for classes, functions and
similar. There is a lot of variance in style and length, so our new
language has to cope with this.

## Name

The [Harth Programming Language] will have a `Name` type to represent
the simplest name. This is typically used to represent local
variables, function parameters. For example the `x` local variable defined below:

```C++
var x : Int = 1
```

The `Name` type therefore:

* Represents a simple UN-scoped named definition (here `x`).
* Is represented by a `String`; the name of the definition (here `"x"`).

```C++
class Name
{
    property Text : String 
}
```

## Path

The `Path` type will represent more complex names. This is typically
used to represent classes, functions and other definitions which have
non-local scope. For example:

```C++
package /MyPackage

class MyType
{
}
```

Here the class `MyType`;

* has a `Path` representing`"/MyPackage/MyType"`,
* which is the fully qualified "path",
* is similar to an absolute UNIX path.

```C++
class Path
{
    property Parent : Path?
    property Name : Name
}
```

The `Path` type:

* Has an optional `Parent` path (in our example `/MyPackage` is the parent path).
* Contains the final `Name` instance; the simple local name.

## URL

We could also derive a `URL` type to represent paths for naming files,
URLs and other similar resources later on.

# Identities

Identities are used more by the language itself to represent:

* The unique identity of something (like a social insurance card or Passport number).
* The immutable identify of something (that is, your name may change,
  but your identity does not).

## Names vs Identities

A `Name` or `Path` is more useful as a label to define or refer to
something using human textual names. Much like our own name, we could
add more (aliases) or change them (deprecate, rename). This is more
useful to the human.

An `Identity` is more useful as a unique identity which is
immutable; whatever that something is always has the same unchanging
identity. This is more useful to the computer.

## Identity

For `Identity` we could use a [GUID] (*G*lobally *U*nique
*ID*entifier) or [UUID] (*U*niversal *U*nique *ID*entifier).

I think initally it would be best that `Identity` composes and hides
this decision as much as possible:

```C++
class Identity
{
    property Value : Int128

    @private
    property ID : GUID
}
```

The `Identity` has a `Value` (initially an 128-bit integer), and
internally we would use a standard [GUID] or [UUID] type.

# Definitions and References

We will also need `Definition` and `Reference` types to represent
definitions and references to class et. al.

## Definition

All definitions such as classes, functions, local variables and
parameters would be sub-types of `Definition`:

```C++
class Definition
{
    property ID : Identity
    property Path : Path 
    property Aliases : Sequence<Path>
    property References : Sequence<Reference>
}
```

A definition would have:

* An `ID`; the unique identity of this definition.
* A `Path`; the current primary path (full name) of this definition.
* Zero or more `Aliases`; any other known (or deprecated) names.
* Zero or more `References`; any known references to this definition.

## Reference

All references to classes, functions, local variables and
parameters would be sub-types of `Reference`:

```C++
class Reference
{
    property Path : Path 
    property Definition : Definition?
}
```

A `Reference` has:

* A `Path`; the current primary path (or name) of this reference.
* An optional `Definition`; the currently "bound" definition with the given `Path`.

# Semantic Analysis Types

During the Semantic Analysis phase of compilation, we will also need
"Binding" and `Scope` processes and types to manage linking
`Definition` and `Reference` instances (class definitions and class
references by name for example).

## Binding

The process of "Binding" is where all `Reference` instances are bound
by name to their respective `Definition`. Typically binding is done
during the Semantic Analysis of the compiler.

## Scope

The `Scope` of a "Binding" would need to be modeled. The semantic
analysis phase would need to build the definition scopes (packages,
classes, functions) during analysis.

```C++
class Scope
{
    property Parent : Scope?
    property Owner : Definition
    property Definitions : Sequence<Definition>
    property References : Sequence<Reference>
}
```

A `Scope` has:

* An optional `Parent`; the parent scope which contains this scope.
* An `Owner`; the owner definition of this scope.
* Zero or more `Definitions`; any known definitions in this scope.
* Zero or more `References`; any known references to this definitions in this scope.

# Conclusion

Not much new here, if you are very familiar with semantic analysis, names and types.

Some differences;

* the language reflection is explicitly modeled by types,
* the definitions have mutable `Path` or `Name` to allow for renaming.
* the definitions are uniquely identified using `Identity` (guids).

Some thoughts:

* Using `Identity` allows for definitions to be stored in databases.
* Harth itself will almost certainly not use SQL or no-SQL directly.
* The most often used refactoring "Rename" should be a little easier to implement;
  * require changing the name/path of all known and bound `Reference` and `Definition` instances,
  * require the binding process to have completed successfully,
  * have the invariant that the bindings remain immutable (the same) once renaming is complete.
  * should therefore be both global and stable.

[Harth Programming Language]: /
[GUID]: https://en.wikipedia.org/wiki/Globally_unique_identifier
[UUID]: https://en.wikipedia.org/wiki/Universally_unique_identifier
