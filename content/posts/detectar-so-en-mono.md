---
title: "Detectar el Sistema Operativo en Mono/C#"
summary: "Cómo detectar si el código C# corre en Unix o Windows usando Environment.OSVersion.Platform."
description: "Tutorial para detectar el sistema operativo desde una aplicación C# compilada con Mono, usando Environment.OSVersion.Platform y ejecutando tanto en Linux como en Windows."
date: "2014-08-28"
categories:
  - "Tutoriales"
tags:
  - c-sharp
  - mono
  - net
  - platformid
  - system
locale: "es_MX"
keywords: "Mono, C#, Environment.OSVersion, PlatformID, detectar sistema operativo, mcs"
extra:
  deprecated: true
  deprecated_reason: "Mono fue reemplazado por .NET Core / .NET 5+ (ahora simplemente .NET); el patrón Environment.OSVersion.Platform sigue siendo válido en .NET moderno, pero ya nadie compila apps de consola con mcs en 2024."
---

![Chango](/static/images/posts/detectar-so-en-mono/8078455784-1906e170da-o-0.jpg)

Me basé en [esta solución](http://mono.wikia.com/wiki/Detecting_the_execution_platform).

Mi programita queda así:

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

Lo guardé en una carpeta compartida entre Fedora (anfitrión) y Windows 8.1 (en
una VM de VirtualBox) con el nombre de `detecta.cs`. Posteriormente lo compilé
con Mono:

```console
mcs detecta.cs
```

El programa se compiló sin ningún error. Posteriormente lo ejecuté en Linux y
en Windows. Acá la foto de cómo queda en Fedora:

![Mono en Fedora 20](/static/images/posts/detectar-so-en-mono/screenshot-from-2014-08-28-14-36-00.png)

Y acá abajo pongo la fotito de cómo queda en Windows 8.1.

![Exe compilado con Mono y corriendo en Windows](/static/images/posts/detectar-so-en-mono/screenshot-from-2014-08-28-14-37-10.png)

---
La imagen del chango es de <https://flic.kr/p/diScsq>
