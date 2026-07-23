[private]
default:
    @just --list

seite_watch:
    seite serve --host localhost --port 4000

tailwind_cli := "bunx @tailwindcss/cli --minify --sourcemap -i static/css/main.css -o static/styles.css"

tailwind_watch:
    {{ tailwind_cli }}  --watch

[parallel]
watch: seite_watch tailwind_watch

build:
    {{ tailwind_cli }}
    seite build
