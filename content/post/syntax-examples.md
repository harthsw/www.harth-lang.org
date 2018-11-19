+++
date = "2016-03-01T11:57:19-08:00"
title = "Syntax Ideas and Prototype Examples"
keywords = ["harth", "syntax", "example"]
+++

# Familiar Programming Language with Fully Reified, Immutable, and Homoiconic code/data.

## Familiar

The syntax and text of a [Harth] program should be familiar to most programmers.

## Reified

[Reified] means that all levels of the programming language model (text,
  lexical/tokens, AST, Semantic Model, Project, Binaries) are processed and available at run-time
  as ordinary data.

The data where possible immutable (or near enough).

## Immutable

[Immutable] data gives greater flexibility for shared state, caching, checksum, versioning, undo.

## Homoiconic

[Homoiconic] means that the text, lexemes, tokens, AST, Semantic data,
Project and binaries have the same shared written syntax (in human
and/or binary) as any other language data and/or code.

Thus the distinction between code, data, and functionality blurs.

# Text to Semantic Flow

## Input/Output

Text is read from any stream of characters and internally represented
by a `Char*`, an abstract sequence of zero or more Unicode characters.

Note that `Char` and `Sequence<Lexeme>` are immutable data structures.

## Lexical Analysis

```C++
method Lexer/Read(text : Char*) -> Lexeme*
```

Method takes some `text` of type `Char*`; a sequence of Unicode characters of any valid Unicode value.

The method returns `Lexeme*`; that is zero or more `Lexeme` objects.

* Tabs and spaces are usually only significant in determining lexeme boundaries.
* C, C++ and shell script style comments:
  * C means `/* block */` (allows proper nesting)
  * C++ means `// line` (for comment to end of line)
  * Shell script means `#!` is allowed (rest of line is special script comment).
* Lexemes are any valid characters.
  * Escaping and UTF encodings as allowed by C, C++ and other languages:
  * Example `\n` means a literal newline, raw newlines in source are usually not significant.
  * Example `\r` means a literal carriage return, again these are ignored.
  * Internally any `\n` and/or `\r` pair or single character sequence is counted as "end of line".
* Lexemes are split into several categories:
  * `BuiltinToken`: Builtin to the language itself (eg. `if`, `function`, `return`, `+`, `===`).
  * `NameToken`: Any other symbol formed of unrecognized alpha-numeric or symbol characters.
  * `ReaderToken`: A special token reader, (eg. `"text"` is implemented as a special reader function).
  * `CommentTrivia`: A comment span.
  * `WhitespaceTrivia`: Any other whitespace.
  * `ErrorTrivia`: Some synthetic error detected by the lexer (eg. EOF in unterminated string or comment).
* Lexemes have known start, end, and character counts (in terms of Unicode characters).
* These start/end points can be mapped to source code file, line and columns.
* Note that `Lexeme` and `Sequence<Lexeme>` are immutable data structures.

## Lexemes to Parse Tree

The `Lexeme*` is further processed by a recursive descent parser (eventually hand written).

```C++
method Parser/Read(lexemes : Lexeme*) -> NodeTree
```

Method takes some `lexemes` of type `Lexeme*`; a sequence of zero or more `Lexeme`.

The method returns a `NodeTree` which represents any valid or invalid
AST tree of `Node`, essentially a view of the AST tree as a
[Homogeneous AST]. This view and the underlyig data in immutable.

This means the source text, lexeme and AST syntax tree can be easily
versioned, editted, undo using functional style immutable data
structures (which are provided by [Harth] in the standard library).

## Semantic Analysis of Parse Tree

```C++
method Semantic/Analyze(tree : NodeTree) -> SemanticModel
```

The tree input of type `NodeTree` is converted into a static
`SemanticModel` instance; from the outside perspective this is
immutable (it's actually either "frozen" once completed and/or backed
by immutable data such as the `Lexeme*` and `NodeTree` instances).

Semantic Analysis is useful fairly expensive, so caching these results
might be useful both for the user of the library and the provider
(which may share some cached/immutable data as is possible).

Again this state can be serialized and deserialized in human or binary forms.

Externally the `SemanticModel` allows the programmer (and thus all
tools) to ask any semantic, syntactic, lexical, or textual question.

Typically the analysis phase is responsible for:

* Checking the syntax tree is well formed.
* Checking there are no lexical or parsing errors.
* Determining resolution to name bindings from their definition(s) to any reference(s).
* Maintaining identity relationships between components (binaries, libraries).
  * Each component contains fully resolved (to dependent components).
