---
title: NoeNieto.com is powered by ...
subtitle: What is this site made of?
layout: page
hero_height: is-small
hero_darken: true
---

## Technologies

* [Jekyll](https://jekyllrb.com/)
    - Version: {{jekyll.version}}
    - Plugins:
        - [jekyll-feed](https://github.com/jekyll/jekyll-feed)
        - [jekyll-seo-tag](https://github.com/jekyll/jekyll-seo-tag)
        - [jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap)
        - [jekyll-timeago](https://github.com/markets/jekyll-timeago)
        - [jekyll-thumbnail-img](https://github.com/oturpe/jekyll-thumbnail-generator)
    - [Bulma Clean Theme](https://www.csrhymes.com/bulma-clean-theme/) ({{theme.description}}) version `{{theme.version}}`, built by [C.S. Rhymes](https://www.csrhymes.com/) which uses [Bulma CSS](https://bulma.io/).
* I used to host this site on [opalstack](https://github.com/misaelnieto/misaelnieto.github.io/blob/615f30a7791f9bfd4e6243b03f7ef000d797630f/.github/workflows/jekyll.yml) but moved it to [vercel](https://vercel.com/) on 2023 to take advantage of their free tier. You can see the [vercel configuration file](https://github.com/misaelnieto/misaelnieto.github.io/blob/master/vercel.json).
* The source code is hosted on my [github](https://github.com/misaelnieto/misaelnieto.github.io) repository.

## Site stats

* Posts count: {{ site.stats.posts }}
* Pages count: {{ site.stats.pages }}
* Drafts: {{site.stats.draft_count }}
* Pages images: {{ site.stats.images }}
