---
title: Python Extended Slices
date: '2015-05-05T15:22:48.502Z'
layout: post
---

Last week, I paired with fellow RCer Alex Taipele on a Twitter Bot. It uses the LDA machine learning algorithm trained against a previous set of tweets (processed and tokenized of course) to create a topic (which is represented as an array of strings) that gets fed into the Giphy API. Beautiful, I know. Machine learning and Gifs aside, we wrote our bot in Python and got to use slices.

Slices are awesome. They're way more powerful than substring like methods in other languages, plus they give you a copy of the list rather than a reference (not a deep copy, dictionaries and objects in the list would still be referenced). One of the the great features of slices is the ability to designate a step like so:

```python
#
# Slice syntax follows a_list[start:stop:step],
# with start and stop defaulting to the beginning
# and end of the list, and step defaulting to 1.
#

>>> my_list = ['A', 'B', 'C', 'D', 'E']
>>> my_list[::1]
['A', 'B', 'C', 'D', 'E']
>>> my_list[::2]
['A', 'C', 'E']
>>> my_list[::3]
['A', 'D']
```

> If you're curious, the nature of steps in slices is known as extended slices and they were brought in from conventions seen in NumPy. They are supported by Python version 1.4+. You can read more here: [https://docs.python.org/2.3/whatsnew/section-slices.html](https://docs.python.org/2.3/whatsnew/section-slices.html)

There is a section in our code where we use a negative step.

```
topic_words = np.array(feature_names)[np.argsort(word_dist)][:-n_top_words:-1]
```

Negative steps alone aren't too bad. Look at the following results.

```
>>> my_list[::-1]
['E', 'D', 'C', 'B', 'A']
>>> my_list[::-2]
['E', 'C', 'A']
>>> my_list[::-3]
['E', 'B']
```

It's when we combine negative steps with a negative start or stop that things get confusing.

```
>>> my_list[:-2:-1]
['E']
>>> my_list[-2::-1]
['D', 'C', 'B', 'A']
```

Huh? If we go through the Python source code, we may be able to find some hints. Looking through [PyPy](https://github.com/rfk/pypy) (Python written in Python),there is something called a [SliceObject](https://github.com/rfk/pypy/blob/master/pypy/objspace/std/sliceobject.py), which has the following function.

```
def indices3(w_slice, space, length):
    if space.is_w(w_slice.w_step, space.w_None):
        step = 1
    else:
        step = _eval_slice_index(space, w_slice.w_step)
        if step == 0:
            raise OperationError(space.w_ValueError,
                                 space.wrap("slice step cannot be zero"))
    if space.is_w(w_slice.w_start, space.w_None):
        if step < 0:
            start = length - 1
        else:
            start = 0
    else:
        start = _eval_slice_index(space, w_slice.w_start)
        if start < 0:
            start += length
            if start < 0:
                if step < 0:
                    start = -1
                else:
                    start = 0
        elif start >= length:
            if step < 0:
                start = length - 1
            else:
                start = length
    if space.is_w(w_slice.w_stop, space.w_None):
        if step < 0:
            stop = -1
        else:
            stop = length
    else:
        stop = _eval_slice_index(space, w_slice.w_stop)
        if stop < 0:
            stop += length
            if stop < 0:
                if step < 0:
                    stop = -1
                else:
                    stop = 0
        elif stop >= length:
            if step < 0:
                stop = length - 1
            else:
                stop = length
    return start, stop, step
```

This is actually not too helpful. It sets some defaults and enforces bounds for start and stop. That was a fun excercise anyway, plus I ended up attempting to build PyPy from scratch. After running make, I was eventually treated to this fractal like graphic that I suppose is an Easter Egg in PyPy.

<img src="http://i.imgur.com/2TH9Wyw.png" width="500px" style="margin-left: auto; margin-right: auto;" />

I ended up giving up on building PyPy after scrolling to the top of my log and seeing this message.

<img src="http://i.imgur.com/ym5DkFj.png" width="500px" style="margin-left: auto; margin-right: auto;" />

After some experimentation and intuition, negatives in extended slices turn out to be not so complicated. An easy way I'm using to remember how the negative step works is that you add one to start and stop, swap start and stop, and then calculate the slice using the positively stepped slice.

```
# Example:
#   my_list[-2:0:-1] == ['D', 'C', 'B'] == [x for x in reversed(my_list[1:-1:1])]

# Example function:
#   
def pseudo_and_surely_buggy_extended_slice(my_list, start, stop, step):
  if step < 0:
    return [x for x in reversed(my_list[stop+1:start+1:-step])]
  else:
    return my_list[start:stop:step]
```

> I used a list comprehension becaused `reversed` returns an iterator rather than a proper list.

Now that we understand extended slices, lets take a look at the original code where they were being used.

```
topic_words = np.array(feature_names)[np.argsort(word_dist)][:-n_top_words:-1]
```

The other cool strategy being used here belongs to NumPy arrays (imagine that we imported NumPy as np). NumPy arrays have a  feature that lets you pass an array of indices and return the elements that the indices designate, but in the order that the indices are in.

```
>>> l1 = np.array(['A', 'B', 'C', 'D', 'E'])
>>> l1[5, 4, 3, 2, 1]
['E', 'D', 'C', 'B', 'A']
>>> l1[3, 4, 5, 1, 2]
['C', 'D', 'E', 'A', 'B']
```

NumPy also has a function called argsort that will sort of sort an array. Rather than return a sorted array, argsort returns a new array that at every index contains the index of the element that would be there if the initial array was sorted.

```
>>> l2 = np.array(['D', 'C', 'B', 'E', 'A'])
>>> np.argsort(l2)
[4, 3, 2, 5, 1]
```

Combining argsort with the cool strategy I previously mentioned lets you easily rearrange arrays to your liking, which is exactly what's being done in our Twitter Bot's [code](https://github.com/ataipale/twitter_NLP_gif_bot).
