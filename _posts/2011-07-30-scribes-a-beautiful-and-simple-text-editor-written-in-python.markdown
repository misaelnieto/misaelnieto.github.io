---
title: Scribes, a beautiful and simple text editor written in Python
layout: post
---

 I love Scribes, a sleek and simple code editor written in Python. This is a review of the things that make me always come back to it.
Scribes, a beautiful and simple text editor written in Python

![Scribes Editor](/media/scribes.png)

[Scribes](http://scribes.sourceforge.net/) describes itself as a Simple, Slim
and Sleek Text Editor for GNOME. And if you love GNOME, You'll love Scribes
too.

The mayor feature of scribes is it's lack of screen real-state clutter. That
means that it does not have a menu-bar and does not organizes open files in
tabs; instead, it relies on the OS's window manager to manage all open windows
as well as a list of all opened windows in a Scribes session.

![Defaul Scribes](/media/scribes_default.png)

As stated above, Scribes does have a menu toolbar, but it does have a button
toolbar and a status bar. But both of them are hidden by default, and when
shown, they will be auto hidden after some seconds. When you need to use the
toolbar, Scribes relies on a hot-corner (or trigger area). Pretty neat!

Toolbars in Scribes appear when you hover the mouse over the Hot corner.

![hot corner](/media/scribes_hot_corner.png)

Besides a few pop-up windows and the two bars, Scribes does not depend on
graphic elements like buttons, sliders, etc. To access to it's full potential
you will be using using keyboard shortcuts. Keyboard junkies will be pleased!

The basic editing keyboard shortcuts are the one's that you probably already
know if you have ever used windows or linux, like `Ctrl`+ `C` and `Ctrl`+ `V` for copying
and pasting text. And to make things easier, Scribes comes with a handy cheat
sheet that pops out when you hit `Ctrl`- `H`.

![A handy cheat sheet for Scribes.](/media/media/scribes_cheat_sheet.png)

Scribes is not awfully configurable (in the sense of vim or emacs). I think
that's OK, because you rarely need to go beyond Scribes' default settings
other than the text Font, Tab width, text wrap and dictionary autocorrect.

If you need different colors, Scribes has Themes.

If you need code snippets an automatic text replacement, it has a small
templating system for code snippets and an Autoreplace editor.

![Advanced configuration](/media/scribes_advanced.png)

Should you need anything else from Scribes, the good news is that it is
extensible. It's written in Python, what would you expect?

Actually, almost every major feature of Scribes like templates, custom syntax
hightlighting colors, bracket completion, theme selector, is written as an
extension.

There are common extensions, which are always available to all kinds of
documents, and language extensions, which are only available when editing
certain type of documents.

For example, for Python, there's a plugin for navigation trough functions and
classes, a plugin for syntax checking (using pylint and pyflakes), and a
plugin for smart indentation.

![Scribes with the python symbol browser.](/media/scribes_functions.png)

For HTML, and XML (including ZPT!), there's
[Sparkup](http://mystilleef.blogspot.com/2010/12/zencoding-and-sparkup-in-scribes.html)
and [ZenCoding](http://mystilleef.blogspot.com/2010/05/zencoding-with-scribes.html).

Recent versions of scribes comes with a side pane (hit `F4`) to navigate files.
This broadens the options available to navigate trough multiple windows:

* Focus Previous Windows (`Ctrl` + `PageUp`)
* Focus Next window (`Ctrl` + `PageDown`)
* Document browser (<`WindowsKey`> (or <`super`>) + `B` or `F9`)

![Document browser and recent files](/media/scribes_utlis.png)

There are a lots of small details (that is, keyboard shortcuts) all over the
app. But It would take me very long to explain every feature, and I will
probably bore you. So just head over the [Scribes' home page](http://scribes.sourceforge.net/download.html),
install it and give it a try.
