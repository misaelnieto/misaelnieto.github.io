---
layout: post
title: Migrating blog from GH Pages to GH Actions
summary: GH Pages is too restrictive, let's fix it with GH Actions
language: es
comments: true
published: true
categories:
  - Technology
tags: 
  - Github
  - Devops
  - Blog
image: /media/unsplash/markus-spiske-Tem0_jHYDgQ-unsplash.jpg
date: 2020-05-11 23:32
---

This is how my blog looks before update:

![Before update]({{site.baseurl}}/media/screenshots/Screenshot_2020-05-11-blog.png)

GitHub Pages is cool, but it only supports [a fixed set of themes](https://pages.github.com/themes/). After several
years of neglect, the COVID19 quarantine gave me enough spare time to give my
blog some long needed attention.

Initially I wanted to use the [foundation theme](https://github.com/gnarlacious/jekyll-theme-foundation), but after some thought I ended using
[bulma-clean-theme](https://github.com/chrisrhymes/bulma-clean-theme) because
colors are nicer and also has some degree of configurability.

These are the things I did:

- I added a new front-page layout to present the latest 5 posts.
- Configured the new navigation menu links:
- Setup a page for the posts archive
- The about page was ugly and had to go, so i replaced it with a link to my main page.
- I also upgraded Jekyll to 3.8

I also worked a bit on the deployment. I want to make the deployment automatic.
GH Pages didn't like my customizations, so I had to find another way.

### GH Actions to the rescue.

I ended up concocting something like this:

{% raw %}
```yml
name: Jekyll site CI

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build_and_deploy:
    runs-on: ubuntu-latest
    steps:
      - name: GitHub Checkout
        uses: actions/checkout@v1
      - name: Bundler Cache
        uses: actions/cache@v1
        with:
          path: vendor/bundle
          key: ${{ runner.os }}-gems-${{ hashFiles('**/Gemfile.lock') }}
          restore-keys: |
            ${{ runner.os }}-gems-
      - name: Build & Deploy to GitHub Pages
        uses: joshlarsen/jekyll4-deploy-gh-pages@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GITHUB_REPOSITORY: ${{ secrets.GITHUB_REPOSITORY }}
          GITHUB_ACTOR: ${{ secrets.GITHUB_ACTOR }}
      - name: Rsync the build
        uses: Pendect/action-rsyncer@v1.1.0
        env:
          DEPLOY_KEY: ${{secrets.DEPLOY_KEY}}
        with:
          src: _site/
          # Remote server and path. i.e user@server.com:/var/www/server.com/
          dest: nnieto@opal7.opalstack.com:/home/nnieto/apps/blog_noenieto_com/
      - name: Display status from deploy
        run: echo "${{ steps.deploy.outputs.status }}"
```
{% endraw %}

The steps of this pipeline are:

- [Checkout](https://github.com/actions/checkout) the latest changes on master
- Cache bundler dependencies.
- [Build the blog](https://github.com/joshlarsen/jekyll4-deploy-gh-pages) and save it to the `_site` folder.
- Upload the site using [rsync](https://github.com/Pendect/action-rsyncer).

To configure the rsync connection to my server I created a SSH keypair using the [Ed25519 algorithm](https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54).
After that I copied the private key and pasted it as `DEPLOY_KEY` into my repo's [encrypted secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets).

I created a `.nojekyll` file in the root of my repository so that the GH Pages
robot won't try to build my site.

Finally I reconfigured my DNS to point to the new server. And this is the way it
looks now.

![After update]({{site.baseurl}}/media/screenshots/Screenshot_2020-05-12-blog.png){:class="img-responsive"}


## Credits

<span>Cover photo by <a href="https://unsplash.com/@markusspiske">Markus Spiske</a> on 
<a href="https://unsplash.com/s/photos/actions">Unsplash</a></span>
