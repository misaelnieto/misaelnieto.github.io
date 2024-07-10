---
published: true
summary: Instrucciones para configurar el accesso ssh a fedora silverblue
image: /media/card_images/a-silver-blue-fedora-hat-besides-a-electrical-sock.svg
title: Instalacion de servidor sshd en Fedora Silverblue
layout: post
---


He estado usando Fedora Silverblue en mi laptop personal desde hace varias semanas y hoy quise instalar un servidor sshd en mi laptop. Creí que la solución sería algún comando con rpm-ostree, pero no fue necesario! El servidor de openssh ya viene preinstalado en la imagen de silverblue, así que solo fue necesario activar el servicio y arrancarlo.

Primero hay que habilitar el servicio. Esto se hace con el comando `systemctl enable sshd.service`:

```bash
$ systemctl enable sshd.service 
Created symlink /etc/systemd/system/multi-user.target.wants/sshd.service → /usr/lib/systemd/system/sshd.service.
```

Lo siguiente es arrancar el servicio `systemctl start sshd.service`. Para verificar si funcionó puedes usar `systemctl status sshd.service`:


```bash
 systemctl status sshd.service 
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: disabled)
     Active: active (running) since Mon 2022-10-24 20:45:52 PDT; 4s ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 5216 (sshd)
      Tasks: 1 (limit: 18997)
     Memory: 2.3M
        CPU: 34ms
     CGroup: /system.slice/sshd.service
             └─ 5216 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"

oct 24 20:45:52 2806-1000-8102-fdca-0000-0000-0000-0005.ipv6.infinitum.net.mx systemd[1]: Starting sshd.service - OpenSSH server daemon...
oct 24 20:45:52 2806-1000-8102-fdca-0000-0000-0000-0005.ipv6.infinitum.net.mx sshd[5216]: Server listening on 0.0.0.0 port 22.
oct 24 20:45:52 2806-1000-8102-fdca-0000-0000-0000-0005.ipv6.infinitum.net.mx sshd[5216]: Server listening on :: port 22.
oct 24 20:45:52 2806-1000-8102-fdca-0000-0000-0000-0005.ipv6.infinitum.net.mx systemd[1]: Started sshd.service - OpenSSH server daemon.

```

Ahora solo me falta averigüar cuál es mi dirección IP, eso se hace con `hostname -I`:

```bash
 hostname -I
192.168.1.76 2806:1000:8102:fdca::5 fd6c:ebb6:7e2e:2a00:3539:4d42:909f:3ba 2806:1000:8102:fdca:5663:d5cf:f771:a446
```

Mi dirección IP es **192.168.1.76**.

Y para entrar : `ssh 192.168.1.76`:

```bash
$ ssh 192.168.1.76
```

## Credits:

Thanks to Getty Images for making [this photo available freely on @unsplash 🎁](https://unsplash.com/photos/rL_xEyhiFWM) 

