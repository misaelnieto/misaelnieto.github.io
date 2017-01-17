---
title:  "¿Cómo agrandar el disco de una máquina virtual en VirtualBox?"
categories: VirtualBox DevOps
---

![Cambiar tamaño de disco duro en VirtualBox](/media/3219157599_34c9a86f3c_o.jpg)

Aca lo explican en ingles: [How to enlarge a Virtual Machine's Disk - VirtualBox or VMWare](http://www.howtogeek.com/124622/how-to-enlarge-a-virtual-machines-disk-in-virtualbox-or-vmware/).
A diferencia del sitio anterior el hypervisor corre sobre Fedora 20.

Primero hay que apagar la VM. Luego en el VirtualBox manager se puede sacar la
ruta en disco de la VM mediante el menu contextual:

![Para conocer la ruta del archivo de disco duro de la maquna virtual podemos usar VirtualBox Manager](/media/Screenshot_from_2015_01_19_10_08_28.png)

Justo despues de seleccionar la acción `Show in File Manager` se va abrir el administrador de archivos.
En mi caso abre el administrador de archivos de GNOME.

![El administrador de archivos de GNOME abierto en la ruta de la máquina virtual.](/media/Screenshot_from_2015_01_19_09_52_04.png)

El administrador de archivos de GNOME tiene una combinación de teclas para
convertir la barra de ruta en una entrada de texto. La combinación de teclas
es `Ctrl` + `L`. Después copio el texto con `Ctrl` + `C`.

![Truco para copiar la ruta de la máquina virtual](/media/Screenshot_from_2015_01_19_09_52_19.png)

Ya tengo la ruta de la máquina virtual, asi que es momento de pasar a la
consola y entrar a la carpeta de la máquina virtual. Para pegar texto en la
consola uso la combinación de teclas `Ctrl`+`Shift`+`V`. Tambien se puede usar el
menú contextual, el menú editar o hacer click con el botón medio del mouse.

![Consola en el directorio de la VM](/media/Screenshot_from_2015_01_19_10_00_28.png)

El comando resultante en mi caso fue:

```console
cd "/home/nnieto/VirtualBox VMs/Windoge 10"
```

Tuve que encerrar la ruta de la VM entre comillas para que el shell no tome el
espacio como separador de argumentos.

Los archivos de disco de la VM son los que tienen la extensión `.vdi`. Esta
maquina tiene dos discos, y me interesa aumentar el tamaño al disco "`Windoge
10.vdi`". Usaré el comando `vboxmanage` de la siguiente manera:

```console
vboxmanage modifyhd "Windoge 10.vdi" --resize 204800
```

El argumento despues de `modifyhd` es el nombre del archivo del disco duro
virtual. El argumento despues de `--resize` es la cantidad de MB que se le van a
añadir al disco duro.

Ahora es momento de arrancar la máquina virtual y extender la particion del
disco para que ocupe todo el espacio nuevo. El SO del invitado es *Windows 10*,
pero la herramienta `Computer management` (`compmgmt.msc`) existe desde Windows XP
(o tal vez antes) y tiene todo lo que necesitamos para cambiarle el tamaño al
disco duro.

Comenzamos con arrancar la herramienta. En Windows 10, windows 8 y Windows 8.1
sale listada si escribo `compmgmt.msc` en la busqueda del menu inicio.

![Windoge 10 y compmgmt.msc - Solo tuve que hacer click en el iconito.](/media/Screenshot_from_2015_01_19_10_48_56.png)

En versiones anteriores se tiene que usar el dialogo de Run.

Una vez abierta la ventana de Computer Management, entramos a la seccion `Storage-> Disk Management`.

![Windows ya reconoce el nuevo tamaño del disco](/media/Screenshot_from_2015_01_19_10_49_33.png)

Para extender el tamaño de la partición hay que hacer click con el botón
derecho del mouse sobre la partición que quiero agrandar y seleccionar `Extend
Volume ...`

![Click en Extend volume](/media/Screenshot_from_2015_01_19_10_50_12.png)

Cuando le haces click al menu sale un asistente que te lleva por todo el
proceso. Como solo vamos a extender la partición el proceso es bastante
sencillo y solo tenemos que picar *Next* hasta que se acaba el asistente. Los
valores que selecciona el asistente por default son los correctos en mi caso.

![Opciones para cambiar el tamaño del disco](/media/Screenshot_from_2015_01_19_10_50_56.png)

Al finalizar el asistente la partición ya esta usando todo el espacio libre del disco.

![El nuevo tamaño del disco.](/media/Screenshot_from_2015_01_19_10_51_25.png)


Fin.

----
La imagen del disco duro la tome de https://flic.kr/p/5Ut2pe

La foto tiene licencia CC BY 2.0.
