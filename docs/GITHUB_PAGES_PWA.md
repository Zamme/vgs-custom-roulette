# Publicar este proyecto en GitHub Pages como PWA

## 1) Configurar GitHub Pages

1. Entra al repositorio en GitHub.
2. Ve a `Settings` > `Pages`.
3. En `Build and deployment`, selecciona `GitHub Actions`.

## 2) Exportar Web desde Godot

1. Abre el proyecto en Godot.
2. Ve a `Project` > `Export`.
3. Selecciona el preset `Web`.
4. Exporta en `build/web/index.html`.

El proyecto ya tiene configurado en `export_presets.cfg`:

- `progressive_web_app/enabled=true`
- `export_path="build/web/index.html"`

## 3) Subir build web

Ejemplo de comandos:

```bash
git add build/web

git commit -m "chore: export web build"

git push
```

Con eso, el workflow `Deploy Godot Web to Pages` publicara la version exportada.

## 4) Validar la PWA

1. Abre la URL de GitHub Pages del repositorio.
2. En navegador Chromium, abre DevTools > Application > Manifest.
3. Verifica que el manifest cargue y que aparezca opcion de instalar la app.

## 5) Flujo recomendado para nuevas versiones

1. Hacer cambios en Godot.
2. Re-exportar a `build/web/index.html`.
3. Commit/push de la carpeta `build/web/`.
4. Esperar finalizacion de Actions y probar en la URL publica.
