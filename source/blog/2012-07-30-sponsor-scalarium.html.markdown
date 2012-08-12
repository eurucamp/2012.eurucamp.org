---
title: "Featured Kastanien sponsor: Scalarium"
date: 2012-07-30
tags: sponsors
author: Florian Gilcher
body_class: article
published: true
---

With eurucamp 2012 being just under 3 weeks away, we wanted to start introducing our sponsors.

Already a eurucamp 2011 sponsor, [Scalarium](http://www.scalarium.com) were generous enough to join us once again in 2012, this time as a top-level _Kastanien_ sponsor.

Scalarium has been on the hosting scene for a while now and their Berlin-based team is still growing. They are always on the look out for talented developers – so if you <3 automation and clouds – apply for an open position online or get in contact with the Scalarium team during eurucamp.

READMORE

As for their story? _We'll let them tell explain: –_


![Scalarium](/images/content/sponsors/scalarium.png "Scalarium Logo")

It all started with the guys at [Peritor](http://www.peritor.com/) working hard on consulting
gigs and helping people move their applications to Amazon EC2. Doing
this is complex and involves a lot of repetition. Also Amazon EC2
lacks some fundamental capabilities like automatic replacement of dead
hosts, easy configuration, or application deployment support. So
Scalarium was born in mid 2009 to fill that gap. Scalarium now hosts
some really big and popular sites and games around the globe - we
could drop webscale or big data here – but we don’t ;).

Scalarium is a management layer on top of EC2 that automates the hell
out your machines and gives you:

* Configuration with Chef
* Healing and replacement of failed hosts
* Auto scaling by time of day or load metrics on your machines
* Build-in deployment and logging
* Extensive monitoring and tracking

The most important component of Scalarium is the local agent running
on every machine. It communicates the server state up to Scalarium and
responds to changes by executing Chef runs. Scalarium uses Chef to
form servers into your desired state. What differentiates Scalarium
from a simple Chef server setup is that Scalarium generates life-cycle
events (like setup, deployment or configuration state change) and
pushes them down to all machines rather then relying on Chef server to
pull. By having multiple life-cycle events you can tell Scalarium what
to do when servers come or go or how to respond to a new application
server (e.g. by adding it to the load balancer!).

![Scalarium Overview](/images/content/sponsors/scalarium/scalarium_overview.png "Scalarium Platform Overview")

You model your architecture by using build-in roles (like Rails app
server, MySQL server, load balancer or Node.js app server) or by
creating custom definitions. Thanks to the power of Chef, Scalarium
can automate anything scriptable.

Using the provided auto scaling mechanisms many clients scale down
machines during the night and boot them over the day as needed. This
saves a lot of money as you only pay for what you are actually using.

Our team is based in Berlin and primarily works with Sinatra/Rails for
the API and Frontend, Nanite, RabbitMQ, CouchDB, Redis, Chef, and of
course Ruby for the backend.

Right now we are changing a lot of our own architecture and start to
work with SWF, SQS and DynamoDB. We also will migrate our frontend to
a fancy JavaScript App. So if you are a good Ruby or JavaScript
developer looking for a job creating a big giant robot that maintains
thousands of servers, drop us a line at [jobs@scalarium.com](mailto:jobs@scalarium.com).
