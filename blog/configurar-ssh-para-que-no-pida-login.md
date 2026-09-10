---
title: Configurar SSH para que no pida login
date: 2013-12-20
description: Guía paso a paso para configurar autenticación basada en llaves SSH, generando llaves RSA, configurando el archivo ~/.ssh/config y registrando llaves públicas en el servidor.
tags:
- ssh
- sysadmin
- linux
- authentication
- ssh-keys
---

Creo que nunca he escrito acerca de SSH.

SSH tiene una característica que me gusta mucho. Se llama *Key Based
Authentication* o *Autenticación basada en llaves*. La uso para administrar
servidores Linux y correr scripts remotos con [Fabric](http://fabfile.org/);
todo esto sin tener que estar escribiendo nombres de usuario y contraseñas.

Las *llaves* son simples archivos de texto que se generan mediante el comando
`ssh-keygen`. A continuación un ejemplo de cómo generar una llave con el
algoritmo [RSA](http://es.wikipedia.org/wiki/RSA).

```console
$ cd ~/.ssh
$ ssh-keygen -b 4096 -C "Llaves para encripción SSH con 4096 bits" -f llave
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same same passphrase again:
Your identification has been saved in llave.
Your public key has been saved in llave.pub.
The key fingerprint is:
21:77:3b:2a:24:02:65:42:b6:45:b1:cc:f8:a7:a7:33 Llaves para encripción SSH con 4096 bits
The key's randomart image is:
+--[ RSA 4096]----+
|oo++.            |
|.+* .            |
|.o +  . o .      |
| ..    o o .     |
|  ..... S o      |
|   .oo   . .     |
|   . .. .        |
|   Eo  .         |
|   .o            |
+-----------------+
$ ls
llave  llave.pub
```

Para mayor comodidad, cuando me pidió la contraseña presioné *enter* 2 veces
para que la llave no tenga contraseña.

**Nota**: Una llave de SSH sin contraseña constituye una vulnerabilidad,
especialmente si está configurada para dar acceso a otros servidores.

Como resultado de esta operación, se han generado dos archivos: uno con el
nombre `llave` y otro con el nombre `llave.pub`.

El archivo `llave` constituye la llave privada mientras que el archivo
`llave.pub` constituye la llave pública. Ambos son archivos de texto:

```console
$ cat llave.pub
ssh-rsa AAAAB3Nza[... muchos caracteres ...]+gLLuKw== Llaves para encripción SSH con 4096 bits
$ cat llave
-----BEGIN RSA PRIVATE KEY-----
MIIJKQIBAAKCAgEA2HgV5H2MTjaROx0Nj+jXClSuloBCQB0R2m3ig2rJXX4y/Jvg
FnK3ldstd5+92f/SnH0lbakedo/GHj4/zOO5CYMaPO4Ytg8L7QoxoSaloy0UR8sR
D6P7JnPHzAmD8kUC9/sYM0bV6P4y8NsK9c2uWOIAh7BScNlLStqQ/UYdqA6NWnlu
[ ... muchas líneas de texto con caracteres raros ...]
Rt81DJr3/Ap/0hc24FYERSDOQ2eyncDZ+ZLoQSMNZ3frFb6lxh0yBbeVT8eI
-----END RSA PRIVATE KEY-----
```

Ahora es momento de escribir la configuración de SSH del lado del cliente.

```console
$ touch ~/.ssh/config
```

El contenido del archivo es el siguiente:

```kconfig

    Host servidor.com
        IdentityFile ~/.ssh/llave
        User pancho
```

La primera línea `Host servidor.com` le dice a SSH que las siguientes líneas
serán solamente para el servidor `servidor.com`.

La segunda línea define la ruta hacia la llave *privada*.

La tercera línea define el nombre de usuario para `servidor.com`. Normalmente
SSH usa el nombre de usuario definido en las variables de entorno. Esta línea
es especialmente útil cuando el nombre de usuario de la sesión del sistema
cliente es diferente al nombre de usuario del servidor.

¿Recuerdas la llave pública? ¿Qué hacemos con ese archivo? La llave pública se
la podrás enviar al administrador del servidor, o si tú ya tienes acceso,
podrás subir la llave pública al servidor, usando `scp`, por ejemplo:

```console
scp ~/.ssh/llave.pub usuario@servidor.com:~/.ssh/
```

Antes de cerrar la sesión en el servidor, tendrás que registrar la llave
pública como una llave autorizada.

```console
$ cd ~/.ssh
$ cat llave.pub >> authorized_keys
$ chmod -R 700 ~/.ssh
```

Cierra la sesión con el servidor. Ya solo falta establecer los permisos en el
directorio `.ssh` local.

```console

$ chmod -R 700 ~/.ssh
```

Finalmente, prueba la conexión.

```console
    $ ssh servidor.com
    Last login: Fri Dec 20 22:02:42 2013 from 91.138.271.122
    [tzicatl@servidor ~]$
```

**FIN**
