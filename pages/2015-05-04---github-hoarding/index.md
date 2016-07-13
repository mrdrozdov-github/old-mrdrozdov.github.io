---
title: Github Hoarding
date: '2015-05-04T12:19:58-04:00'
layout: post
---

Over the weekend, I decided to do some spring cleaning for my Github account. I deleted about 40 repos (down to grand total of 12). If you've ever used Github, you've probably dealt with the "Please type in the name of the repository to confirm" safety. It would take ages to do this with the safety in place. Fortunately, Github has a REST API for all sorts of things, and it has the ability to delete repos. I put some instructions in this [gist](https://gist.github.com/mrdrozdov/1d23b1464b525c340278) for how you to can efficiently delete repos.

> Where does the phrase ["to take ages"](http://www.etymonline.com/index.php?term=age) come from? Does it literally mean that you'd have a few birthdays by the time the referred to event was over?

All this cleaning got me curious. Where do I fall in the realm of Github repo hoarders? Using [PyGithub](https://github.com/PyGithub/PyGithub) I collected some data on RCers Github accounts. Turns out I'm just above average.

> One thing to know about the [Github API](https://developer.github.com/v3/repos/) is that unauthenticated requests are rate limited at 60 per hour. Authenticated ones are limited at 5000 per hour.

> To deal with rate limit, I used the Unix `at` command and collected my data on a Digital Ocean instance. An example command that I'd run would be `at now +2 hours` followed by `at> python get-repo-stats.py <starting-point> > results.<starting-point>.out`. I ran my stat collecting script once first to approximate how far it'd get, which allowed me to estimate the intervals between each starting point. This is a bit hacky, but I threw this all together in about a day and a half. I'll know better next time, I promise. ;)

A chart showing users and their total repo counts (usernames removed):

![](http://i.imgur.com/0A4kvOZ.png)

The average amount of repos per user were: 32

The max repos of any user was: 442

The 20 most common languages by repo count were:

![](http://i.imgur.com/dYyqsTQ.png)

The 20 most common languages by bytes count were:

![](http://i.imgur.com/wTbRbpB.png)

The data I used for the language charts is here: [gist](https://gist.github.com/mrdrozdov/c465d7f9b24d5897ea56)

I had a bug in my code where I didn't handle programming languages that had spaces in their name. The ones that gave me trouble were:

- AGS Script
- Common Lisp
- DCPU-16 ASM
- Emacs Lisp
- Game Maker Language
- Gettext Catalog
- Inform 7
- OpenEdge ABL
- Protocol Buffer
- Pure Data
- Ragel in Ruby Host
- Standard ML
- Visual Basic




