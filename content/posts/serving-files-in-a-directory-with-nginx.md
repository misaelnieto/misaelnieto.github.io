---
title: "Serving files in a directory with nginx"
date: "2011-07-14"
summary: "Un location con autoindex on basta para servir un directorio con listado automático en nginx."
description: "Cómo configurar nginx para servir archivos desde un directorio específico con listado automático de archivos."
categories:
  - "DevOps"
tags:
  - nginx
  - autoindex
  - static-files
locale: "es_MX"
keywords: "nginx, autoindex, static files, location, server block"
---

I love nginx's simplicity.

![Serving files in a directory with nginx](/static/images/posts/serving-files-in-a-directory-with-nginx/nginx.png)

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
