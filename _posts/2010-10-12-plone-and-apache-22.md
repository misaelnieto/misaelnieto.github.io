---
title: Plone and Apache 2.2
layout: post
categories: Plone Apache
---

## Weirdness with Plone and Apache 2.2

While migrating one Plone 3 site to another server I got some unexpected configuration issues.

I have just migrated the python.org.mx site to another server. It has a Plone
3.3.5 site with PloneHelpCenter and a Planet Aggregator for blogs. There's a
Varnish instance in the middle. Moving this site was very strightforward
except for a unexpected Apache configuration directive for `mod_proxy`.

Normally we used this `mod_rewrite` directives to make the magic happen:

```apache
RewriteEngine On
RewriteRule ^/(.*)/$ http://127.0.0.1:8080/VirtualHostBase/http/%{HTTP_HOST}:80/PythonMexico/VirtualHostRoot/$1 [L,P]

RewriteRule ^/(.*) http://127.0.0.1:8080/VirtualHostBase/http/%{HTTP_HOST}:80/PythonMexico/VirtualHostRoot/$1 [L,P]
```

But that wasn't enough for Apache 2.2 and the Proxy redirection was not being
made resulting in a error like this:

```
[Mon Oct 11 23:24:08 2010] [error] [client 220.181.94.228] client denied by server configuration: proxy:http://127.0.0.1:8080/VirtualHostBase/http/www.pythonmexico.org:80/PythonMexico/VirtualHostRoot/
```

After some testing I realized that I had to explicity allow the reverse proxy to varnish:

```apache
<IfModule mod_proxy.c>
  <Proxy proxy:http://127.0.0.1:8080/>
    Order deny,allow
    Allow from localhost
  </Proxy>
</IfModule>
```

So, that's it !
