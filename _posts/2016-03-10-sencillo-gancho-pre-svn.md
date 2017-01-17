---
title: "Sencillo gancho pre-commit de SVN (pre-commit hook)"
categories: DevOps
---

![Ganchos :) ](/media/8625204550_bf437a1f91_o.jpg)

El Repo de SVN esta en:

```console
/var/www/svn-repo/hooks
```
Necesitas dos archivos: `/var/www/svn-repo/hooks-pre-commit`
y`/var/www/svn-repo/hooks-trusted_people.txt`

El pre-commit queda asi:

```bash
#!/bin/sh
REPOS="$1"
TXN="$2"
SVNLOOK=/usr/bin/svnlook

D00D=`$SVNLOOK author "$REPOS" -t "$TXN"`
MATCH=`fgrep -c "$D00D" "$REPOS/hooks/trusted_peope.txt"`
if [ $MATCH -eq 0 ]; then
    echo "Nel, saquese de aqui!!" 1>&2
    exit 1;
fi
exit 0
```

Y `trusted_people.txt` es un archivo de texto con una lista de nombres en cada linea.

---
Créditos:

La foto de los ganchos de ropa es de <https://www.flickr.com/photos/13804799@N02/8625204550/>
