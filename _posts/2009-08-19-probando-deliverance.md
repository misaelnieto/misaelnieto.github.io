---
title: "Probando deliverance"
categories: Programación
---

Acabo de instalar mi sitio web

Ahora estoy probando esto:

[http://deliverance.openplans.org/quickstart.html](http://web.archive.org/web/20081009012029/http://deliverance.openplans.org/quickstart.html)

Pero tengo errores:

```
................
xmllint.o: In function ignorableWhitespaceDebug':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmllint.c:1333: undefined reference to `__stack_chk_fail'
xmllint.o: In function `charactersDebug':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmllint.c:1292: undefined reference to `__stack_chk_fail'
xmllint.o: In function `parseAndPrintFile':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmllint.c:2770: undefined reference to `__stack_chk_fail'
xmllint.o: In function `xmlShellReadline':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmllint.c:811: undefined reference to `__stack_chk_fail'
./.libs/libxml2.a(entities.o): In function `xmlEncodeEntitiesReentrant':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/entities.c:695: undefined reference to `__stack_chk_fail'
./.libs/libxml2.a(encoding.o):/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/encoding.c:2225: more undefined references to `__stack_chk_fail' follow
./.libs/libxml2.a(xmlIO.o): In function `xmlGzfileOpenW':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmlIO.c:1203: undefined reference to `gzopen64'
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmlIO.c:1205: undefined reference to `__stack_chk_fail'
./.libs/libxml2.a(xmlIO.o): In function `xmlGzfileOpen_real':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmlIO.c:1135: undefined reference to `gzopen64'
./.libs/libxml2.a(xmlIO.o): In function `xmlZMemBuffExtend':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmlIO.c:1490: undefined reference to `__stack_chk_fail'
./.libs/libxml2.a(xmlIO.o): In function `xmlIOHTTPCloseWrite':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmlIO.c:1968: undefined reference to `__stack_chk_fail'
./.libs/libxml2.a(xmlIO.o): In function `xmlIOHTTPWrite':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmlIO.c:1816: undefined reference to `__stack_chk_fail'
./.libs/libxml2.a(xmlIO.o): In function `xmlIOHTTPOpenW':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/xmlIO.c:1735: undefined reference to `__stack_chk_fail'
./.libs/libxml2.a(uri.o): In function `xmlURIEscape':
/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/uri.c:1919: undefined reference to `__stack_chk_fail'
./.libs/libxml2.a(valid.o):/tmp/pip-L5Yubm-build/build/tmp/libxml2-2.7.2/valid.c:6393: more undefined references to `__stack_chk_fail' follow
collect2: ld returned 1 exit status

make[2]: *** [xmllint] Error 1
make[2]: Leaving directory `/app/deliverance/build/lxml/build/tmp/libxml2-2.7.2'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/app/deliverance/build/lxml/build/tmp/libxml2-2.7.2'
make: *** [all] Error 2

Building lxml version 2.2.alpha1.

Using existing libxml2 downloaded into libs/libxml2-2.7.2.tar.gz (delete this file if you want to re-download the package)

Unpacking libxml2-2.7.2.tar.gz into build/tmp

Using existing libxslt downloaded into libs/libxslt-1.1.24.tar.gz (delete this file if you want to re-download the package)

Unpacking libxslt-1.1.24.tar.gz into build/tmp

Traceback (most recent call last):

  File "", line 13, in ?
  File "/app/deliverance/build/lxml/setup.py", line 107, in ?
    STATIC_CFLAGS, STATIC_BINARIES),
  File "setupinfo.py", line 46, in ext_modules
    libxslt_version=OPTION_LIBXSLT_VERSION)
  File "buildlibxml.py", line 190, in build_libxml2xslt
    call_subprocess(
  File "buildlibxml.py", line 151, in call_subprocess
    raise Exception('Command "%s" returned code %s' % (cmd_desc, returncode))

Exception: Command "make" returned code 2

----------------------------------------
Command python setup.py egg_info failed with error code 1
Storing complete log in ./pip-log.txt
```


La discusion que parece ser mi problema es:

<http://www.coactivate.org/projects/deliverance/lists/deliverance-discussion/archive/2009/02/1234518446686/forum_view#1234574348405>

<http://keeshink.blogspot.com/2009/03/installing-deliverance.html>

---

