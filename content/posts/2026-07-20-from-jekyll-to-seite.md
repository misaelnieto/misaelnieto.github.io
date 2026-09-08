---
title: "From Jekyll to Seite: Fourteen Years, Three Static Site Generators"
summary: "In 2012 I migrated from Plone to Jekyll. In 2026 I packed my bags again and moved to Seite, an AI-first static site generator. Here is how I did it."
description: "How I migrated my personal site from Jekyll to Seite, an AI-first SSG. Stack, skills, bugs, workarounds, and why I left BulmaCSS for a hand-rolled atomic design system."
date: "2026-07-20"
categories:
  - "Reflexión"
  - "Web"
tags:
  - seite
  - jekyll
  - ssg
  - tailwindcss
  - opencode
  - atomic-design
  - migration
image: "/static/images/posts/2026-07-20-from-jekyll-to-seite/seite-1.png"
extra:
  hero:
    alt: "A fleet of 19th-century wooden sailing vessels migrating across a churning sea toward a distant lighthouse. Woodcut engraving in the style of Gustave Doré, with hand-tinted rubric vermillion accents on the lead boat's pennant and the lighthouse beam."
    caption: "The 2026 migration: fourteen years, three static site generators."
keywords:
  - "seite, jekyll, ssg, static site generator, migration, tailwindcss, opencode"
---

