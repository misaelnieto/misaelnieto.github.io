---
title:  "Detectar el Sistema Operativo en Mono/C#"
categories: Español Programación
---

![Chango](/media/8078455784_1906e170da_o_0.jpg)

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

![Mono en Fedora 20](/media/Screenshot_from_2014_08_28_14_36_00.png)

Y aca abajo pongo la fotito de como queda en Windows 8.1.

![Exe compilado con Mono y corriendo en Windows](/media/Screenshot_from_2014_08_28_14_37_10.png)

---
La imagen del chango es de <https://flic.kr/p/diScsq>
