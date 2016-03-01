---
type: "index"
title: "Harth Programming Language"
date: "2016-02-29T19:00:00-08:00"
description: "Home page for the Harth Programming Language"
keywords: 
  - "harth"
---

# The Harth Programming Language

{{< publishdate >}}

## Why The Name "Harth"?

Harth is a contraction of **Har**vey **Th**ompson. That way people can
be sure who the original author was.

The name also evokes the idea of a "Hearth", a warm and cosy often
industrial sized fire-place in the home or blacksmith's; here food is
cooked or new tools are forged.

<img src="/img/hearth-blacksmith.jpg" alt="Hearth" style="width: 400px;"/>

## Yet Another Programming Language?

> The nice thing about standards is that there are so many of them to choose from.
>
> *Andrew S. Tanenbaum*

I've used many programming languages in my 30 years of
programming. Each of ttem have some good and not-so good parts. I've
often wondered what would happen if you took all the reasonable bits
of each and made a programming language from that. [Harth] is that
experiment.

Hopefully [Harth] will not turn into a Jack-of-all-Trades (and master
of none), nor a confusing Swiss-Army-Knife programming language (the
sort you use if you can't find your professional toolbox).

## Programming Languages I Borrowed Ideas From

In building [Harth] I'm borrowing some of the "good" ideas from
various existing programming languages. Each of them are well worth
learning and using in their own right. I'm also very aware and am
grateful for the massive amount of work put in by all the clever
people behind each of these programming languages.

Programming languages I've actually used:

* [C]
* [C++]
* [C#]
* [Java]
* [Lisp]
* [Python]

Programming languages I've not really used, but have read about
interesting ideas worth borrowing:

* [Ceylon]
* [Erlang]
* [Julia]
* [Kotlin]
* [Ruby]
* [Rust]
* [Swift]

# Find Out More

* Read the rest of this page.
* Read the [Blog] posts.

{{< todo "Implement these later as auto-builds from markdown docs and Doxygen code from source." >}}

* Read the [Language Reference] - uses Markdown/Hugo.
* Read The [Language API] - uses Doxygen.

# Project Background (September 14 2015)

The high level vision for the project is to:

* Help software engineers make great tools for themselves and other software engineers.

Software Engineers (programmers) use many tools, the most important of
which is essentially a high tech type-writer; the code editor. This is
something like Word (or Notepad), and they write text (code) which is
saved in text files. There are many other tools which provide some
additional functions that help programmers. These features may already
exist in in the code editor, or may find found in a separate tool.

## Other Programmer Tools

Some of the tools or features a programmer needs are;

* Syntax Highlighting - The text is styled and coloured to highlight
  important information: much like headings in documents.
* Find Definition - The programmer can look up definitions of
  particular piece of code, much like a dictionary or thesaurus.
* Find References - The programmer can find all the references to a
  particular piece of code, much like an index or table of contents.
* Search/Replace & Refactoring - The programmer can ask the computer
  to make specific global changes to the code. For example:
  * Changing the name of something everywhere.
  * Moving some code to somewhere else.
* Auto Complete - The programmer can type short cuts and expand them,
  like auto-complete on phones.
* Error Highlighting - The programmer can see errors in their code
  almost immediately, like the red squiggly lines in Word that show
  spelling mistakes.
* Compilation - The programmer can compile the program into code, and
  at this point will be told about more problems in what they have
  written (like a human editor would for a book or news story).
* Debugger - The programmer can run their program step by step and see
  what’s going on (debugging); often this is needed because the
  programmer has made a logical mistake that the computer cannot
  possibly detect.
* Interactive Session - The programmer can type additional pieces of
  code and perhaps modify the code while it’s running, to help correct
  problems (bugs) in their code.
* Unit Tests - The programmer can write extra “test” code that checks
  what they have written; this can be run automatically to catch
  problems which are introduced as they change their program.
* Quality Tests - The programmer can use some automated code to
  evaluate code quality, for example;
  * How much of the code has tests.
  * How much of the code is documented for programmers.
  * How complex the code is.
* Issue Tracking - The programmer can create “To-Do” lists of things
  they need to do later; building software is like growing a city -
  you start with a one house, but very quickly there’s 1001 buildings,
  each with 1001 different problems to solve.
* Change Management - The programmer can save versions of code, both
locally and on the web, and use this this to collaborate with others.

## Woah, Too Much!

There is an almost endless list of tools a programmer might
need. Consider Home Depot and how many hammers, drills, spanners,
screwdrivers, rulers, saws might be needed to build and maintain a
house. Likewise there are 1001 tools a programmer might need to use to
build good software. Not all the tools exist in one place, and not all
the tools are as good as they could be, or easily available, or cheap.

My aim is not to provide all 1001 tools. That task is far too big for
one person to achieve.

But we have to start somewhere.

## Long Term Aims

So a more realistic aim for this project is to:

Provide a great foundation for many programmers to write and share
good tools a little easier, as and when they need them.

Currently there has been an explosion in software developers creating
new programming languages out of the desire to solve the cohesive lack
of good tools. “Yet Another Programming Language” is announced, but
most software developers groan at each solution, but can’t quite
understand why. A few have discovered that we’re often repeating the
same patterns and even mistakes. We have to try to think a little
differently, dig for the hidden gems of ideas that a few smart people
have discovered, some of these could make a big difference.

## Medium Term Aims

So the more focused aim of this project is to:

Try to collect the most modern and alternative ideas in one place, to
try something a little different.

For example:

* What if we didn’t write code as text saved to a text file?
* What if code was stored in a database like system?
* What if code was more like the internet, a data rich, textual,
  graphical mixture?
* What if the programming ecosystem itself fully understood itself?
* This idea has been around since the 1960’s, but most languages only
  go so far; providing access to understanding only the high level
  constructs.
* Provide full 100% understanding of all code as a library (Microsoft
  are doing this with something called Roysln, which is part of their
  next Visual Studio 2015 release).
* Provide full 100% ability to convert text to executable code, and
  debug as a library (Apple use something called LLVM which does this
  at a lower level as part of their XCode development system).
* What if the programming ecosystem ditched manual processes that just
  make the human’s life harder and more miserable?
* What if the programming ecosystem automated more processes so that
  the human can concentrate on the creative side more?
* What if the programming ecosystem helped the human as much as possible to read and write good code in the first place?

Still this is a quite a lot of work, so we need a more realistic shorter term aims for this project.

## Goals For 2015

The goal for the end of year 2015 is to:

Build a new prototype programming environment based on more new and
modern ideas learned from experience and academia.

These include:

* Familiar programming language - a programming language that will be
  fimiliar to most people; built on top of C++, but with ideas taken
  from Java, C#, Swift, Erlang, Scala, Lisp, Smalltalk, ...
* Static type system - the programmer must be clear and explicit about
  what the program is doing.
* Use the static type system to solve more problems:
  * No null pointer exceptions - “The Billion Dollar Mistake” has
    plagued us for too long, and most more modern languages are
    solving this quite neatly.
  * Non-exceptional run-time error handling - the programmer must
    explicitly and consciously handle the problems user’s might face
    as close to the source as possible.
    * Exceptions were initially thought of as a good solution, but have proven to be a “bad” idea, though many people havn’t realized or agree on this yet.
* Garbage collection - the programmer is absolved from worrying about
  memory management, computers are much better at doing this labor
  intensive task without error. This is contentious with some
  programmers; the answer to that is you shouldn’t do this for low
  level programming, but we’re not dealing in this area, so it’s good
  and right to do so.
* Concurrency - modern computers have multiple processors, to use
  these effectively the programmer needs an easy way to use the CPUs
  effectively.
* Use task/actor systems that share only immutable data, no locking
  and no mutation means the programmer can more easily understand how
  to do this well and without bugs.
* Self awareness - The programming language provides a library to
  understand itself fully:
  * Convert text to an in-memory editable data structure.
  * Convert this in-memory structure back to text.
  * Analyze these data structures for full meaning, cross referencing,
    and compile time (programmer) errors.
  * Provide layers on top for editors, scripting, compilation,
    debugging and interactive features that are commonly needed.
* Prototype - showing some of the basic required features listed in
  Background earlier, showing how easy such tools are to build given
  the foundation:
  * Find Definition
  * Find Reference
  * Auto Complete
  * Error Highlighting
* Prototype stretch - show some cool and mandatory but important
  features to prove it really can work:
  * "Google Maps” Code View - this is an “exciter” in that I’ve not
    seen it done in many products, only hinted at in research.
  * Exporter
  * Compilation
  * Interactive Session

# Status

# On September 14, 2015

Rough completion for this years goal (not for a full final
implementation) from the above list:

* Familiar programming language - done
* Static type system - done
* No null pointer exceptions - done
* Non-exception run-time error handling - done
* Garbage collection - 80%
* Concurrency - Deferred; this problem is complex to implement, not
  required to progress, and has already been proven to work very well
  on other projects.
* Self-awareness - 50%
* Prototype - 0%
* Prototype stretch - 0%

Some stats, which if you’re aware of programmer productivity is very
high. However I’ve been careful to work only about 8 hours for 6 days
of the week to avoid burn out.

* Lines of code written to date (from Jan 1st): 145,000
* Average daily line count: 650
* Number of code files: 25300
* Total committed changes: 2670

# On October 27, 2015

I’ve completed the Prototype goals already two months ahead of
schedule! :-D

{{< info "Though not the stretch ones though, they were optional; they’ll eventually get done when it makes sense." >}}

The plan was to finish the prototype in November and December, but
though it’s taken nine months to program the “brains” of the project,
once that was done it took only two weeks to implement the prototype
features as extensions for an existing editor (Emacs).

# On Feb 29, 2016

The [Harth] website goes live.

* Initially just the home page.
  * Static web site built with [Hugo].
  * Uses [Harth-Hugo-Theme], [Bootstrap], [Pygments] and some other CSS/Javascript.
* Eventually will host Harth blog.
  * Organized by date.
* Eventually will host Harth Technical Reference and API documentation.
  * Organized by language and version.
  * Automatically built from Harth code itself.

# Financing and Business Plan

This project is **NOT** a business. Essentially I'm on sabbatical from
work and doing research and development using some savings.

This project is entirely self funded. I'll run out of money sometime in 2016/2017.

I have some ideas on a business plan; for now I only need money to live and eat.

The short term plan:

* Set up a simple business.
* Get some financing probably [Kickstarter] or [Patreon].

The long term plan (subject to changing my mind on a whime) is:

* The product will should hopefully "almost" free, as in peanuts.
  * Probably a yearly subscription.
  * Think [Atlassian Jira] "free" model.
* It will remain under my control (which means you can give me lots of
  cash, I just get to keep 51%).
* I reserve the right to sell it to whoever I like for one
  trillion-billion whatevers. I'm not greedy however and thus:
  * Head towards inverse tithing (I keep 10%, give away 90% to worthy causes/endeavours).
  * I'd probably only buy a reasonable house and car.
  * Do lots of cool things for education, software and charity.
  * I may occasionally splash out on a nice holiday or a first class plane ticket.
* I'm well aware that the likelihood of this leading to success is minimal.
  * Failing this, I'll go get a normal job making software controlled widgets for space drones.

# Source and Binrary Products

Currently the prototype(s) are closed source, the code and built
products are internal prototypes for research and development.

The projection for first usable alpha is roughly somewhere within 2016
to 2017 (plus or minus as many years as required). Translation: I have
no idea really, other than that's a huge undertaking.

Obviously if a few people help out (especially full time), this might
be reduced very slightly.

## What Does The Prototype (V0.2) Demonstrate?

This has essentially demonstrated one of the ideas; by providing the
“brains” as components, programmers can write better tools.

I can demonstrate editing a very simple program with the following
features:

* Syntax error checking as you type;
  * Editor puts red squiggly lines on erroneous text, with explanations of errors on popups.
  * (For prototype only updates on save).
* Find definition;
  * editor jumps to definition of type.
  * (For prototype, works only on types).
* Find references;
  * editor can cycle through all references to type.
  * (For prototype, works only on types).
* Auto-complete names;
  * editor either completes unique name or gives pop-up list of possible completions to select.

Note that the features adapt to changes in the program as you edit
it - the “brains” re-analyses the whole program as it’s been written.

## Technical Details (V0.2)

* Create a standalone “server” process which reads, parses and
  analyses a whole project from disk.
* By connecting over TCP and sending commands, the “server” responds
  to requests for information about the project.
* The “server” can update (reload at the moment, eventually
  incremental updates) the analysis of the whole project files.
* Extended Emacs (a standard well known programmable editor) to talk
  to this server process.
* Extended and adapted existing Emacs packages (flycheck, ggtags,
  company) which provide the front-end/UI/Emacs for virtually “free”.
  (No point reinventing the wheel here).

Not everyone uses Emacs as a program editor, but it would be fairly
easy to write plugins for other editors; most of the work is done in
the server process (for example: you can simply use telnet or netcat
to talk to the server, it’s just a TCP text service like a web
server). The “server” should really also provide information to
format/colour/indent code - and/or possibly provide standard editor
component.

[Harth]: http://www.harth-lang.org/
[blog]: http://www.harth-lang.org/post/
[C]: https://en.wikipedia.org/wiki/C_(programming_language)
[C++]: https://en.wikipedia.org/wiki/The_C%2B%2B_Programming_Language
[C#]: https://en.wikipedia.org/wiki/C_Sharp_(programming_language)
[Java]: https://en.wikipedia.org/wiki/Java_(programming_language)
[Lisp]: https://en.wikipedia.org/wiki/Lisp_(programming_language)
[Python]: http://www.python.org/
[D]: http://www.dlang.org/
[Ruby]: http://www.ruby-lang.org/
[Erlang]: http://www.erlang.org/
[Rust]: http://www.rust-lang.org/
[Ceylon]: http://www.ceylon-lang.org/
[Kotlin]: http://www.kotlinlang.org/
[Julia]: http://www.julialang.org/
[Swift]: https://developer.apple.com/swift/
[Hugo]: http://gohugo.io/
[Harth-Hugo-Theme]: https://github.com/harthsw/harth-hugo-theme
[Bootstrap]: http://getbootstrap.com
[Pygments]: http://pygments.org
[Atlassian Jira]: https://www.atlassian.com/purchase/product/jira-software
[Kickstarter]: https://www.kickstarter.com
[Patreon]: https://www.patreon.com
