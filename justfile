[private]
default:
    @just --list

seite_watch:
    seite serve


tailwind_watch:
    bunx tailwindcss -i static/css/main.css -o static/styles.css --watch --minify --sourcemap

[parallel]
watch: seite_watch tailwind_watch

build:
    bunx tailwindcss -i static/css/main.css -o static/styles.css --minify --minify --sourcemap
    seite build
