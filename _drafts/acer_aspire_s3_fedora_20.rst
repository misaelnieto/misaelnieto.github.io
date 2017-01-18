Notas instalación de Fedora 20 en Acer Aspire S3 
================================================

.. author:: default
.. categories:: fedora, español
.. tags:: Fedora 20, instalación, acer aspire
.. comments::


Instalación Inicial
-------------------

Todo tranquilo. Instalo 


Activar ACPI
------------

Para que jale el sleep mode y el ajuste de brillo.

editar /etc/default.grub

cambiar esta linea:

    GRUB_CMDLINE_LINUX="rd.lvm.lv=vg_hormigagris/lv_swap vconsole.font=latarcyrheb-sun16 rd.lvm.lv=vg_hormigagris/lv_root $([ -x /usr/sbin/rhcrashkernel-param ] && /usr/sbin/rhcrashkernel-param || :) rhgb quiet"

Por esta:

GRUB_CMDLINE_LINUX="rd.lvm.lv=vg_hormigagris/lv_swap vconsole.font=latarcyrheb-sun16 rd.lvm.lv=vg_hormigagris/lv_root $([ -x /usr/sbin/rhcrashkernel-param ] && /usr/sbin/rhcrashkernel-param || :) rhgb quiet acpi_osi=Linux acpi_backlight=vendor"

Sólo le añadi esto:

    acpi_osi=Linux acpi_backlight=vendor pcie_aspm=force i915.semaphores=1 elevator=noop


 For your information,

    “acpi_osi=Linux” indicates that you are running Linux so the hardware behaves acordingly if it has been programed to.
    “acpi_backlight=vendor” gives the priority to the acer_acpi module over the stock acpi. The stock acpi doesn't know how to manage brightness


Fedora no trae el programa update-grub. Hay que correr el siguiente comando como root (o con sudo):

    grub2-mkconfig -o /boot/grub2/grub.cfg


Despues de reiniciar, powertop reporta que el consumo de potencia oscila entre 10.3 y 13 Watts

    System baseline power is estimated at 11.9 W
    System baseline power is estimated at 13.9 W
    System baseline power is estimated at 11.9 W

Reporte de tuneables de powertop

    >> Bad           VM writeback timeout                                                                                   
       Bad           Enable SATA link power Managmenet for host0
       Bad           Enable SATA link power Managmenet for host1
       Bad           Enable SATA link power Managmenet for host2
       Bad           Enable SATA link power Managmenet for host3
       Bad           Enable SATA link power Managmenet for host4
       Bad           Enable SATA link power Managmenet for host5
       Bad           Enable Audio codec power management
       Bad           NMI watchdog should be turned off
       Bad           Autosuspend for USB device USB2.0-CRW [Generic]
       Bad           Runtime PM for PCI Device Intel Corporation UM67 Express Chipset Family LPC Controller
       Bad           Runtime PM for PCI Device Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller
       Bad           Runtime PM for PCI Device Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1
       Bad           Runtime PM for PCI Device Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2
       Bad           Runtime PM for PCI Device Qualcomm Atheros AR9485 Wireless Network Adapter
       Bad           Runtime PM for PCI Device Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller
       Bad           Runtime PM for PCI Device Intel Corporation 6 Series/C200 Series Chipset Family 6 port SATA AHCI Controller
       Bad           Runtime PM for PCI Device Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1
       Bad           Runtime PM for PCI Device Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 6
       Bad           Runtime PM for PCI Device Intel Corporation 2nd Generation Core Processor Family DRAM Controller
       Bad           Runtime PM for PCI Device Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller
       Bad           Runtime PM for PCI Device Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 1
       Good          Autosuspend for USB device 1.3M HD WebCam [C8B910179]
       Good          Autosuspend for USB device EHCI Host Controller [usb1]
       Good          Autosuspend for USB device EHCI Host Controller [usb2]
       Good          Autosuspend for unknown USB device 1-1 (8087:0024)
       Good          Autosuspend for unknown USB device 2-1 (8087:0024)
       Good          Wake-on-lan status for device virbr0-nic
       Good          Wake-on-lan status for device virbr0
       Good          Wake-on-lan status for device wlp2s0
       Good          Using 'ondemand' cpufreq governor


Enable SATA link power Managmenet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La documentación de Fedora acerca de este tuneable esta `en este link <https://docs.fedoraproject.org/en-US/Fedora/20/html/Power_Management_Guide/ALPM.html>`_ .

No se por qué ALPM no se activa por default en esta laptop. La documentación
dice que ALPM tiene tres niveles:


+ ``min_power``: Usar la menor cantidad de energía consumida cuando el disco
  no tiene tráfico de entrada/salida (E/S). Este modo es útil cuando la laptop se
  deja inatendida por mucho tiempo.

+ ``medium_power``: El límite de energía consumida cuando el disco no tiene
  tráfico de E/S es un poco más alto.  También funciona como punto intermedio
  entre ``min_power`` y ``max_power``.

 + ``max_performance``: ALPM está deshabilitado por completo y no hay ningún
   ahorro de energía cuando cesa el tráfico de E/S.

Nota: cuando se selecciona ``medium_power`` o ``min_power`` tambien se
deshabilita el hotplug y las USB dejan de fincionar.


Se habilita asi:

echo "1" > /sys/class/scsi_host/host[0,1,2,3,4,5]/link_power_management_policy

Referencias y links
-------------------

http://www.linlap.com/acer_aspire_s3
http://askubuntu.com/questions/75219/screen-brightness-not-adjustable-for-acer-aspire-s3


