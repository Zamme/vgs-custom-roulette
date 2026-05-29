# Publicar este proyecto en GitHub Pages como PWA

## 1) Configurar GitHub Pages

1. Entra al repositorio en GitHub.
2. Ve a `Settings` > `Pages`.
3. En `Build and deployment`, selecciona `GitHub Actions`.

## 2) Flujo automatico de build y deploy

El workflow `.github/workflows/deploy-pages.yml` hace lo siguiente en cada push a `main`:

1. Descarga Godot 4.6 y sus export templates.
2. Exporta el preset `Web` a `build/web/index.html`.
3. Publica `build/web` en GitHub Pages.

No necesitas commitear `build/web`.

## 3) Export preset en Godot

1. Abre el proyecto en Godot.
2. Ve a `Project` > `Export`.
3. Selecciona el preset `Web`.
4. Verifica que el preset exista y que PWA este habilitado.

El proyecto ya tiene configurado en `export_presets.cfg`:

- `progressive_web_app/enabled=true`
- `export_path="build/web/index.html"`
- `progressive_web_app/ensure_cross_origin_isolation_headers=false` (recomendado para GitHub Pages)

## 4) Publicar una nueva version

Ejemplo de comandos:

```bash
git add .

git commit -m "feat: update roulette"

git push
```

Con eso, el workflow `Deploy Godot Web to Pages` exporta y publica automaticamente.

## 5) Validar la PWA

1. Abre la URL de GitHub Pages del repositorio.
2. En navegador Chromium, abre DevTools > Application > Manifest.
3. Verifica que el manifest cargue y que aparezca opcion de instalar la app.

## 6) Si falla la exportacion en CI

1. Revisa el log del job `Download Godot editor and export templates`.
2. Verifica que la version en `GODOT_VERSION` del workflow exista en `godotengine/godot-builds`.
3. Si migras de version de Godot, actualiza tambien el preset Web desde el editor.
