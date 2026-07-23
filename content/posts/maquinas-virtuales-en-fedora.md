---
title: "Máquinas virtuales en Fedora"
date: "2014-05-12"
summary: "Cómo empecé con KVM en Fedora 20 (resumen rápido)."
description: "Notas breves para activar KVM en Fedora 20 con libvirtd, siguiendo la guía oficial de Fedora en español."
categories:
  - "Linux"
tags:
  - fedora
  - kvm
  - virtualization
  - linux
locale: "es_MX"
keywords: "fedora 20, kvm, virtualizacion, libvirtd, qemu"
extra:
  deprecated: true
  deprecated_reason: "Fedora 20 es EOL; el comando `yum install @virtualization` aún funciona pero `yum` fue reemplazado por `dnf` desde Fedora 22."
---

Generalmente uso VirtualBox para virtualización, pero ahora quise probar KVM.
Fedora tiene una guía en español bastante buena. No añado nada nuevo a la
guía sino que simplemente publico un resumen de los pasos realizados.

```bash
yum install @virtualization
service libvirtd start
```
