---
layout: post
title: "Make CLIs like a Pro, using NodeJS and NPM"
description: ""
category: protip
tags: [node.js, npm, cli]
---
{% include JB/setup %}

Make your own CLI
=================

We're going to use NodeJS to build our own command line tool at interstellar light speed.

<sup><sub>It helps, but is not ultimately necessary, to have some understanding of node.js for this post.</sub></sup>

# Step 1: Installing Dependencies

Install [NodeJS](http://nodejs.org/download/). That's it.

Well, almost. Let's check that it works. If you type `node --version` in your command line, are you a-okay? Great. Can you run `npm install -g sharknado`? Awesome. Let's move on.

# Step 2: Make your own Sharknado

![](http://i1.kym-cdn.com/photos/images/newsfeed/000/353/279/e31.jpg)

If you've been following instructions, then you've installed Sharknado which is an absurdly simple CLI that I published on NPM. What's really cool is that with some NPM magic, we can now use a new command in our terminal like so: `sharknado` or `sharknado --version`.

<sup><sub>Flying Spaghetti Monster was my second choice, but watching the [Sharknado Trailer](https://www.youtube.com/watch?v=iwsqFR5bh6Q) made my mind up for me. By the way, interested in writing small text in markdown? Check out this [post](http://meta.stackexchange.com/questions/53800/markdown-extension-for-really-small-tiny-text) on Stack Exchange.</sub></sup>

### `sharknado`

Allow me to explain what is going on. When you ran `npm install -g sharknado`, npm installs a new node_module for you in your `/usr/local/lib/node_modules` folder, which is where all your node_modules live. Now, in the package.json of sharknado, I've made a special indication:

	{
	  "name": "sharknado",
	  ...
	  "bin": {
	    "sharknado": "bin/sharknado"
	  },
	  ...
	}

This tells NPM to copy the script from `sharknado/bin/sharknado` to `/usr/local/bin`. This is super convenient, because if you have `/usr/local/bin` in your PATH, then you can run this script anywhere in your terminal by typing `sharknado` just as we've demonstrated. To go into slightly more detail, when you run a command in your terminal, the terminal looks either through your filepath (if you type something like `./install.sh`), or it searches the directories indicated by your PATH variable until a name of a file matches that command.

Let's look at the contents of `sharknado`.

	#!/usr/bin/env node
	require('../index');

The first line (called the [shebang](http://wiki.bash-hackers.org/scripting/basics)) tells the operating system how to execute this file. In this case, we want to use node to execute this file as a script. The second line is node.js code that is basically including the contents of another file, which will ask you a fun trivia question.

### `sharknado --version`

If you type `sharknado --version`, instead of trivia, you'll be displayed the version of the sharknado module. This is because the arguments that we call `sharknado` with are passed into our sharknado file, and are parseable using process.argv. I have some logic that detects either a `-V` or `--version` argument, prints the version, and immediately exits the program.

### Publishing to NPM

If you clone [sharknado](https://github.com/mrdrozdov/sharknado), or create your own alternative, you can run `npm install -g /path/to/sharknadoOrYourProject` to achieve the same effect locally as if you were installing a node_module from the live registry. It's even better to publish your own module so that other people can use it. You can read more about that [here](http://www.mattpalmerlee.com/2013/04/23/create-your-first-node-module-and-publish-it-to-the-npm-registry/).



