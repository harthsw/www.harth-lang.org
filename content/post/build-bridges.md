---
date: 2016-03-02T12:09:53-08:00
title: Build Bridges, Not Walls
keywords:
  - "harth"
  - "architecture"
  - "bridges"
---

# Architecture

Often in software archictecure you have a few large components that
need to connect. In real-life this might be analagous to two different
cities seperated by a river. Almost certainly we would have already
have built a bridge between them to cross this natural boundary.

Fearful or foolish people might have built walls between them, but we're not foolish.

# Bridges In Real Life

The city of Vancouver in British Columbia (where I live), there's the
[Port Mann Bridge] that connects Vancouver with the city of Surrey to
the south.

Highway 1 connects these two major cities, many people live in Surrey
and work in Vancouver. The [Port Mann Highway 1 Project] aimed to
upgrade the old bridge to increase capacity.

## Port Mann Bridge Before

![before]

Built in 1964, the old 5 lane bridge was often congested at rush hour.

## Port Mann Bridge During Construction

![during]

A [Cool 360 View](http://aerialphotoimage.com/360/Vancouver/PortMannBridgeAerial.html) show construction in progress.

## Port Mann Bridge After

![after]

Opened in 2012, this is a major 10 lane (5 each way) bridge, and
certainly has capacity even at rush hour. It's of course had a few
issues, but has improved the commute:

> _Travel time surveys have confirmed drivers have cut their commutes
> by as much as half, saving some commuters up to an hour a day._
> - [Port Mann Highway 1 Project]

# Bridges in Software Archiecture

Back to software, and often we have two or more components in a
project which have different sources (or locations) and
architecture. One might be your web browser, written in C or C++. The
other a webserver running on a machine in "The Cloud".

* In order for these components to work together in "community", with
  easy traffic (date) flow we should have a good bridge.
* Like in real life, we should _Build Bridges, Not Walls_ to ensure
  disparate architecural components can communicate to build a thriving
  community.
* Careful attention to the architecture of the Bridge itself can really
  help to increase traffic flow, reduce congestion, dramatically reduce the need
  to convert data (take a bus, walk across the bridge, take a taxi).
  * In this case [HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol)
    which is 21 years old,
  * And [TCP/IP](https://en.wikipedia.org/wiki/Internet_protocol_suite) which
    is 42 years old are great examples of a fantastic bridge.
  * Though not without some minor design issues, see Mike Taylor's [The worst decision in the design of the Internet](https://reprog.wordpress.com/2016/02/17/the-worst-decision-in-the-design-of-the-internet/).

If we didn't have the Internet, we'd have essentially a wall, and
there would be no Google, Wikipedia, Facebook or Twitter. You could of
course build a really badly designed bridge, such as
[Avian Carriers - RFC 2549](https://tools.ietf.org/html/rfc2549) to
send messages over low bandwidth, long latency connections? **NO**
That would be _very_ silly (it was indeed an April Fools).


[before]: /img/bridge-before.jpg
[during]: /img/bridge-during.jpg
[after]: /img/bridge-after.jpg
[Port Mann Bridge]: https://en.wikipedia.org/wiki/Port_Mann_Bridge
[Port Mann Highway 1 Project]: http://www.pmh1project.com/Pages/default.aspx

