---
title: "Añadir un nuevo disco a Fedora con LVM"
summary: "Cómo añadir un nuevo disco físico a un servidor Fedora con LVM, extender el volumen lógico y el filesystem."
description: "Tutorial paso a paso para añadir un nuevo disco a un servidor Fedora con LVM: pvcreate, vgextend, lvextend y resize2fs para extender el filesystem online sin desmontar."
date: "2017-08-11"
categories:
  - "Tutoriales"
  - "Linux"
tags:
  - fedora
  - lvm
  - storage
  - pvcreate
  - vgextend
  - resize2fs
locale: "es_MX"
keywords: "Fedora, LVM, pvcreate, vgextend, lvextend, resize2fs, storage, add disk, sysadmin"
image: "/static/images/posts/anadir-nuevo-disco-fedora-lvm/ubuntu-linux-kernel-panic-by-jpangamarca.png"
---

![Ubuntu linux kernel panic](/static/images/posts/anadir-nuevo-disco-fedora-lvm/ubuntu-linux-kernel-panic-by-jpangamarca.png)

Ayer en la tarde comencé a escribir el artículo *[Cómo agrandar el disco de
una máquina virtual en
VirtualBox](/blog/agrandar-disco-de-una-maquina-virtual-en-VirtualBox)*. La
redacción de ese artículo fue más larga de lo que yo esperaba y el resultado no
me dejó muy satisfecho. Es por esa razón que acabo de redactar este segundo
artículo. Es un caso distinto: aquí tengo un servidor Fedora de carne y hueso,
no una VM, y una necesidad distinta: no tengo un disco existente que se
quiera hacer más grande; tengo un disco nuevo que quiero añadir al sistema.

## Intro

El servidor que tengo entre manos es un servidor físico sin administración
remota IPMI. En este momento estoy en la parte más aburrida del proceso:
esperar a que el sistema se reinicie luego de activar la opción *Fast Boot* en
la BIOS. Por lo menos debo aprovechar y redactar este artículo.

