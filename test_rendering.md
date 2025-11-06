---
title: Test rendering
subtitle: This is a subtitle
layout: page
hero_height: is-small
hero_darken: true
language: en
mermaid: true
mathjax: true
---

Hello, world!

## Mermaid diagrams

### Flowchart

```mermaid
graph LR
    A[Square Rect] -- Link text --> B((Circle))
    A --> C(Round Rect)
    B --> D{Rhombus}
    C --> D
```

### Commit flow diagram

```mermaid
gitGraph:
    commit "Ashish"
    branch newbranch
    checkout newbranch
    commit id:"1111"
    commit tag:"test"
    checkout main
    commit type: HIGHLIGHT
    commit
    merge newbranch
    commit
    branch b2
    commit
```
