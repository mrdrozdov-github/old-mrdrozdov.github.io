---
layout: post
title: "Git Pro Tip: Multiple Accounts"
description: ""
category: protip
tags: [git]
---
{% include JB/setup %}

Most git instructions assume that you'll be using one account, but these instructions won't work nearly as well once you find yourself contributing to open source, your personal account, and more.

# Step 1: Setting up SSH Keys

Regardless of where the repository your contributing to lives, you'll want to use an SSH key to access it.

    $ cd ~/.ssh
    $ ssh-keygen -t rsa -C "youraccount@email.com"
    $ # Enter a Logical Filename like: youraccount_rsa
    $ # Enter a Memorable Password
    $ pbcopy < youraccount_rsa.pub # we'll need this in your clipboard for later

Setup a new SSH key for your account, whether it's github, bitbucket, or something else.

# Step 2: Setup Your SSH Config

While the previous step is super standard, this step is going to make your use of multiple accounts much easier. Let's assume that you've made a user called youruser with a youruser_rsa ssh file and that you're account is with Github. You'll want to modify your SSH config like so:

    $ cd ~/.ssh
    $ vim config

---

    Host github-youruser
    HostName github.com
    User youruser
    IdentityFile ~/.ssh/youruser_rsa

Now imagine we have another account on bitbucket called anotheruser with anotheruser_rsa. We'll want to add some more information to our SSH Config.

    $ cd ~/.ssh
    $ vim config

---

    Host github-youruser
    HostName github.com
    User youruser
    IdentityFile ~/.ssh/youruser_rsa
    
    Host bitbucket-anotheruser
    HostName bitbucket.org
    User anotheruser
    IdentityFile ~/.ssh/anotheruser_rsa

I'll explain what this is for in the next step.

# Step 3: Setting up remote repository origins

Say you've been working on a project locally and you want to push your changes to a remote Github repository. Typically, Github will tell you to do something like this:

    $ cd /path/to/repo
    $ git remote add origin git@github.com:youruser/repo.git
    $ git push -u origin master

We'll want to modify this slightly like so:

    $ cd /path/to/repo
    $ git remote add origin git@github-youruser:youruser/repo.git
    $ git push -u origin master

This adjustment will make it so that whenever you push to this repository, the SSH key that is used will be the one associated with github-youruser in your SSH config file.

## Local Git Author Config

We've enabled locally selected SSH keys with the previous steps, but we haven't talked about the author information that shows up in git commits. Fortunately, this is really easy. Just do something along the following.

    $ cd /path/to/repo
    $ git config --local user.name "Your Name"
    $ git config --local user.email "youraccount@email.com"

# That's All Folks!

![](http://s3.amazonaws.com/rapgenius/thats-all-folks-18569.jpg)