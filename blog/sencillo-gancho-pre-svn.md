---
title: Sencillo gancho pre-commit de SVN (pre-commit hook)
date: 2016-03-10
description: 'Implementación mínima de un hook pre-commit de SVN en bash: rechaza el commit si el autor no está listado en trusted_people.txt. Incluye el script completo.'
tags:
- svn
- pre-commit
- hook
- bash
- control-de-versiones
extra:
  deprecated: true
  deprecated_reason: SVN es legacy en la mayoría de equipos modernos (Git ganó). El hook pre-commit canónico hoy en día es el framework pre-commit multi-lenguaje basado en Python.
---

![Ganchos :) ](/static/images/posts/sencillo-gancho-pre-svn/8625204550_bf437a1f91_o.jpg)

El repo de SVN está en:

```console
/var/www/svn-repo/hooks
```

Necesitas dos archivos:

* `/var/www/svn-repo/hooks/pre-commit`
* `/var/www/svn-repo/hooks/trusted_people.txt`

El `pre-commit` queda así:

```bash
#!/bin/sh
REPOS="$1"
TXN="$2"
SVNLOOK=/usr/bin/svnlook

D00D=`$SVNLOOK author "$REPOS" -t "$TXN"`
MATCH=`fgrep -c "$D00D" "$REPOS/hooks/trusted_people.txt"`
if [ $MATCH -eq 0 ]; then
    echo "Nel, sáquese de aquí!!" 1>&2
    exit 1;
fi
exit 0
```

Y `trusted_people.txt` es un archivo de texto con una lista de nombres, uno
por línea.

---
Créditos:

La foto de los ganchos de ropa es de
<https://www.flickr.com/photos/13804799@N02/8625204550/>

**FIN**
