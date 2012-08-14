---
title: Preparing for the Rubinius workshop
date: 2012-08-14 10:00 AM CEST
tags: workshops
author: Dirkjan Bussink
body_class: article website
published: true
---

For the workshop on Rubinius to be a smooth experience, I would like to
request from people to prepare. This preparation shouldn't take too
long, but it would prevent everybody trying to download stuff all at
once and having to wait for compilations at the start of the workshop.

## Toolchain setup

Disable any tool such as rvm, rbenv or whatever you use. I can't stress
this enough to prevent any problems! Use your systems package
manager to make sure you have a Ruby version available. If you're on OS
X, you already have a system Ruby so you're ready to go. If you're on
Linux, just use your package manager to install a Ruby version.

For the people using Windows, sorry, but Rubinius doesn't build on
Windows yet so try to get a vm with Linux setup or get a pairing partner
with Linux or OS X and work with him or her. If you're angry about us
not support Windows yet, please turn all that caremad power into code and
help us get it running on Windows!

Don't try to be smart and think, screw the instructions, I want to do it
my way. I've tried this workshop with some colleagues where some people
didn't follow the exact instructions. They came to regret it because a
lot of steps got much more and they ended up enabling / disabling RVM
all the time which was very annoying. It was holding them up or sometimes
caused some head scratching as to why something didn't work.

I've already optimized the process in a bunch of places for the workflow
described here, so please follow along and don't try to be smart. If you
feel I'm being pedantic here about, please know that I do this it to protect
you as a participant in the workshop. I don't want us to spend a lot of
time on build problems so that we're able to focus on the real content.

For further instructions or required dependencies etc, please take a
look at the [system requirements](http://rubini.us/doc/en/getting-started/requirements/) and please ignore the remark about RVM there. Also make sure you have
libyaml and it's development headers installed (yes we should update the
instructions with that).

## Installation instructions

These are the commands:

<pre>
git clone git://github.com/dbussink/rubinius.git
cd rubinius
./configure
rake
</pre>

Please pay attention that you clone my repository here, not the standard
Rubinius one.

We also clone Veritas, a project written by Dan Kubb that will be part
of DataMapper 2. It will be used because it exposed a bug in the
Rubinius VM that we will be fixing in the second part of the workshop.
It uses Bundler, so let's install it in our Rubinius clone.

<pre>
./bin/rbx -S gem install bundler
</pre>

Clone the Veritas repository. Please note that again I've prepared a
copy with some additional stuff we'll use in my fork of the project.

<pre>
cd ..
git clone git://github.com/dbussink/veritas.git
</pre>

Assuming that you have the rubinius and veritas clone in the same directory,
let's bundle install it.

<pre>
cd veritas
../rubinius/bin/rbx -S bundle install
</pre>

You're now all setup for the workshop. If you have any issues with
getting this stuff up and running, please email me at
[d.bussink@gmail.com](mailto:d.bussink@gmail.com) or grab me at
Eurucamp on Friday morning or during lunch before the workshop starts.

