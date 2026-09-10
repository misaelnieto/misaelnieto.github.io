---
title: Plone and Apache 2.2
date: 2010-10-12
description: Notas sobre un problema con mod_proxy y Apache 2.2 al migrar un sitio Plone 3.3.5 detrás de Varnish.
tags:
- plone
- apache
- mod-proxy
- varnish
extra:
  deprecated: true
  deprecated_reason: Apache 2.2 es EOL; en Apache 2.4 las directivas Order/Allow fueron reemplazadas por Require
---

## Weirdness with Plone and Apache 2.2

While migrating one Plone 3 site to another server I got some unexpected
configuration issues.

I have just migrated the `python.org.mx` site to another server. It has a
Plone 3.3.5 site with `PloneHelpCenter` and a Planet aggregator for blogs.
There's a Varnish instance in the middle. Moving this site was very
straightforward except for an unexpected Apache configuration directive for
`mod_proxy`.

Normally we used these `mod_rewrite` directives to make the magic happen:

```apache
RewriteEngine On
RewriteRule ^/(.*)/$ http://127.0.0.1:8080/VirtualHostBase/http/%{HTTP_HOST}:80/PythonMexico/VirtualHostRoot/$1 [L,P]

RewriteRule ^/(.*) http://127.0.0.1:8080/VirtualHostBase/http/%{HTTP_HOST}:80/PythonMexico/VirtualHostRoot/$1 [L,P]
```

But that wasn't enough for Apache 2.2 and the proxy redirection was not being
made, resulting in an error like this:

```
[Mon Oct 11 23:24:08 2010] [error] [client 220.181.94.228] client denied by server configuration: proxy:http://127.0.0.1:8080/VirtualHostBase/http/www.pythonmexico.org:80/PythonMexico/VirtualHostRoot/
```

After some testing I realized that I had to explicitly allow the reverse proxy
to Varnish:

```apache
<IfModule mod_proxy.c>
  <Proxy proxy:http://127.0.0.1:8080/>
    Order deny,allow
    Allow from localhost
  </Proxy>
</IfModule>
```

So, that's it.
