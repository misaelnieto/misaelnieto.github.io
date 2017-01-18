---
title: Instalando Gnome Shell en Natty
layout: post
categories: Linux Gnome
---

Después de instalar Ubuntu Natty en una Dell Latitude D620 con 512 MB de RAM,
noté un poco lento el Unity. La expansión de RAM tardará algunos días en
llegar así que le instalé Gnome Shell y me gustó.

Dicen los chismes que Gnome Shell no estará disponible en los repos oficiales
de Ubuntu hasta que salga Oneric. Unity se ve muy bonito, pero ya había
probado GnomeShell antes y quise probarlo de nuevo

Me quedan 2 opciones: Instalarlo mediante JhBuild o mediante PPAs. Decidí
escoger los PPAs. Y así fue:

```bash
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo apt-get update && sudo apt-get dist-upgrade
```

¡Y eso es todo!

Después de algunos minutos sali de mi sessión y volví a entrar teniendo
cuidado de seleccionar la sesión "Gnome Shell".

Así quedo mi escritorio (Click en la imagen para verla en tamaño completo):

![Gnome Shell en Ubunu Natty](/media/gnome_shell_natty.png)

El gnome shell que se instala con estos PPA's contiene lo mínimo necesario
para ejecutar el entorno. El día de hoy subieron un paquete al PPA con algunos
temas. Pero aunque solo traiga el tema default de GTK, en mi opinión, se
siente mejor que Unity para máquinas con poca RAM.

Podría usar Fedora o Debian, pero Ubuntu no solo es la interfaz gráfica.

*Actualización (3 de Mayo)*

Tuve que instalar el paquete `gnome-shell` a mano para que instalara otras
dependencias, entre ellas, el nuevo tema Adawita. Por si esto no les funciona,
también instalen `gnome-tweak-tool`. Asegurense de reiniciar.

```bash
sudo apt-get install gnome-shell
```

El shell se ve mejor:

![Un pantallazo de GnomeShell en Natty después de activar el tema Adawita](/media/gnome_shell_natty_adawita.png)