* Maintaining (cached) name binding maps from def-ref lookups.
  * Useful for completion, documentation, searching, index etc.

Caching the `SemanticModel` with the equivalent previous levels allows
for almost instant restarts; the models are all checksummed/hashed for
fast comparison checks. Any tool would start by:

## Startup and Caching Model

* Look at text model (collection of `Char*` stored in files, memory, repositories etc).
* If this matches existing `Lexical` and/or `NodeTree` and/or `SemanticModel` read these,
  ensuring they all match each other exactly.
* If not matching, compute the updated versions and cache to disk as required.

This data is also immutable and can thus be safely shared between
machines, processes, and/or threads over any connection type.

Essentially all tools wherever they are have the best chance of
instantly reading all source code at the highest fidelity - using the least
amount of work (at least this time). That is approaching "Read many, write once" levels.

## Compiler, Script and REPL

The backend of the Compiler essentially looks like:

```C++
method Compiler/Eval(text : Char*) -> Anything

method Compiler/Load(files : Name*) -> SemanticModel

method Compiler/Compile(model : SemanticModel) -> Project
method Compiler/Link(project : Project) -> Executable
method Compiler/Run(exec : Executable) -> Anything
```

A `Project` is the fully reified and homoiconic representation of an
executable program; by default it contains an immutable representation
of all semantic information, code, binaries, libraries, debug
information etc.

The method `Eval` is a short cut for:

* Lexer/Read to Parser/Read to Semantic/Analyze to Compiler/Compile to Compiler/Link to Compiler/Run.
  * That is text arbitary text and try to execute it Just-In-Time (JIT).
  * Suitable for implementing a REPL and/or script.
  * Additional shared state (variables, scope, etc) allowed in an "environment".

The method `Load` allows for a number of files to be loaded into a `SemanticModel`:

```C++
method Compiler/Load(files : Name*)
{
    let files = assume(IO/ReadFiles(args))
    let trees = map(files, _ => Parser/Read(Lexer/Read(_.SourceText)))
    let tree = NodeTree.CreateProjectWith(trees)
    return Semantic/Analyze(tree)
}
```

The methods `Compile`, `Link` and `Run` allow for finer control.

### Compiler

A compiler might look like this:

```C++
function main(args : String*)
{
    let model = Compiler/Load(files)
    let project = Compiler/Compile(model)
    let executable = Compiler/Link(project)
    match (executable)
    {
    case Error: abort(_)
    case Anything: printf("Compilation success\n")
    }
}
```

### Script Interpreter

A script interpreter might look like this:

```C++
function main(args : String*)
{
    let model = Compiler/Load(files)
    let project = Compiler/Compile(model)
    let executable = Compiler/Link(project)
    let result = Compiler/Run(executable)
    match (result)
    {
    case Int: return(_)
    case Error: abort(_)
    case Anything: printf("%O\n", result); exit(0)
    }
}
```

### Script Interpreter

A REPL interpreter might look like this:

```C++
function main(args : String*)
{
    let input = IO/Stdin
    while (!input.EOF)
    {
        let text = input.ReadLine("Harth> ")
        let result = Compiler/Eval(text)
        match (result)
        {
        case Error: _.PrintStackTrace()
        case Anything: printf("%O\n", result); exit(0)
        }
    }
}
```

## Debugging?

The debugger essentially provides a few basic helpers on top of
semantic name and source text resolution:

```C++
method Debugger/Location(functionName : Name) -> Location
method Debugger/Location(fileName : Name, line : Int, column : Int?) -> Location
method Debugger/Break(loc : Location) -> Breakpoint
```

The `Breakpoint` result can be modified for single shot, read/write, conditional etc.

Additionally the JIT and/or compiler can live insert any compiled
expression (actually a parsed `NodeTree`) into code:

```C++
method Debugger/LiveEdit(loc : Location, code : NodeTree)
```

Since all internal data can be converted to human string with
`ToString()` and/or `printf`, a watch point might be implemented by
`LiveEdit` insertion of `printf()` for each variable and/or state.

Breakpoints are trivial therefore; they stop execution of all tasks under the current process except for the `Debugger/Task` instance which continues running under process control so that all other tasks can be monitored.

Implementations of some other fundamental functions such as
`Debugger/Continue()`, `Run()`, `Step()` and `Next()` can be
implemented using semantic information.

## Backend Binary Generator

The backend binary and object generator uses the latest [LLVM] to
convert a `SemanticModel` into an internal set of linkage/executable
`LLVM/Module*`. These are either cached and/or written to disk as
appropriate.

# Programming Language Examples

## Example 1: Hello World

The basic program (executable, script or REPL) is to print "Hello World":

