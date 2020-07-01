---
layout: post
title: The simplest GitHub workflow for deploying static sites
date: 2020-05-17 22:19
category: development
tags: [github, devops]
summary: It's really simple, just checkout and rsync
---

Ever since I learned about [GitHub
Actions](https://github.com/features/actions), I'm trying to automate anything I
can. This time I automated the deployment of my [personal
webpage](https://www.noenieto.com/). It's very easy, just checkout and upload
the changes using rsync.

{% raw %}
```yaml
name: Deploy my site

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
      - name: Rsync the build
        uses: Pendect/action-rsyncer@v1.1.0
        env:
          DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }}
        with:
          options: '--exclude-from=.rsyncexclude --delete-excluded'
          src: .
          # Remote server and path. i.e user@server.com:/var/www/server.com/
          dest: ${{ secrets.RSYNC_DEST }}
```
{% endraw %}

Since we are using rsync, I could take advantage of the `--exclude-from` and
`--delete-excluded` options to remove unwanted things on the server.

The `secrets` variable is provided by the GH action runner. To define the
secrets, you need to go to *Settings*->*Secrets* on your repo. Read the
[documentation]([https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets)
for the full details.