El servidor físico es un servidor [Micro
Core](http://www.ei-services.com.mx/equipos-y-sistemas/servidores/micro-core)
de la marca de [iServices](http://www.ei-services.com.mx) (la empresa donde
laboro). Es un equipo relativamente pequeño: del tamaño de un par de cajas de
zapatos. Adentro de este equipo cabe solamente un disco duro de 3.5". Para
hacer crecer su capacidad de almacenamiento es necesario conectar un disco
extra al puerto SATA. Para poder apagar y abrir y poner el disco me tuve que
cambiar al cuarto de servidores, desconectar el equipo, abrirlo y ponerle el
disco extra.

Previamente me aseguré de hacer un respaldo de todo lo importante por si la
libre. El respaldo lo hice con [rsync](https://rsync.samba.org/) sobre una red
privada.

```
$ sudo rsync -aAXv --progress --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / /path/to/backup/folder
```

El comando lo saqué de las [preguntas más frecuentes de
rsync](https://wiki.archlinux.org/index.php/Rsync#Full_system_backup).

## Conectando el disco y revisando el estado inicial

He conectado el disco extra. Prendí el servidor. He entrado por SSH. ¿Qué se
hace después?

Antes de empezar a tocar cosas, conviene ver el estado de LVM. Conviene ver
todos los volúmenes físicos (*Physical Volumes* o `pvdisplay`), grupos de
volúmenes (*Volume Groups* o `vgdisplay`), y volúmenes lógicos (*Logical
Volumes* o `lvdisplay`). Estos comandos y muchos más son parte de los
[comandos de administración de
LVM](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/LVM_commands.html).

Si ejecuto `pvdisplay` para ver los volúmenes físicos conectados actualmente:

```
$ sudo pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda2
  VG Name               fedora
  PV Size               148.60 GiB / not usable 3.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              38041
  Free PE               0
  Allocated PE          38041
  PV UUID               hhE0AY-zhJ8-3eRv-f3jB-iyX6-1mVz-Yz0sz1
```

Aquí se puede observar que solo hay un volumen físico. Su nombre es
`/dev/sda2`, que es un nombre que el sistema operativo le asignó a la segunda
partición del primer disco. Es decir, sda es un disco y sda2 es la segunda
partición del disco sda. Conviene mostrar el estado de los grupos de
volúmenes:

```
$ sudo vgdisplay
  --- Volume group ---
  VG Name               fedora
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  3
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               148.60 GiB
  PE Size               4.00 MiB
  Total PE              38041
  Alloc PE / Size       38041 / 148.60 GiB
  Free  PE / Size       0 / 0
  VG UUID               IRUp2k-zm2M-cGFJ-zedG-o6Dr-JSKF-OMd7Qv
```

Lo que importa saber es que solo existe un grupo de volúmenes llamado
`fedora`. Hay dos volúmenes lógicos en este grupo (`Cur LV 2`).

```
$ sudo lvdisplay
  --- Logical volume ---
  LV Path                /dev/fedora/swap
  LV Name                swap
  VG Name                fedora
  LV UUID                kSGg7L-gvgs-Qqec-f9RS-jCah-0wRH-5b7BQ9
  LV Write Access        read/write
  LV Creation host, time localhost-live, 2016-04-01 15:11:46 -0600
  LV Status              available
  # open                 2
  LV Size                7.55 GiB
  Current LE             1933
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0

  --- Logical volume ---
  LV Path                /dev/fedora/root
  LV Name                root
  VG Name                fedora
  LV UUID                Mw4Yo4-b1FR-sOIj-RrJr-0Xba-BtCs-zkKUMb
  LV Write Access        read/write
  LV Creation host, time localhost-live, 2016-04-01 15:11:46 -0600
  LV Status              available
  # open                 1
  LV Size                141.05 GiB
  Current LE             36108
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:1
```

Y efectivamente, hay dos volúmenes lógicos. El primero se llama `/swap` y el
segundo `/root`.

Ahora el disco que añadiré:

```
$ lsblk --fs
NAME            FSTYPE      LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINT
sda
├─sda1          vfat              AC4D-D67E                               579.4M    42% /boot/efi
└─sda2          LVM2_member       hhE0AY-zhJ8-3eRv-f3jB-iyX6-1mVz-Yz0sz1
  ├─fedora-swap swap              ecf8a04a-1ed7-4da8-9a89-1ecdb3b91eae                [SWAP]
  └─fedora-root ext4              14d4136d-3ffb-4daa-9395-cf6524d2cdaf    107.9G    17% /
sdb
└─sdb1          LVM2_member       v1xGcu-XwHt-fRBh-A4tk-7ALW-7m1w-3KXDX2
```

¡Oh yeah! El disco se detectó automáticamente. Esta herramienta es muy útil
porque se puede ver un diagrama de los discos, las particiones, el sistema de
archivos, etc.

Antes de añadirlo al grupo de volúmenes `fedora`, hay que formatear el disco
con un sistema de archivos compatible con LVM. Si no recuerdo mal (tengo que
revisar mi notas) es LVM2_member. En las distros de Fedora/Red Hat existe una
herramienta llamada `lvmdiskscan` que nos ayuda a encontrar discos con formato
LVM2_member. La herramienta reportó `/dev/sdb1`:

```
$ sudo lvmdiskscan
  /dev/fedora/swap [       7.55 GiB]
  /dev/sda1       [     500.00 MiB]
  /dev/fedora/root [     141.05 GiB]
  /dev/sda2       [     148.60 GiB] LVM physical volume
  /dev/sdb1       [      <2.00 TiB] LVM physical volume
  2 disks
  2 partitions
  0 LVM physical volume whole disks
  1 LVM physical volume
```

Interesante. La partición `/dev/sdb1` ya estaba formateada previamente con
LVM2_member. Esto se debe a que este disco venía de otro servidor, donde ya
estaba siendo usado con LVM.

## Extender el VG y el LV

Bien, ya tengo el volumen físico detectado. Es momento de extender el grupo de
volúmenes `fedora`. Para extender se usa la herramienta `vgextend`:

```
$ sudo vgextend fedora /dev/sdb1
  Volume group "fedora" successfully extended
```

Con esto, el grupo de volúmenes `fedora` ya abarca los dos discos físicos.

Pero no acaba ahí la cosa. El volumen lógico `/dev/fedora/root` sigue con su
tamaño original de 141 GB. Y el sistema de archivos `/` sigue creyendo que
solo tiene ese espacio. Faltan un par de pasos.

Veamos el espacio libre que tiene el grupo de volúmenes `fedora`:

```
$ sudo vgdisplay fedora | grep "Free"
  Free  PE / Size       511921 / <1.95 TiB
```

Casi 2 TiB libres. Los pasos para extender el volumen lógico `/dev/fedora/root`
y el sistema de archivos `/` se pueden hacer en un solo comando
(`--resizefs`):

```
$ sudo lvextend --resizefs -l +100%FREE /dev/fedora/root
  Size of logical volume fedora/root changed from 141.05 GiB (36108 extents) to 2.08 TiB (548029 extents).
  Logical volume fedora/root successfully resized.
meta-data=/dev/mapper/fedora-root isize=256    agcount=27, agsize=1086208 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=0        finobt=0 spinodes=0 rmapbt=0
         =                       reflink=0
data     =                       bsize=4096   blocks=29336576, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=6391, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 29336576 to 2291482624
```

`+100%FREE` quiere decir: «toma todo el espacio libre que encuentres en el VG y
añádelo al volumen lógico». `--resizefs` indica que se debe redimensionar el
filesystem `/` para que tome todo el nuevo espacio asignado.

Verificamos con `df -h`:

```
$ df -h /
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/fedora-root  2.1T  118G  1.9T   7% /
```

¡Listo!

## Si el disco NO estaba formateado con LVM2

Si el disco nunca se hubiera utilizado con LVM previamente, entonces
`lvmdiskscan` no lo reportaría. En ese caso habría que prepararlo manualmente.
La herramienta para ello es `pvcreate`:

```
$ sudo pvcreate /dev/sdb1
  Physical volume "/dev/sdb1" successfully created.
```

Y a partir de ahí se siguen los pasos de `vgextend` y `lvextend`.

## Notas finales

- A lo largo de este artículo asumí que el disco ya tiene una tabla de
  particiones y al menos una partición. Si el disco es nuevo y viene de fábrica
  habrá que particionarlo antes. Para eso conviene usar `fdisk`, `cfdisk` o
  `parted` y crear una partición que ocupe todo el disco.
- El comando `lvextend --resizefs` nos ahorra un paso extra. Sin él habría que
  usar `resize2fs` (en filesystems ext2/ext3/ext4) o `xfs_growfs` (en XFS)
  después de extender el LV.

**FIN**

---

Créditos de la imagen de portada: [Taringa / jpangamarca](https://upload.wikimedia.org/wikipedia/commons/c/c9/Tux_kernel_panic.jpg)
