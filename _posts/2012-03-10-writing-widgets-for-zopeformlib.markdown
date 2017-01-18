---
title: Writing widgets for zope.formlib
layout: post
---

**WARNING** This post is incomplete.

I'm doing some interesting things on Grok. Sometimes you need to customize the
default widgets that zope.formlib gives you. So, hopefully, this guide will
summarize it.

## Intro

On this blog post, I'm trying to clarify how does zope.formlib works and how
to make custom widgets for web apps.

My background is Electronics Engineering, and sometimes I have trouble with
some concepts on the Computer Science field. If you find something misleading
or wrong/stupid, I encorage you to drop a comment. I will appreciate it.

Finally, some examples are targeted towards the [Grok](http://grok.zope.org/)
framework. But is very likely that with proper porting, the examples will run
as well on [BlueBream](http://bluebream.zope.org/) or maybe Plone.

## The ZCA and how does stuff is glued together

Where do we start? Let's try [A comprehensive Guide to Zope Component
Architecture](http://www.muthukadan.net/docs/zca.html). This guide shows you
how do the basic building blocks of Zope works.

According to the author, the ZCA is:

    [...] a Python framework for supporting component based design and programming. It is very well suited to developing large Python software systems. The ZCA is not specific to the Zope web application server: it can be used for developing any Python application. Maybe it should be called as Python Component Architecture.

And yes, the ZCA is used in several software projects outside Zope.

One of the most common use cases for the ZCA is doing some kind of
[CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) along
with [ZODB](http://zodb.org/). And the main actor in this user case is the interface
(`zope.interface.Interface`). This is very important. For example, in Grok, you
use an interface for defining attribubtes of persistent objects as well as to
generate Add and Edit forms automagically.

```python
from zope.interface import Interface
from zope import schema

class IFruit(Interface):
    color = schema.Text(title=u'Fruit color')
```

The class IFruit defines an attribute called color. By using the fields defined in the zope.schema package, we get very useful functionality for free, like server-side validation. But, also, we can get automatic form generation.

```python
import grok

class FruitEditForm(grok.EditForm):
    grok.context(IFruit)
    form_fields = grok.AutoFields(IFruit)
```

And, in order to leverage to this functionality, Grok resorts to
grokcore.formlib, which, in turn, uses `zope.formlib` package.

The `grok.EditForm` class is a specialized class which inherits functionality
from grok.View and some bits of `zope.formlib.form.EditForm`.

To save the data, the class grokcore.EditForm defines an action "Apply" (which
will be rendered as an HTML button), and is also a callback function which
will call `grok.EditForm.applyData()` with the parsed and sanitized form data
and ultimately, call `zope.formlib.apply_data_event()` and applies the form
supplied data into the context, which is the Python object that provides the
interface `IFruit`.

And to display the form, the thing goes like this:

* User  request a resource (e.g. `http://site/myfruit/edit`), the resource
gets mapped to the `FruitEditForm`, thanks to acquisition and the rest of the
zope machinery.

* To render the form, the `FruitEditForm` class is instantiated and provided
with context information and the corresponding request variables.

* Then, when the `FruitEditForm` it is called, first it runs the
`self.update_form()` and finally it returns to the http publishing process
whatever `self.render()` returns.

* The s`elf.update_form()` calls the `update()` method in all superclasses. This
is because the forms defined in `zope.formlib` have update and `render()` methods
with different context than what grok provides them.

    + Eventually, python will execute the code in the `update()` method of
      `zope.formlib.form.FormBase`. That method will execute `self.setupWidgets()`
      and manipulate `self.form_reset`, `self.form_result`, `self.errors` and
      `self.status`.

* The `render()` method is implemented by the
`grokcore.formlib.components.GrokForm` class. It renders the form, either by
using a form template, or by whatever action are defined in
`self.form_result`. The `render()` method from `zope.formlib.form.FormBase` is
not executed.

## The `setupWidgets()` method

The `setupWidgets()` method is the one in charge of selecting widgets for each object `self.form_fields`:

    Takes the interface of each object of self.form_fields

Aquí ya me confundí.

 

Cómo se conecta un widget con un field de self.form_fields?