---
published: false
---
## Añadir un nuevo disco a fedora con LVM

**Nota:** Este post lo redacte en 2014, pero lo estoy publicando en 2017. Ya no tengo acceso al hardware mencionado en este articulo.

## Intro

Configuré un servidor ftp en una máquina virtual(VM) de VMWare. Como era sólo
una prueba, hice el disco principal de 10GB. Pero las pruebas funcionaron y
ahora el servidor se tiene que poner en modo producción. Obviamente, con 8 GB
no va a funcionar para mucho. _Necesito más espacio en disco duro_.

En mi primera prueba, incrementé el tamaño del disco desde el _VSphere Web
Center_. Reinicié la VM y fdisk ya reportaba el nuevo tamaño del disco. Usé
`cfdisk` para añadir una partición primaria, reinicié y ¡BAM! El Linux ya no
reinició. Así que preferí añadir un disco en lugar de cambiarle el tamaño al
disco principal.

Normalmente lo que hago es añadir el disco, formatearlo y montarlo en algún
directorio. Pero esta vez quise saber cómo se hace con LVM, por que no se
mucho de eso.

Antes de añadir el nuevo disco duro, corrí `lvscan` para saber qué salía:

```bash
[root@ubunto ]# lvscan
ACTIVE            '/dev/Ubuntu/root' [8.76 GiB] inherit
ACTIVE            '/dev/Ubuntu/swap_1' [1.00 GiB] inherit
```

Después `fdisk -l /dev/[sh]d?` reportó esto:

```bash
[root@ubunto ]# fdisk -l /dev/[sh]d?

Disk /dev/sda: 10.7 GB, 10737418240 bytes
255 heads, 63 sectors/track, 1305 cylinders, total 20971520 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00067a08

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048      499711      248832   83  Linux
/dev/sda2          501758    20969471    10233857    5  Extended
/dev/sda5          501760    20969471    10233856   8e  Linux LVM
```

Añadí un disco de 128 GB desde el _VCenter_. Después de reiniciar la máquina
virtual, `fdisk -l /dev/[sh]d?` reporta lo mismo de arriba, pero con este
extra:

```bash
[root@ubunto ]# fdisk -l /dev/[sh]d?

Disk /dev/sdb: 137.4 GB, 137438953472 bytes
255 heads, 63 sectors/track, 16709 cylinders, total 268435456 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/sdb doesn't contain a valid partition table
```

La última línea me dice que el disco nuevo no tiene tabla de particiones.
Entonces lo arreglé con `cfdisk`.

Despues de escribir los cambios a la tabla de partición del disco `sdb` pude
verificar que `fdisk -l /dev/[sh]d?` ya reporta el tamaño y tipo de la
partición `/dev/sdb`:

```bash
[root@ubunto ]# fdisk -l /dev/[sh]d?

Disk /dev/sda: 10.7 GB, 10737418240 bytes
255 heads, 63 sectors/track, 1305 cylinders, total 20971520 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00067a08

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048      499711      248832   83  Linux
/dev/sda2          501758    20969471    10233857    5  Extended
/dev/sda5          501760    20969471    10233856   8e  Linux LVM

Disk /dev/sdb: 137.4 GB, 137438953472 bytes
255 heads, 63 sectors/track, 16709 cylinders, total 268435456 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1              63   268435455   134217696+  8e  Linux LVM
```
Ahora, hasta donde se, todo este asunto se trata de **extender** el espacio en
disco. Es decir, que en lugar de que el reporte del tamaño total de la raiz
sea de 8.7GB, con LVM lo haga crecer hasta 128 GB. Esto es muy diferente que
montar un disco en `/mnt/disco` y meter archivos ahi.

El reporte de `df -h /` es:

```bash
[root@ubunto ]# df -h /

Filesystem                   Size  Used Avail Use% Mounted on
    /dev/mapper/UbuntuBase-root  8.7G  7.1G  1.2G  87% /
```

Y el reporte de `pvdisplay` es:

```bash
[root@ubunto ]# pvdisplay

  --- Physical volume ---
  PV Name               /dev/sda5
  VG Name               UbuntuBase
  PV Size               9.76 GiB / not usable 2.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              2498
  Free PE               0
  Allocated PE          2498
  PV UUID               aXv2v3-9ONb-Rpg2-xxxx-v0C4-RXt7-baxgH1
```

Antes de integrar el nuevo disco duro con LVM, necesito formatear
`/dev/sdb1` con formato ext4.

```bash
[root@ubunto ]# mkfs -t ext4 /dev/sdb1

mke2fs 1.42 (29-Nov-2011)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
8388608 inodes, 33554424 blocks
1677721 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=4294967296
1024 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
    32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
    4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done
```

