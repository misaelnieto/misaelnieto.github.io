# misaelnieto.github.io

[![Netlify Status](https://api.netlify.com/api/v1/badges/fdaf4a94-b846-434d-a68f-d6bfd89359cb/deploy-status)](https://app.netlify.com/sites/noenieto/deploys)

## English

Welcome, this is the source code of my blog, powered by Jekyll, GitHub Actions
and the [bulma-clean-theme](https://github.com/chrisrhymes/bulma-clean-theme).
If you are curious of how I did that then read the blog post.


## Getting started

You need to have Ruby and Bundler installed.


On windows, you can use `winget install RubyInstallerTeam.RubyWithDevKit`.
On MacOS, you can use `brew install ruby`.
On linux, you can use `apt-get install ruby-full` (debian/ubuntu) or `dnf install ruby` (fedora).

Then install bundler with:

```bash
gem install bundler
```

Now clone this repo and cd into the directory.Then run:

```bash
bundle install
```

This should install all the dependencies. After that, launch the site with:

```bash
bundle exec jekyll serve
```

