---
layout: post
title: Sublimetext flatpack shortcut
language: es
comments: true
published: true
categories:
  - Technology
tags:
  - Editors
  - Shell
date: 2018-12-12
---

I installed SublimeText using flatpack, but because ST must be invoked through the flatpack executable I cannot make a symlink to the ST executable as I used to. After some experimenting I came up with this small shell script:

```bash
#!/bin/sh

flatpak run com.sublimetext.three/x86_64/stable $@
```

Then I saved the script as: `$HOME/.local/bin/subl`. Works really well.