Ahora es momento de inicializar `/dev/sdb1` para que la partición pueda ser
usada por LVM.

```bash
[root@ubunto ]# pvcreate /dev/sdb1
   Physical volume "/dev/sdb1" successfully created
```

Ahora `pvdisplay` reconoce a `/dev/sb1` como parte de LVM:

```
[root@ubunto ]# pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda5
  VG Name               UbuntuBase
  PV Size               9.76 GiB / not usable 2.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              2498
  Free PE               0
  Allocated PE          2498
  PV UUID               aXvGvo-9ONb-Rpg2-lzMV-v0C4-RXt7-baxgH1

  "/dev/sdb1" is a new physical volume of "128.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdb1
  VG Name
  PV Size               128.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               33jUpG-wxEh-lLt0-nHkk-NGRo-6AXK-u1NJmR
```

Cuando Ubuntu se instaló, el instalador creó un grupo de volúmenes con el
nombre _UbuntuBase_. Eso lo confirmé con `vgdisplay` y `vgscan`:

```
Reading all physical volumes.  This may take a while...
Found volume group "UbuntuBase" using metadata type lvm2

```

Entonces, sólo voy a extender el grupo de volúmenes que ya esta creado
(UbuntuBase). Esto se hace con `vgextend`.

```bash
[root@ubunto ]# vgextend UbuntuBase /dev/sdb1
  Volume group "UbuntuBase" successfully extended
```

Después de esto, los reportes de `pvdisplay` y `vgdisplay` y  han cambiado.

```bash
[root@ubunto ]# vgdisplay
      --- Volume group ---
      VG Name               UbuntuBase
      System ID
      Format                lvm2
      Metadata Areas        2
      Metadata Sequence No  4
      VG Access             read/write
      VG Status             resizable
      MAX LV                0
      Cur LV                2
      Open LV               2
      Max PV                0
      Cur PV                2
      Act PV                2
      VG Size               137.75 GiB
      PE Size               4.00 MiB
      Total PE              35265
      Alloc PE / Size       2498 / 9.76 GiB
      Free  PE / Size       32767 / 128.00 GiB
      VG UUID               tsVsG7-ljlp-JZiT-Avs6-qhVN-xSKh-r1iRVx

[root@ubunto ]# pvdisplay
      --- Physical volume ---
      PV Name               /dev/sda5
      VG Name               UbuntuBase
      PV Size               9.76 GiB / not usable 2.00 MiB
      Allocatable           yes (but full)
      PE Size               4.00 MiB
      Total PE              2498
      Free PE               0
      Allocated PE          2498
      PV UUID               aXvGvo-9ONb-Rpg2-lzMV-v0C4-RXt7-baxgH1

      --- Physical volume ---
      PV Name               /dev/sdb1
      VG Name               UbuntuBase
      PV Size               128.00 GiB / not usable 3.97 MiB
      Allocatable           yes
      PE Size               4.00 MiB
      Total PE              32767
      Free PE               32767
      Allocated PE          0
      PV UUID               jpvShV-PG4d-yEUI-OMEF-fvme-xqew-xPMtZL

[root@ubunto ]# lvextend -L+127G /dev/UbuntuBase/root
  Extending logical volume root to 136.76 GiB
  Insufficient free space: 32768 extents needed, but only 32767 available

```

Pero df no ha cambiado :(

```bash
[root@ubunto ]# df -h /
Filesystem                   Size  Used Avail Use% Mounted on
/dev/mapper/UbuntuBase-root  8.7G  7.1G  1.2G  87% /
```

Necesito reiniciar en modo rescate? NO! Se puiede hacer al vuelo:

```bash
[root@ubunto ]# resize2fs /dev/UbuntuBase/root
resize2fs 1.42 (29-Nov-2011)
Filesystem at /dev/UbuntuBase/root is mounted on /; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 9
The filesystem on /dev/UbuntuBase/root is now 35588096 blocks long.

```

Oh yeah!

```bash
[root@ubunto ]# df -h
Filesystem                   Size  Used Avail Use% Mounted on
/dev/mapper/UbuntuBase-root  134G  7.1G  122G   6% /
udev                         111M  4.0K  111M   1% /dev
tmpfs                         48M  472K   48M   1% /run
none                          50M     0   50M   0% /run/lock
none                         120M     0  120M   0% /run/shm
/dev/sda1                    228M  102M  114M  48% /boot
```

## Ligas de donde saque la informacion

* [http://www.tldp.org/HOWTO/LVM-HOWTO/extendlv.html
* http://forums.fedoraforum.org/showthread.php?t=154625
* http://www.howtoforge.com/linux_lvm

FIN