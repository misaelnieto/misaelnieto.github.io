---
title: Scribes, a beautiful and simple text editor
date: 2011-07-30
description: Review of Scribes, a Python-based minimalist code editor for GNOME with a focus on keyboard shortcuts and extensibility.
tags:
- scribes
- text-editor
- gnome
- python
- review
extra:
  deprecated: true
  deprecated_reason: Scribes has been unmaintained since ~2010; sourceforge page is offline
---

I love Scribes, a sleek and simple code editor written in Python. This is a
review of the things that make me always come back to it.

![Scribes editor](/static/images/posts/scribes-a-beautiful-and-simple-text-editor-written-in-python/scribes.png)

[Scribes](http://scribes.sourceforge.net/) describes itself as a simple, slim
and sleek text editor for GNOME. And if you love GNOME, you'll love Scribes
too.

The main feature of Scribes is its lack of screen real-state clutter. That
means that it does not have a menu-bar and does not organize open files in
tabs; instead, it relies on the OS's window manager to manage all open windows
as well as a list of all opened windows in a Scribes session.

![Default Scribes](/static/images/posts/scribes-a-beautiful-and-simple-text-editor-written-in-python/scribes-default.png)

As stated above, Scribes does not have a menu toolbar, but it does have a
button toolbar and a status bar. But both of them are hidden by default, and
when shown, they will be auto-hidden after some seconds. When you need to use
the toolbar, Scribes relies on a hot-corner (or trigger area). Pretty neat!

Toolbars in Scribes appear when you hover the mouse over the hot corner.

![Hot corner](/static/images/posts/scribes-a-beautiful-and-simple-text-editor-written-in-python/scribes-hot-corner.png)

Besides a few pop-up windows and the two bars, Scribes does not depend on
graphic elements like buttons, sliders, etc. To access its full potential you
will be using keyboard shortcuts. Keyboard junkies will be pleased!

The basic editing keyboard shortcuts are the ones that you probably already
know if you have ever used Windows or Linux, like `Ctrl` + `C` and
`Ctrl` + `V` for copying and pasting text. And to make things easier, Scribes
comes with a handy cheat sheet that pops out when you hit `Ctrl` + `H`.

![A handy cheat sheet for Scribes](/static/images/posts/scribes-a-beautiful-and-simple-text-editor-written-in-python/scribes-cheat-sheet.png)

Scribes is not awfully configurable (in the sense of vim or emacs). I think
that's OK, because you rarely need to go beyond Scribes' default settings
other than the text font, tab width, text wrap and dictionary autocorrect.

If you need different colors, Scribes has themes.

If you need code snippets or automatic text replacement, it has a small
templating system for code snippets and an Autoreplace editor.

![Advanced configuration](/static/images/posts/scribes-a-beautiful-and-simple-text-editor-written-in-python/scribes-advanced.png)

Should you need anything else from Scribes, the good news is that it is
extensible. It's written in Python, what would you expect?

Actually, almost every major feature of Scribes — like templates, custom
syntax highlighting colors, bracket completion, theme selector — is written as
an extension.

There are common extensions, which are always available to all kinds of
documents, and language extensions, which are only available when editing
certain type of documents.

For example, for Python, there's a plugin for navigation through functions and
classes, a plugin for syntax checking (using pylint and pyflakes), and a
plugin for smart indentation.

![Scribes with the Python symbol browser](/static/images/posts/scribes-a-beautiful-and-simple-text-editor-written-in-python/scribes-functions.png)

For HTML and XML (including ZPT!), there's
[Sparkup](http://mystilleef.blogspot.com/2010/12/zencoding-and-sparkup-in-scribes.html)
and [ZenCoding](http://mystilleef.blogspot.com/2010/05/zencoding-with-scribes.html).

Recent versions of Scribes come with a side pane (hit `F4`) to navigate files.
This broadens the options available to navigate through multiple windows:

* Focus previous windows (`Ctrl` + `PageUp`)
* Focus next window (`Ctrl` + `PageDown`)
* Document browser (`Super` + `B` or `F9`)

![Document browser and recent files](/static/images/posts/scribes-a-beautiful-and-simple-text-editor-written-in-python/scribes-utils.png)

There are a lot of small details (that is, keyboard shortcuts) all over the
app. But it would take me very long to explain every feature, and I will
probably bore you. So just head over the [Scribes' home page](http://scribes.sourceforge.net/download.html),
install it and give it a try.

**FIN**