{{< highlight "C++" "linenos=inline,hl_lines=1 3" >}}
function main(_ : String*)
{
    printf("Hello World!\n")
}
{{< /highlight >}}

This code can be made into an executable, shell script or typed interactively at a REPL:

{{< console >}}
bash$ ls -l /usr/local/bin .
-rwxr-xr-x  1 harveyt  staff  1184 Nov 26 11:04 /usr/local/bin/harth
lrwxr-xr-x  1 harveyt  staff  1184 Nov 26 11:04 /usr/local/bin/harth-compiler -> /usr/local/bin/harth
lrwxr-xr-x  1 harveyt  staff  1184 Nov 26 11:04 /usr/local/bin/hc -> /usr/local/bin/harth
-rw-r--r--  1 harveyt  staff  1184 Nov 26 11:04 HelloWorld.ha
bash$ hc HelloWorld
bash$ ls -l .
-rwxr-xr-x  1 harveyt  staff  1184 Nov 26 11:04 HelloWorld
bash$ ./HelloWorld
Hello World!\n
bash$
{{< /console >}}

### Notes for line **1**:

 * `function` denotes that a function name, type and body will appear.
   * There is no container, it's global scope.
   * This is suitable for binary, script and/or REPL.
   * The `package` and `import` are the defaults.
 * `main` takes only one argument, the `String` passed to the executable and/or script.
 * `_` means variable value is unamed and never used. Essentially the arguments are ignored.
 * `String*` means a sequence of zero or more String, it's like a
   bounded array, but has a abstract type of `Sequence<String>`. See [Types].
 * `main` has no return type written, it is intuit from the block return type. See below.
 * `main` must have one of the following types, and must exist and be named at global scope:
   * `(String*) -> Unit` - arguments are passed as required, always exits success (unless `abort()`).
   * `(String*) -> Int` - arguments are passed as required, always exits success (unless `abort()` in whic case exits failure with error message).
   * `() -> Unit` - similar to above.
   * `() -> Int` - similar to above.

### Notes for line **3**:

 * The body is a block (`BlockNode`) which contains `ExpressionNode*` (in this case one expression).
 * Blocks always contain expressions. The type and value of the block is that of whatever is returned.
   * In this case `printf()` always returns the unit/identity/void value (of type `Unit`).
 * Thus the block only does something by side-effect.

## Example 2: Hello World Script

A more correct and portable (to Linux, MacOS, Windows Cygwin) script should be in an executable file of any name.

```C++
#!/usr/bin/env hs
function main(_ : String*)
{
    printf("Hello World!\n")
}
```

The key addition is the POSIX magic `#!/usr/bin/env hs` which runs the
script text through the `hs` (aka. `harth-script`) JIT script compiler
and execution engine found on `$PATH`. The `#!` is always treated as a
comment by [Harth].

{{< console >}}
bash$ ls -l /usr/local/bin $HOME/bin
-rwxr-xr-x  1 harveyt  staff  1184 Nov 26 11:04 /usr/local/bin/harth
lrwxr-xr-x  1 harveyt  staff  1184 Nov 26 11:04 /usr/local/bin/harth-script -> /usr/local/bin/harth
lrwxr-xr-x  1 harveyt  staff  1184 Nov 26 11:04 /usr/local/bin/hs -> /usr/local/bin/harth
-rwxr-xr-x  1 harveyt  staff  1184 Nov 26 11:04 /Users/harveyt/bin/HelloWorld
bash$ HelloWorld
Hello World!
bash$
{{< /console >}}

{{< todo "How to support Windows scripts portably?" >}}

## Example 3: Hello World In REPL

```C++
printf("Hello World!\n")
```

At an interactive [Harth] shell (or REPL), one can simply execute any statement, expression or program. So the above will result in:

{{< console >}}
Harth> printf("Hello World!\n")
Hello World!\n
Harth>
{{< /console >}}

### Example 4: The /Harth/Lang/Collection/Sequence class

