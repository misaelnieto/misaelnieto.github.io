---
title: " Maquinas virtuales en Fedora "
date: "2014-05-12"
categories:
  - "Linux Fedora"
tags:
  - fedora
  - kvm
  - virtualization
  - linux
---

Generalmente uso VirtualBox para virtualización, pero ahora
quise probar KVM. Fedora tiene una guia en español bastante buena. No añado
nada nuevo a la guia sino que simplemente publico un resumen de los pasos
realizados.

```bash
yum install @virtualization service libvirtd start
````
