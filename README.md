# vgs-custom-roulette

Ruleta personalizada desarrollada con Godot 4.6, preparada para exportacion Web y publicacion en GitHub Pages como PWA.

## Requisitos

- Godot 4.6
- Una cuenta de GitHub con Pages habilitado en el repositorio

## Publicar en GitHub Pages (PWA)

1. Exporta el proyecto en Godot usando el preset `Web`.
2. Verifica que el resultado quede en `build/web/` (incluyendo `index.html`).
3. Haz commit y push de la carpeta `build/web/`.
4. El workflow de GitHub Actions desplegara automaticamente en GitHub Pages.

Guia detallada: [docs/GITHUB_PAGES_PWA.md](docs/GITHUB_PAGES_PWA.md)

## Notas PWA

- El preset `Web` ya tiene activado `progressive_web_app/enabled=true`.
- Si cambias iconos o nombre de app, vuelve a exportar para regenerar los archivos web.

## Licencia

Este proyecto usa licencia MIT. Ver [LICENSE](LICENSE).