In June 2012 I [wrote a post](/blog/primer-post-blog-estatico) announcing that I was abandoning [Plone](http://plone.org/) and moving my personal site to Jekyll. Fourteen years later, in June 2026, I packed my bags again: I left Jekyll and moved the whole site to [Seite](https://seite.sh), a static site generator that calls itself *AI-first*.

This post is the story of that migration — the stack, the hacks, the bugs I filed, the parts I'm proud of, and the parts I'm not. If you are thinking about moving an old blog to a modern SSG, or you are just curious about what an "AI-first" static site generator actually means in practice, this is for you.

> **A note on authorship.** Most of the code on this site — the CSS, the Tera templates, the JSON-LD, the regex hacks — was not typed by me. It was written by LLMs. My job was to direct, review, and correct the output until it matched what I had in my head. The design decisions are mine. The bugs are mine too. The 2,300-line `organisms.css` file is something I simply could not have written by hand in any reasonable timeframe. The agents were my typists, my junior developers, my rubber ducks. I was the one pointing them at the right things — and, more often than I'd like to admit, at the wrong things first, then back at the right ones.

## The old site

The previous version of the site was [Jekyll](https://jekyllrb.com/) on top of the [BulmaCSS](https://bulma.io) framework, using a community theme called `bulma-clean-theme`. It worked. It was also, for years, an unfinished project — because **I am not a designer**, and no amount of CSS framework can fix that on its own.

This is what it looked like:

![The old frontpage, with a photo from my wedding day as the hero image.](/static/images/posts/2026-07-20-from-jekyll-to-seite/nnoenieto-jekill-bulma1.png)
*The frontpage. Yes, that is me on my wedding day. Not exactly the professional first impression I was hoping to make.*

![The old résumé page, plain and grey.](/static/images/posts/2026-07-20-from-jekyll-to-seite/nnoenieto-jekill-bulma2.png)
*My résumé. As boring as you remember.*

![The old blog index, colorful but visually noisy.](/static/images/posts/2026-07-20-from-jekyll-to-seite/nnoenieto-jekill-bulma3.png)
*The blog index. Lots of color, no hierarchy, no rhythm.*

![An unfinished 'about my life' section.](/static/images/posts/2026-07-20-from-jekyll-to-seite/nnoenieto-jekill-bulma4.png)
*Where I was going to write about my life. I never finished it.*

The site had a lot of problems, visually speaking. The typography was generic, the layout had no real system behind it, and every page felt like a slightly different accident. After fourteen years of patching, it was time to bite the bullet and rebuild the thing properly.

## Why Seite

I love static site generators. The web started as static files. Then we all migrated to bulky MVC monoliths, which then exploded into a myriad of JavaScript frameworks that required enormous effort to write, maintain, and scale — just to spit out HTML. Then Jekyll came along in 2008 and popularized the idea that maybe, just maybe, we could publish on the web without a database and a runtime.

Since then, every major programming language has shipped its own SSG. Hugo, Eleventy, Astro, Pelican, Zola, Hexo — you can take your pick.

Out of all of them, the one that surprised me was Seite. What caught my eye was a single claim on its homepage: **AI-first**. The idea is that instead of fighting with a web-based admin editor, or hand-crafting every template yourself, you steer an AI agent — Claude, in Seite's intended workflow — to do the heavy lifting. The SSG stops being a tool you operate and starts being a tool you *direct*.

That was interesting to me, because I already live inside [opencode](https://opencode.ai) all day. If Seite was designed to be driven by an agent, I could finally get rid of fiddly frontend editors and just talk to my site in plain English (and Spanish).

There was, of course, a catch. Seite 0.16 is heavily tied to Claude Code, and Claude is expensive — especially when you're using it to write 150 blog posts and 2,000 lines of organism CSS. So before I committed, I had to figure out whether I could drive Seite with the tools I already had.

## Driving Seite without Claude

The first thing I had to solve was: can I run Seite through opencode, with cheaper (or free) LLMs, instead of paying for Claude?

The answer turned out to be yes, but it required some plumbing. Seite 0.16 ships its MCP server and its bundled skills (a logo generator, a landing-page builder, a theme builder) under `.claude/`, because it assumes you're running Claude Code. I copied the same MCP server configuration into my `opencode.json`, pointed it at [Z.ai](https://z.ai) and OpenRouter, and started driving the same seite MCP through opencode instead.

On top of the three seite-bundled skills, I wrote three of my own under `.agents/skills/` (the opencode-native location):

- **`design-system`** — a 133-line design bible I called *"The Intellectual Artifact"*. It codifies the whole visual identity of the site: a 19th-century letterpress / monograph aesthetic, a "No-Container Rule", a heading hierarchy I named the *Scholar's Cadence*, and the absolute law **0px radius everywhere**. Any agent touching CSS has to read this file first.
- **`ilustracion`** — generates English prompts in three modes (lithography, woodcut, hybrid) for AI image generators. Think Doré, Dürer, Haeckel. The prompts feed into Gemini for the actual rendering.
- **`redaccion`** — a writing-coach skill that teaches me the vocabulary of the trade (progressive disclosure, kicker, anaphora, scannability) while it edits my drafts. This very post went through it.

The end result: I am running an "AI-first" SSG that officially targets Claude, on a stack of free LLM tiers, with a creative pipeline of three custom skills. That was the first big win.

## Building it: atomic design + Tailwind v4

Here is where I had to deviate the hardest from what Seite expects out of the box.

Seite's bundled themes ship as a single `base.html` with **all CSS inline in a `<style>` block**. That is a deliberate choice — it makes themes self-contained and portable. The bundled `theme-builder` skill even enforces this as a rule: *"No external stylesheets."*

But I did not want a theme. I wanted a **design system**: layered CSS, tokens, a type scale, reusable components, a single source of truth for colors and spacing. Inline CSS in one template was never going to give me that.

So I bypassed Seite's CSS story entirely and bolted on a parallel [Tailwind CSS](https://tailwindcss.com) v4 build. The pipeline looks like this:

```
static/css/main.css        ← entry point: @import "tailwindcss" + @theme tokens
        │
        ├── atoms.css      (layer atoms)       — resets, base elements
        ├── molecules.css  (layer molecules)   — utilities, buttons, filetes, tags
        └── organisms.css  (layer organisms)   — ~2,300 lines of compositions
                │
                ▼   (bunx tailwindcss CLI, zero-config)
        static/styles.css   ← generated, then fingerprinted by seite
```

The three layers are an [Atomic Design](https://atomicdesign.bradfrost.com/) split, the methodology by Brad Frost where you compose interfaces from atoms → molecules → organisms. The entry point (`main.css`) is where I define all the design tokens via Tailwind v4's `@theme` block — `--color-paper: #FDFCF0`, `--color-ink: #1C1C19`, `--color-rubric: #E65100`, the body font `Newsreader`, a small monograph-appropriate type scale, and the 2-pixel radii that enforce the letterpress feel.

The orchestration lives in a 17-line `justfile` driven by [just](https://just.systems/):

```makefile
seite_watch:    seite serve --port 4000
tailwind_watch: bunx tailwindcss -i static/css/main.css -o static/styles.css --watch --minify

[parallel]
watch: seite_watch tailwind_watch

build:
    bunx tailwindcss -i static/css/main.css -o static/styles.css --minify --minify
    seite build
```

A few things worth pointing out about this setup:

1. **Seite's dev server does not recompile CSS.** That is not a bug, it is just not its job. To develop locally I have to run `just watch`, which spins up `seite serve` and `tailwindcss --watch` in parallel. (My `AGENTS.md` actually codifies this as a rule for any AI agent that touches the project, because it is very easy to forget.)
2. **Build order matters.** `just build` runs Tailwind first, then seite, because seite fingerprints whatever `styles.css` Tailwind just produced.
3. **Zero JavaScript dependencies.** There is no `package.json`, no `tailwind.config.js`, no committed `node_modules/`. Tailwind v4 is configured entirely via the `@theme` block in CSS, and invoked on demand via `bunx` (Bun's `npx`). The only runtime dependencies are the seite Rust binary and Bun.
4. **Yes, there is a typo in the production build recipe.** I pass `--minify` twice. It is harmless — idempotent flag — but I keep leaving it there because at this point it is part of the folklore of the project.

The end result is that Seite treats my entire design system as a plain static asset. It does not know about Tailwind, it does not know about atomic layers, it does not know about my tokens. It just sees a `styles.css` file, fingerprints it, and ships it.

## The bruises

Every migration has bruises. Here are mine.

### Issue #86: a real bug, fixed fast

While wiring up the build I tripped over a genuine bug in Seite and filed [issue #86](https://github.com/seite-sh/seite/issues/86). The maintainers fixed it quickly. That is the whole story — sometimes software just works the way you hope it will.

### Issue #87: Mermaid is not built in

Seite does not integrate [Mermaid.js](https://mermaid.js.org/) by default. I have a couple of old posts with `gitGraph` diagrams that I wanted to keep rendering, so I filed [issue #87](https://github.com/seite-sh/seite/issues/87) and then built my own workaround.

Rather than ship Mermaid globally, I gated it behind a per-post frontmatter flag. One line in the frontmatter turns it on:

```yaml
extra:
  mermaid: true
```

When that flag is set, `base.html` lazy-loads Mermaid from the jsDelivr CDN and runs a regex over every `<pre><code>` block to detect diagram types (`gitGraph`, `sequenceDiagram`, `flowchart`, ...) and swap them into `<div class="mermaid">`. When the flag is off — which is 99% of the posts — there is zero Mermaid payload. I like that trade-off.

### The `base_url` footgun

`seite.toml` currently has the production URL (`https://noenieto.com`) commented out and `http://localhost:4000` active, because I develop locally most of the time. Seite's `auto_commit` deploy does not flip this for me. If I ever deploy without uncommenting the production URL, every canonical link, every RSS entry, and every sitemap URL points at `localhost`. I have not done it yet, but I will.

## The flexes

This is the part where I get to brag a little. Here are the bits of the rebuild I am proudest of.

### The personal section (and the three skills it forced me to write)

If the résumé is the page I am *technically* proudest of, the personal section is the one I am *emotionally* proudest of — the corner of the site where I stepped away from code to write about family, home, and the thread underneath it all.

The hero image is a redrawn, illustrated version of a personal photo. The old Jekyll site just showed the original straight up, and it never sat right with me. This time I fed it into [Gemini](https://gemini.google.com/) with a prompt from my `ilustracion` skill — Doré-style cross-hatching, 19th-century ink-on-parchment — and what came back is, frankly, beautiful. It is the portrait I always wanted on the front of my site, and it took an LLM to draw it for me.

The body of that section tells a long family story — arrivals, losses, and the quiet continuity of sharing a home over many years. I do not think I could have written any of it by hand — not because it is technically hard, but because it is emotionally heavy. The `redaccion` skill gave me enough editorial distance to draft it without freezing up.

And here is the part that genuinely surprised me: **building this page is what forced me to write the three custom skills in the first place.**

- The hero image needed the `ilustracion` skill, because I kept regenerating prompts and had to systematize them.
- The dog saga needed the `redaccion` skill, because writing about dead dogs without sounding maudlin is hard, and I needed an editor that would not flinch.
- Both needed the `design-system` skill, because the floating figure callouts, the sidenote footnotes, the typography — none of it worked without rules.

The skills were not planned up front. They crystallized out of the needs this one page kept surfacing. Every time I hit a wall, the answer was: write a skill, so the next agent does not have to relearn the lesson.

### Letting the agent read my GitHub

The other two pages where the agent did serious lifting are [Demos & Tools](/demos) and [As a teacher](/as-a-teacher). The workflow was the same in both cases: I pointed the agent at my GitHub profile, told it which repositories to look at, and asked it to produce a curated markdown summary of each one.

For `as-a-teacher` it read my course repositories and produced a structured per-semester, per-class breakdown, with links to the course materials. For `demos` it categorized roughly twenty-five repositories into *Demos*, *Tools*, and *Archived*, with one-line descriptions in my voice.

That *Archived* category is where things got unexpectedly productive. While the agent was already in there cataloging, I had it help me actually archive a bunch of repositories I had not touched in years — LFS plugins, an old Haroopad Flatpak, a PHP hook deploy tool, a Calculadora Gasolinazo Android app from 2013. Technical debt that had been sitting on my profile for over a decade, cleaned up in an afternoon.

Real talk: writing those three pages by hand — the personal section, `demos`, `as-a-teacher` — would have taken me months. Honestly, probably never. The emotional cost alone would have killed the project. With the agent, each page took a couple of 15-minute rounds of me directing and correcting. That is the whole pitch of this post in one sentence.

### My résumé is a literal git commit graph

This is my favorite thing on the site. My [résumé page](/as-a-professional) renders my career as a four-lane `gitGraph` diagram — one lane each for my day job, consulting work, my previous startup (Holokinesis), and teaching. Each role is a commit dot. Each role has a seven-character hash. Each ongoing role gets a `▲ HEAD` marker. The whole thing is rendered in pure [Tera](https://keats.github.io/tera/docs/) template + CSS — **no JavaScript**.

The Tera template literally computes which branches are "active" at each row by comparing start/end dates parsed as integers. The supporting CSS is 500+ lines, with three responsive breakpoints that gracefully collapse the lanes on mobile. I am unreasonably proud of it.

### Tufte-style sidenote footnotes, by hand

I have always loved the way [Edward Tufte](https://edwardtufte.github.io/tufte-css/) floats footnotes into the right margin instead of dumping them at the bottom of the page. I wanted that. I built it. The footnotes now float into the right margin at `margin-right: -45%` on desktop and collapse to inline at the bottom on mobile.

### The dotted-leader blog index

The [/blog](/blog) listing is styled like the index page of an old printed book — title on the left, date on the right, and a row of dots connecting them. The dots are a `radial-gradient`, and there is a comment in the CSS explaining why I used the `circle` keyword: without it, an anti-aliasing artifact in Chrome made the dots look like tiny diamonds. Tiny detail, but it is exactly the kind of detail that makes the difference between *almost right* and *right*.

### The animated footer

The footer has an SVG of a boat rocking on a wavy sea. Three keyframe animations — `sway`, `float`, `wobble` — drive the boat over a wave SVG, and the whole thing is pure CSS. The copyright notice is in Roman numerals: `© MCMXXIV NOE NIETO` (1924, a fictional founding date). It is silly. I love it.

### Hand-rolled JSON-LD that exceeds the bundled spec

Seite's bundled themes ship one JSON-LD block. My `base.html` ships four: a `Person` block unconditionally, and then conditionally a `BlogPosting`, an `Article`, or a `WebSite` block (with a `SearchAction`), plus a `BreadcrumbList`. I want the rich snippets. I want the cards. I am not apologizing for it.

## Image generation

My `ilustracion` skill produces an English prompt — Doré cross-hatching, Haeckel-inspired symmetry, Bavarian limestone lithography — and I feed that prompt into [Gemini](https://gemini.google.com/) (the model the internet has nicknamed *"nano-banana"*). The output goes straight into hero images and post headers. I absolutely love it. It is the closest I have ever come to having an illustrator on call.

## What I learned

The biggest lesson is one I kind of already knew: **the agent is the typist, not the architect**. Every line of CSS, every Tera template, every frontmatter field on this site was written by an LLM — but none of it went in without me reading it, understanding it, and either accepting it or sending it back. The `design-system` skill exists precisely so that *I* decide the visual rules once, and every agent after that has to follow them. Directing an LLM to produce code you can stand behind is a real skill, and a different one from writing the code yourself. You have to know what you want, you have to recognize when the model is wrong, and you have to be honest about which parts you actually understand and which parts you are rubber-stamping. I tried to stay honest about that throughout the project.

The second lesson is that **AI-first tooling is not the same as AI-only tooling**. Seite is AI-first in the sense that it is designed to be steered by an agent. It is not AI-only in the sense that the agent does everything. The best results came from me knowing exactly what I wanted (a 19th-century letterpress monograph aesthetic, an atomic design CSS architecture, a git-graph résumé) and pointing the agent at it like a heat-seeking missile.

## The kicker

Fourteen years, three static site generators, and I am still not a designer. But at least the site looks like I am.

If you ever stumble upon Seite, give it a shot. And if Claude's price tag puts you off — now you know it can be hacked. See you in the next post. 👋

![A small wooden boat rocking on a wavy sea at sunset. Woodcut engraving in the style of Gustave Doré.](/static/images/posts/2026-07-20-from-jekyll-to-seite/seite-2.png)
