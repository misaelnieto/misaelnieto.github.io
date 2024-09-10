---
title: Serving files in a directory with nginx
layout: post
---

I love nginx's simplicity

![Serving files in a directory with nginx](/media/nginx.png)

Today I wanted to publish some files in a directory with nginx and I was
surprised how easy it was.

All I needed to do was to create a file in `/etc/nginx/sites-enabled/newsite`
and add the following:

```nginx
server {
    listen 80;
    server_name newsite.mysite.com;
    location / {
        root /path/to/folder/with/files;
        autoindex on;
    }
}

```

Reload nginx and enjoy.
