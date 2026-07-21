---
title: "Detectar el Sistema Operativo en Mono/C#"
date: "2014-08-28"
categories:
  - "Español Programación"
description: "Tutorial para detectar el sistema operativo desde una aplicación C# compilada con Mono, usando Environment.OSVersion.Platform y ejecutando tanto en Linux como en Windows."
---

![Chango](/static/images/posts/detectar-so-en-mono/8078455784-1906e170da-o-0.jpg)

Me basé en [esta solución](http://mono.wikia.com/wiki/Detecting_the_execution_platform):

Mi programita queda asi:

```csharp
using System;

namespace UnixApp
{
    class MainClass
    {
        private static bool IsUnix () {
            return Environment.OSVersion.Platform == PlatformID.Unix;
        }

        public static void Main (string[] args)
        {
            Console.WriteLine("{0}", IsUnix()? "Unix": "Windoge");
        }
    }
}
```

Lo guarde en una carpeta compartida entre Fedora (anfitrion) y Windows 8.1 (En
una VM de VirtualBox) con el nombre de `detecta.cs`. Posteriormente lo compile
con Mono:

```console
mcs detecta.cs
```

El programa se compilo sin ningun error. Posteriormente lo ejecute en Linux y
en Windows. Aca la foto de como queda en Fedora:

![Mono en Fedora 20](/static/images/posts/detectar-so-en-mono/screenshot-from-2014-08-28-14-36-00.png)

Y aca abajo pongo la fotito de como queda en Windows 8.1.

![Exe compilado con Mono y corriendo en Windows](/static/images/posts/detectar-so-en-mono/screenshot-from-2014-08-28-14-37-10.png)

---
La imagen del chango es de <https://flic.kr/p/diScsq>
