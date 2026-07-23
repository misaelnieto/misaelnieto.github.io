---
title: "Instalando GNOME Shell en Natty"
date: "2011-04-30"
summary: "GNOME Shell vía PPA en Ubuntu Natty, como alternativa liviana a Unity en una Latitude D620 con 512 MB de RAM."
description: "Pasos para instalar GNOME Shell en Ubuntu Natty usando PPAs, alternativa a Unity para equipos con poca RAM."
categories:
  - "Linux"
tags:
  - ubuntu
  - gnome-shell
  - gnome3
  - unity
locale: "es_MX"
keywords: "ubuntu natty, gnome shell, gnome3, ppa, unity, latitude d620"
extra:
  deprecated: true
  deprecated_reason: "Ubuntu 11.04 Natty Narwhal es EOL; GNOME Shell viene preinstalado en distros Linux modernas"
---

Después de instalar Ubuntu Natty en una Dell Latitude D620 con 512 MB de RAM,
noté un poco lento el Unity. La expansión de RAM tardará algunos días en
llegar, así que le instalé GNOME Shell y me gustó.

Dicen los chismes que GNOME Shell no estará disponible en los repos oficiales
de Ubuntu hasta que salga Oneric. Unity se ve muy bonito, pero ya había
probado GNOME Shell antes y quise probarlo de nuevo.

Me quedan 2 opciones: instalarlo mediante JHBuild o mediante PPAs. Decidí
escoger los PPAs. Y así fue:

```bash
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo apt-get update && sudo apt-get dist-upgrade
```

¡Y eso es todo!

Después de algunos minutos salí de mi sesión y volví a entrar teniendo
cuidado de seleccionar la sesión "GNOME Shell".

Así quedó mi escritorio (click en la imagen para verla en tamaño completo):

![GNOME Shell en Ubuntu Natty](/static/images/posts/instalando-gnome-shell-en-natty/gnome-shell-natty.png)

El GNOME Shell que se instala con estos PPAs contiene lo mínimo necesario para
ejecutar el entorno. El día de hoy subieron un paquete al PPA con algunos
temas. Pero aunque solo traiga el tema default de GTK, en mi opinión, se siente
mejor que Unity para máquinas con poca RAM.

Podría usar Fedora o Debian, pero Ubuntu no solo es la interfaz gráfica.

*Actualización (3 de mayo).*

Tuve que instalar el paquete `gnome-shell` a mano para que instalara otras
dependencias, entre ellas, el nuevo tema Adwaita. Por si esto no les funciona,
también instalen `gnome-tweak-tool`. Asegúrense de reiniciar.

```bash
sudo apt-get install gnome-shell
```

El shell se ve mejor:

![Un pantallazo de GNOME Shell en Natty después de activar el tema Adwaita](/static/images/posts/instalando-gnome-shell-en-natty/gnome-shell-natty-adawita.png)
