---
title: "Accessing ext4 volumes on Mac OS X"
date: "2010-11-12"
summary: "How I mounted ext2/ext3/ext4 USB drives on Mac OS X 10.4 with MacFuse and fuse-ext2."
description: "Guía para habilitar soporte de volúmenes ext2/ext3/ext4 en Mac OS X usando MacFuse y fuse-ext2."
categories:
  - "Linux"
tags:
  - macos
  - ext4
  - macfuse
  - filesystems
locale: "en"
keywords: "macos, ext4, macfuse, fuse-ext2, snow leopard"
extra:
  deprecated: true
  deprecated_reason: "MacFuse fue descontinuado en 2009 y Mac OS X 10.4 ya no se mantiene"
---

Due to some hardware issues with my laptop PC, I'm temporarily moving from
Ubuntu to Mac OS X. But first, I need to move all my files to this Mac
machine. For different reasons I don't want USB external drives with NTFS, so
I formatted my external drive as ext4. This is a small HOW-TO for enabling
ext2/ext3/ext4 drives on your Mac.

**Note:** I did this on a G5 with Mac OS X v10.4.11.

### Step 1

Install MacFuse from <http://code.google.com/p/macfuse/>

### Step 2

Install <http://alperakcan.org/?open=projects&project=fuse-ext2>

### Step 3

Enjoy.