```C++
harth 0.1
package /Harth/Lang/Collection
import /Harth/Lang/Core

/**
 * A Sequence is an abstract finite stream of elements which can be counted, accessed by index.
 * 
 * New sequences can be created using Builder, Append(), Prepend() and similar functions.
 * 
 * Operations performance may vary from O(1) to O(n) or more. LinearSequence and IndexedSequence
 * provide tighter bounds on performance order.
 * 
 * Typically most classes should internally use concrete types such as List<T> or Array<T>, but
 * should return or accept Sequence<T> from methods for maximum usefulness.
 */
@const
class Sequence<out T> extends Stream<T>
{
    @abstract
    property ReverseIterator : Iterator<T>

    @abstract
    property Builder : Builder<T>

    @abstract
    property Size : Int32

    @abstract
    method Get(i : Int32) -> T%

    @abstract @covariant
    property First : T%

    @abstract @covariant
    property Rest : Sequence<T>%

    @abstract
    property Last : T%

    @abstract @covariant
    method MakeEmpty() -> Sequence<T>

    @abstract @covariant
    method Append(item : T) -> Sequence<T>

    @abstract @covariant
    method AppendAll(items : Iterable<T>) -> Sequence<T>

    @abstract @covariant
    method Prepend(item : T) -> Sequence<T>

    @abstract @covariant
    method PrependAll(items : Iterable<T>) -> Sequence<T>

    @abstract @covariant
    method Reverse() -> Sequence<T>

    @abstract @covariant
    method Drop(n : Int32) -> Sequence<T>%
}
```

Some things to note:

* Most non-builtin keywords are attributes of the form `@name`.
* A `class` can be generic in any number of types, with covariance and contravariance.
* A `class` can extend any one other `class` (and/or zero or more `types`).
* An `@abstract` attribute means this class only provides an interface (might turn info a type?)
* The `T%` type means essentially "returns either the generic parameter type `T` or an `Error`. 
* Doxygen tags and comments are supported in some form.

Non-obvious:

* Lack of semi-colons.
  * I think Rust or Julia or some other modern language gets this
    pretty close to correct, the semi-colon is essentially only needed
    to seperate expressions in a `{ a; b; }` style block.
  * A newline outside of any expression, but in a block is
    semantically taken to mean virtual "semicolon".
  * Blocks allow leading/trailing/multiple newlines (and thus
    semicolons) inside, they're the equivalent of "an expression that
    doesn't actually exist".
* Hey, where's the body?

### Example 4: The /Harth/Lang/Collection/BaseSequence class

```C++
harth 0.1
package /Harth/Lang/Collection
import /Harth/Lang/Core

/**
 * BaseSequence provides basic implementation of Sequence using some concrete SeqT type.
 * Sub-classes are LinearSequence and IndexedSequence which provide different performance
 * properties for methods; for example Get() and Size() are O(n) and O(1) respectively.
 * 
 * Sub-classes must at minimum must provide:
 * - Iterator or ReverseIterator (the opposite has a default implementation)
 * - Builder
 * 
 * Default implementations are provided for all other operations, though these may have terrible
 * performance up to O(n^2). Sub-classes should really override with better performance
 * implementations were possible.
 */
@const
class BaseSequence<out T, out SeqT> extends Sequence<T>
{
    @override
    property Iterator : Iterator<T>
    {
        get { return Reverse().ReverseIterator;}
    }

    @override
    property ReverseIterator : Iterator<T>
    {
        get { return Reverse().Iterator }
    }

    @override
    property Size : Int32
    {
        get
        {
            var s = 0
            for (_ in self)
                s++
            return s
        }
    }
    /* ... */
}
```

* Note property and method overrides.
* Note crazy generics: means derived classes can control return type.
  * Probably will change as type system improves?
  * Possibly more type inference too?
* Syntax and semantics should always remain:
  * Flexible
  * Concise
  * Unabiguous.
* Fortunately any decent editor running the full lexical to semantic
  analysis would be able to display lexical, semantic feed back, possibly on-the
  fly (highlighting) and provide errors and documentation as required.
  * See [Emacs FlyCheck] for an example of this working in other languages pretty well.
  * Emacs basically requires a very good text to reflection system
    underneath the hood. Languages such as Python and C# tend to
    provide this these days. Therefore [Harth] must and will, builtin, free, easy.

{{< info "The TODO notes and some semi-colons have been removed from the source. Hey it's a prototype. Whatevers." >}}

# Warning

{{< warning "All the syntax and semantics discussed here are simplified, reality is likely to be more complex, different and changing." >}}

[Types]: TODO
[Harth]: http://www.harth-lang.org/
[Homogeneous AST]: https://www.safaribooksonline.com/library/view/language-implementation-patterns/9781680500097/f_0045.html
[LLVM]: http://llvm.org
[Reified]: https://en.wikipedia.org/wiki/Reification_(computer_science)
[Immutable]: https://en.wikipedia.org/wiki/Immutable_object
[Homoiconic]: https://en.wikipedia.org/wiki/Homoiconicity
[Emacs FlyCheck]: http://www.flycheck.org

<!-- Local Variables: -->
<!-- indent-tabs-mode: nil -->
<!-- End: -->
