---
published: true
---
## Guía rápida de instalación de PostgreSQL 10 en Fedora 28

Como `root`:

```bash
dnf install -y postgresql-server postgresql-devel
```
Como usuario psql (`su psql`)

```bash
postgresql-setup --initdb
```

Como superusuario en el cmdline de postgres:
```postgresql
CREATE USER root WITH SUPERUSER;
CREATE USER nnieto WITH SUPERUSER;
CREATE DATABASE root;
CREATE DATABASE nnieto;
```

psql
createdb root
createdb nnieto
