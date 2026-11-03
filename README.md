# MisRecetasDev

Experimental helper mod for **Project Zomboid Build 42** that tries to reload recipes and translations while the game is running.

[English](#english) | [Español](#espanol)

Quick links: [Step-by-step guide (ES/EN)](LEEME-IMPORTANTE.txt)

---

## English

### What is MisRecetasDev?

**MisRecetasDev** is a small developer/debug mod for Project Zomboid Build 42. It adds an in-game panel with a button that attempts to reload:

- `craftRecipe` definitions from script files.
- JSON translation files.

It is designed to be used together with another mod called **MisRecetas**, which contains the actual recipes and translations. MisRecetasDev does **not** add recipes, items, or content by itself: it only tries to refresh that data while the game is open.

The idea is to edit a recipe or a translation, save the file, and test the change without restarting Project Zomboid.

Target build: **42.21.0**.

### Current status

**Experimental.** The mod calls the public Java API exposed to Lua:

- `ScriptManager.ReloadScripts(ScriptType.CraftRecipe)`
- `Translator.loadFiles()`

Seeing the panel or clicking the button does **not** prove that the game refreshed its internal caches or the crafting UI. Always verify the result in-game and in `console.txt` (look for lines starting with `[MisRecetasDev]`).

Automatic reload is disabled by default. The optional timer only repeats the same call every N seconds; it does **not** detect file changes or `Ctrl+S`.

### Features

| Feature | Status |
|---|---|
| Reload `craftRecipe` definitions from script files | Experimental |
| Reload JSON translations (`IG_UI.json`, `Recipes.json`, etc.) | Experimental |
| In-game button to run the reload manually | Experimental |
| Log real results and errors to `console.txt` | Experimental |
| Automatic detection of changed files | Planned |

### Requirements

- Project Zomboid on Windows (tested against Build 42.21.0)
- The companion mod **MisRecetas**, if you want to test its recipes and translations
- Visual Studio Code (recommended, optional)
- `-debug` is **not** required for the first tests

### Installation (quick)

1. Copy the `MisRecetasDev` folder to:

   ```text
   C:\Users\<USER>\Zomboid\mods\MisRecetasDev
   ```

2. Make sure `mod.info` is **directly** inside `MisRecetasDev` (no duplicated folder).
3. Enable `MisRecetasDev` in the in-game Mods menu (and `MisRecetas` if you are testing its recipes).
4. Load a **test save** or a backup of your save.
5. Click **RECARGAR RECETAS + JSON** and check the result in `console.txt` and in the crafting menu.

Detailed step-by-step guide (Spanish + English): [`LEEME-IMPORTANTE.txt`](LEEME-IMPORTANTE.txt)

### How to test

1. Keep the game open in a test session.
2. Edit a recipe file of `MisRecetas` (for example, change a `time` value) or a translation JSON.
3. Save the file with `Ctrl+S`.
4. Click the reload button in the MisRecetasDev panel.
5. Open the crafting menu and check whether the change is actually visible and works.
6. Check `console.txt` for `[MisRecetasDev]` lines and any nearby errors.

If the change does not appear, do not assume the reload worked. Report the logs and the exact steps.

### Project structure

```text
MisRecetasDev/
  mod.info
  common/
    mod.info
    media/lua/client/MisRecetasDev/ReloadRecipesUI.lua
  README.md
  LEEME-IMPORTANTE.txt
  CONTRIBUTING.md
```

### Contributing

Open an issue and include:

- Exact Project Zomboid build.
- Steps to reproduce the problem.
- Relevant `console.txt` excerpt (remove private information).
- Whether the change was actually observed in-game.

Pull requests are welcome. Please keep the distinction between "the call did not throw an error" and "the change was actually applied".

### License

No license has been selected yet. Add a `LICENSE` file before inviting others to reuse, modify, or redistribute the code. Only choose a license after confirming that you have the right to license all included files.

---

<a id="espanol"></a>
## Español

### ¿Qué es MisRecetasDev?

**MisRecetasDev** es un mod auxiliar de desarrollo y depuración para **Project Zomboid Build 42**. Añade un panel dentro del juego con un botón que intenta recargar:

- Las definiciones `craftRecipe` de los archivos de scripts.
- Los archivos JSON de traducciones.

Está pensado para usarse junto a otro mod llamado **MisRecetas**, que contiene las recetas y traducciones reales. MisRecetasDev **no** añade recetas, objetos ni contenido por sí mismo: solo intenta refrescar esos datos con el juego abierto.

La idea es editar una receta o una traducción, guardar el archivo y probar el cambio sin reiniciar Project Zomboid.

Versión objetivo: **42.21.0**.

### Estado actual

**Experimental.** El mod llama a la API pública de Java expuesta a Lua:

- `ScriptManager.ReloadScripts(ScriptType.CraftRecipe)`
- `Translator.loadFiles()`

Que aparezca el panel o que el botón se pulse **no** demuestra que el juego haya refrescado sus cachés internas ni la interfaz de fabricación. Comprueba siempre el resultado en el juego y en `console.txt` (busca las líneas que empiezan por `[MisRecetasDev]`).

La recarga automática está desactivada por defecto. El temporizador opcional solo repite la misma llamada cada N segundos; **no** detecta cambios de archivos ni `Ctrl+S`.

### Funciones

| Función | Estado |
|---|---|
| Recargar definiciones `craftRecipe` desde archivos de scripts | Experimental |
| Recargar traducciones JSON (`IG_UI.json`, `Recipes.json`, etc.) | Experimental |
| Botón dentro del juego para lanzar la recarga manualmente | Experimental |
| Registrar resultados y errores reales en `console.txt` | Experimental |
| Detección automática de archivos modificados | Planeado |

### Requisitos

- Project Zomboid en Windows (probado con Build 42.21.0)
- El mod complementario **MisRecetas**, si quieres probar sus recetas y traducciones
- Visual Studio Code (recomendado, opcional)
- **No** es necesario activar `-debug` para las primeras pruebas

### Instalación (resumen)

1. Copia la carpeta `MisRecetasDev` en:

   ```text
   C:\Users\<USUARIO>\Zomboid\mods\MisRecetasDev
   ```

2. Comprueba que `mod.info` esté **directamente** dentro de `MisRecetasDev` (sin carpeta duplicada).
3. Activa `MisRecetasDev` en el menú de Mods del juego (y `MisRecetas` si vas a probar sus recetas).
4. Carga una **partida de prueba** o una copia de seguridad de tu partida.
5. Pulsa **RECARGAR RECETAS + JSON** y comprueba el resultado en `console.txt` y en el menú de fabricación.

Guía detallada paso a paso (español + inglés): [`LEEME-IMPORTANTE.txt`](LEEME-IMPORTANTE.txt)

### Cómo probarlo

1. Mantén el juego abierto en una partida de prueba.
2. Edita un archivo de recetas de `MisRecetas` (por ejemplo, cambia un valor `time`) o un JSON de traducciones.
3. Guarda el archivo con `Ctrl+S`.
4. Pulsa el botón de recarga del panel de MisRecetasDev.
5. Abre el menú de fabricación y comprueba si el cambio se ve realmente y funciona.
6. Revisa `console.txt` por si hay líneas `[MisRecetasDev]` y errores cercanos.

Si el cambio no aparece, no des por hecho que la recarga funcionó. Adjunta los registros y los pasos exactos.

### Estructura del proyecto

```text
MisRecetasDev/
  mod.info
  common/
    mod.info
    media/lua/client/MisRecetasDev/ReloadRecipesUI.lua
  README.md
  LEEME-IMPORTANTE.txt
  CONTRIBUTING.md
```

### Contribuir

Abre un issue e incluye:

- Versión exacta de Project Zomboid.
- Pasos para reproducir el problema.
- Fragmento relevante de `console.txt` (sin información privada).
- Si el cambio se observó realmente dentro del juego.

Se aceptan pull requests. Procura distinguir entre "la llamada no dio error" y "el cambio se aplicó de verdad".

### Licencia

Todavía no se ha seleccionado ninguna licencia. Añade un archivo `LICENSE` antes de invitar a otras personas a reutilizar, modificar o redistribuir el código. Elige una licencia solo después de confirmar que tienes derecho a licenciar todos los archivos incluidos.
