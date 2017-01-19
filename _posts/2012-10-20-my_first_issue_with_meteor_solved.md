---
layout: post
title:  "My first issue with meteor solved quickly"
date:   2012-10-20 19:02:10 -0700
categories: English Programming JavaScript
redirect_from: /blog/html/2012/10/20/my_first_issue_with_meteor_solved
---

#My first issue with meteor solved quickly



Today I was hacking on my first app with [Meteor](http://meteor.com/)_ and I
stumbled upon the following issue right after running the application for the
first time:

```js

[tzicatl@hormiga-gris preguntame]$ meteor
[[[[[ ~/Aplicaciones/Codigo/Meteor/preguntame ]]]]]

Running on: http://localhost:3000/

fs.js:837
    throw errnoException(errno, 'watch');
          ^
Error: watch ENOSPC
    at errnoException (fs.js:806:11)
    at FSWatcher.start (fs.js:837:11)
    at Object.fs.watch (fs.js:861:11)
    at _.extend._scan (/usr/lib64/meteor/app/meteor/run.js:355:24)
    at Array.forEach (native)
    at Function._.each._.forEach (/usr/lib64/meteor/app/lib/third/underscore.js:76:11)
    at new DependencyWatcher (/usr/lib64/meteor/app/meteor/run.js:291:5)
    at exports.run.start_watching (/usr/lib64/meteor/app/meteor/run.js:490:17)
    at exports.run.restart_server (/usr/lib64/meteor/app/meteor/run.js:547:5)
    at /usr/lib64/meteor/app/meteor/run.js:607:9
```

I found [this thread](http://stackoverflow.com/questions/10129496/error-
starting-todos-example) on StackOverflow, but that specific workaround
didn't work out well. So the user *Lander* gave me a kind hand and suggested
that I should tweak `fs.inotify.max_user_watches` and set it to `10000`.

So, I combined both solutions (the one from StackOverflow and the other form
Lander) and this fixed the issue:

.. code-block:: javascript

    # echo 10000 > /proc/sys/fs/inotify/max_user_watches
    # echo 10000 > /proc/sys/fs/inotify/max_user_instances

Back to hacking again :)
