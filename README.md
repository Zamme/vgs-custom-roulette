# vgs-custom-roulette

Ruleta personalizada desarrollada con Godot 4.6, preparada para exportacion Web y publicacion en GitHub Pages como PWA.

## Requisitos

- Godot 4.6
- Una cuenta de GitHub con Pages habilitado en el repositorio
- Branch principal llamada `main`

## Publicar en GitHub Pages (PWA)

1. Sube tus cambios de codigo al repositorio (`git push` a `main`).
2. GitHub Actions exporta automaticamente la version Web del proyecto.
3. El mismo workflow publica el resultado en GitHub Pages.
4. Abre la URL de Pages para probar instalacion como PWA.

Guia detallada: [docs/GITHUB_PAGES_PWA.md](docs/GITHUB_PAGES_PWA.md)

## Notas PWA

- El preset `Web` ya tiene activado `progressive_web_app/enabled=true`.
- Para compatibilidad con GitHub Pages, `progressive_web_app/ensure_cross_origin_isolation_headers=false`.
- Si cambias iconos o nombre de app, el workflow genera una build nueva en el siguiente push.

## Licencia

Este proyecto usa licencia MIT. Ver [LICENSE](LICENSE).
