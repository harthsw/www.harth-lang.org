---
date: "2016-02-24T11:38:50-08:00"
title: "Test Blog Page"
description: "Test Blog Page"
keywords:
  - "harth"
  - "blog"
menu:
  main:
    parent: "mn_blog"
---

# Reason

This blog is a test page. It's meant to test the [Harth-Hugo-Theme].

## Code Shortcode

Example code block:

```cpp
#include <iostream>
#define IABS(x) ((x) < 0 ? -(x) : (x))

int main(int argc, char *argv[]) {

  /* An annoying "Hello World" example */
  for (auto i = 0; i < 0xFFFF; i++)
    cout << "Hello, World!" << endl;

  char c = '\n';
  unordered_map <string, vector<string> > m;
  m["key"] = "\\\\"; // this is an error

  return -2e3 + 12l;
}

class Thing
{
public:
    Thing();
    int CallFunc(int x, int y);
};

try
{
    Thing t;
    int x = t.CallFunc(1, 2);
	if (x < 10)
	    throw new Exception("oops");
}
catch (Exception &e)
{
    printf("Error: %s\n", e.ToString());
}
```

## Code Shortcode 2

```cpp
import thing

class That
{
    function XXX(x : Int) -> Int
    {
        printf("%s\n", x)
    }
}
```

## Inline Code

Calling the function `CallFunc()`.

## Inline Key Press

Press the following keys to quit: {{< key Cmd Q >}}

## Sample Console Output

{{< console >}}
Sample console output
Stuff
********************************************************************************
End
{{< /console >}}

## Various Panels

* Success {{< success title="It worked!" body="Which is nice." >}}
* Info {{< info "Remember to add this." >}}
* Warning {{< warning "Do not do this." >}}
* Error - {{< error "Oh dear" >}}

## TODO

* TODO {{< todo "Remember to add a thing." >}}

## TODO List

{{% todo-list %}}
* Thing
{{% /todo-list %}}

[Harth-Hugo-Theme]: https://github.com/harthsw/harth-hugo-theme
