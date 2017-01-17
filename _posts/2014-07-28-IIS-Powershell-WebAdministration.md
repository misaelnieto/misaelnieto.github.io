---
title:  "Jugando con IIS, Powershell y WebAdministration"
categories: Web DevOps Servers Windows
---

![Pagüer Chel!](/media/IMG_5096b.jpg)

## Intro

Últimamente he tenido oportunidad de configurar varios servidores con IIS 7.5,
algunos desde cero. He aprendido un montón acerca de esta tecnología. También
he estado haciendo algo de trabajo tipo DevOps y estoy configurando un Jenkins
para correr pruebas con Selenium  automáticamente después de un commit de SVN
simplemente por que las pruebas manuales son aburridas.

Hay algo que quiero probar. Puedo configurar Jenkins para que elimine el
directorio de la aplicacion web y haga un checkout limpio de la aplicación
desde el SVN, pero me queda la duda de qué pasará con el sitio en IIS si de
repente desaparece la carpeta de la aplicación. Así que me pregunté si sería
posible controlar IIS mediante PowerShell. La respuesta es **SI**.

Con el módulo/provider `WebAdministration` puedo borrar una aplicación del IIS,
luego que Jenkins elimine el directorio y haga un checkout limpio desde el SVN
y finalmente restablecer la configuración de la aplicación web.

¡Manos a la obra!

## Configurar la política de ejecución de scripts

¡Ash! Pues resulta que por default PowerShell se negará a ejecutar scripts o
ciertos comandos que signifiquen algún riesgo para el sitema. [Es una historia
larga](http://technet.microsoft.com/en-us/library/ee176949.aspx) y por el
momento se interpone en mi objetivo que es controlar IIS con PowerShell y
resulta más cómodo desactivar esa política completamente y después regresar a
aprender esa parte. Si estas igual de impaciente como yo, sigue estos pasos:

1. Ejecuta PowerShell como Administrador.

2. Pon esto en el PowerShell: `Set-ExecutionPolicy Unrestricted`

3. Listo

Al abrir de nuevo la consola de PowerShell el resultado de
`Get-ExecutionPolicy` es `Unrestricted`.

Incluso reiniciando el servidor el resultado de`Get-ExecutionPolicy` debe ser `Unrestricted`.

## Verificar que WebAdministration este disponible

Esto lo hice con el cmdlet `Get-Module -ListAvailable`.

```powershell
PS C:\Windows\system32> Get-Module -ListAvailable

ModuleType Name                      ExportedCommands
---------- ----                      ----------------
Manifest   ADRMS                     {}
Manifest   AppLocker                 {}
Manifest   BestPractices             {}
Manifest   BitsTransfer              {}
Manifest   PSDiagnostics             {}
Manifest   ServerManager             {}
Manifest   TroubleshootingPack       {}
Manifest   WebAdministration         {}


PS C:\Windows\system32>
```

El modulo esta disponible. Ahora para importarlo:

```powershell
Import-Module WebAdministration
```
## Probando algunas características

La lista completa de cmdlets esta [disponible en MSDN](http://technet.microsoft.com/en-us/library/ee790599.aspx).
No pude probar todos, pues mi objetivo es claro, así que sólo probe unos
cmdlets para tener una idea de cómo funciona.

El primer comando que probe fue `Get-WebConfigFile`. Si lo uso en el sitio por
default me dice el directorio y el nombre del archivo de configuración del
sitio.

```powershell
PS C:\Windows\system32> Get-WebConfigFile 'IIS:\Sites\Default Web Site'

    Directory: C:\Windows\system32\inetsrv\config

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         7/23/2014   3:38 PM      83583 applicationHost.config
```

Se me hizo demasiado mágico por que corrió bién al primer intento, además,
¿Qué es eso de `IIS:\`? ¿Qué pasa si le doy una ruta que no existe?

```powershell
PS C:\Windows\system32> Get-WebConfigFile 'IIS:\Sites\Default Web Sit'
Get-WebConfigFile : Cannot find path 'IIS:\Sites\Default Web Sit' because it does not exist.
At line:1 char:18
+ Get-WebConfigFile <<<<  'IIS:\Sites\Default Web Sit'
    + CategoryInfo          : ObjectNotFound: (IIS:\Sites\Default Web Sit:String) [Get-WebConfigFile], ItemNotFoundExc
   eption
    + FullyQualifiedErrorId : PathNotFound,Microsoft.IIs.PowerShell.Provider.GetWebConfigCommand
```

Creo que voy entendiendo. Ya tengo una aplicacion configurada con el nombre
`recepcion` ¿Cuál será el resultado si pido el archivo de configuración de
`IIS:\Sites\Recepcion`?

```powershell
PS C:\Windows\system32> Get-WebConfigFile 'IIS:\Sites\Default Web Site\recepcion'

    Directory: C:\inetpub\wwwroot\recepcion

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         7/23/2014   8:55 AM       4753 web.config
```

Tengo una aplicacion que se llama `Recibos` actualizada desde el SVN, pero no la
he convertido en aplicación desde el IIS Manager ¿Qué pasará si pido el
archivo de configuración de esa aplicación que todavía no esta configurada?

```powershell
PS C:\Windows\system32> Get-WebConfigFile 'IIS:\Sites\Default Web Site\recepcion'

    Directory: C:\inetpub\wwwroot\recepcion

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         7/24/2014   9:02 AM       4678 web.config
```

¡Aha! Parece que algunas partes no son tan sofisticadas. Suficientes pruebas.

Ahora quiero saber cómo configurar esa carpeta como una aplicación en el
sitio. Una leída rápida a la [lista de cmdlets](http://technet.microsoft.com/en-us/library/ee790599.aspx) 
y encuentro [`ConvertTo-WebApplicacion`](http://technet.microsoft.com/en-us/library/ee807827.aspx).
Incluso tiene un ejemplo de cómo se usa. Al final, resultó ser
muy fácil y son sólamente dos pasos.

Primero, crear un directorio virtual que apunte a la carpeta de Recepción.

```powershell
PS C:\Windows\system32> New-WebVirtualDirectory -Site "Default Web Site" -Name Recepcion -PhysicalPath C:\InetPub\wwwroot\recepcion

Name                                                        PhysicalPath
----                                                        ------------
Recepcion                                                     C:\InetPub\wwwroot\recepcion
```

Y luego convertir el sitio virtual en una aplicación:

```powershell
PS C:\Windows\system32> ConvertTo-WebApplication "IIS:\Sites\Default Web Site\recepcion"

Name             Application pool   Protocols    Physical Path
----             ----------------   ---------    -------------
Recepcion          DefaultAppPool     http         C:\InetPub\wwwroot\recepcion
```

¡Listo!

Pero falta algo. Hice las cosas al reves, por que ya tengo el comando para
configurar el sitio, ahora me falta el comando para desconfigurarlo. Pero no
es tan dificil, sólamente hace falta hacer la misma operación que hice al
principio, pero al revés. Primero, uso [`Remove-Application`](http://technet.microsoft.com/en-us/library/ee790563.aspx)

```powershell
Remove-WebApplication -Name recepcion -Site "Default Web Site"
```

Después

```powershell
Remove-WebVirtualDirectory -Site "Default Web Site" -Application "/" -Name "recepcion"
```

Ya con eso es suficiente para "desconfigurar" el sitio. Jenkins se encargara
de borrar y hacer el checkout del proyecto desde el SVN.

----

*Nota*: No recuerdo de donde saque la imagen de portada. Si alguien sabe, avisenme
para poner bien los créditos.
