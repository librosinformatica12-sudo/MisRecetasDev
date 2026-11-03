## 📖 ¿Qué es MisRecetasDev?

**MisRecetasDev** es un mod auxiliar experimental para desarrollar y probar recetas de **Project Zomboid** **sin cerrar el juego** cada vez que modificas un archivo.

Está pensado para trabajar junto a otro mod llamado `MisRecetas`, que contiene tus recetas y traducciones.

### ✨ Qué investiga

| | Función | Estado |
|---|---|---|
| 📜 | Recargar recetas `craftRecipe` desde archivos `.txt` | 🧪 Experimental |
| 🌐 | Recargar traducciones JSON (`IG_UI.json`, `Recipes.json`) | 🧪 Experimental |
| 🖱️ | Botón dentro del juego para lanzar las pruebas a mano | 🧪 Experimental |
| 🪵 | Registrar resultados y errores reales para depurar | 🧪 Experimental |
| 👀 | Detectar cambios guardados desde VS Code y recargar solo | 🔜 Planeado |

> [!WARNING]
> El proyecto es **experimental**. Que el panel o el botón aparezca **no** demuestra que las recetas o traducciones se hayan recargado. Cada función debe verificarse en el juego y en `console.txt`. No se garantiza compatibilidad con todas las versiones de Project Zomboid.

---

## 🎯 Objetivos

1. Investigar el acceso desde Lua a `ScriptManager`, `ScriptType.CraftRecipe` y `ReloadScripts()`.
2. Comprobar si las recetas nuevas y las modificaciones de recetas existentes aparecen en una partida activa.
3. Investigar si es posible volver a cargar las traducciones JSON sin reiniciar.
4. Registrar errores y resultados reales, sin mostrar un éxito falso.
5. Añadir detección automática de cambios **solo después** de validar la recarga manual.

---

## 📋 Requisitos

- 🪟 Project Zomboid para Windows
- 🎮 La versión del juego usada en las pruebas (actualmente el objetivo es **Build 42.21.0**)
- 📦 El mod original `MisRecetas`, si quieres probar sus recetas
- 🧩 El prototipo de `MisRecetasDev`
- 💻 Visual Studio Code (recomendable)
- 🐞 **No** es necesario activar `-debug` para las pruebas iniciales

---

## 🚀 Instalación local

1. Descarga o extrae la carpeta completa del mod `MisRecetasDev`.
2. Cópiala a:

   ```text
   C:\Users\<USUARIO>\Zomboid\mods\MisRecetasDev
   ```

3. Comprueba que `mod.info` está **directamente** dentro de `MisRecetasDev` (sin carpeta duplicada).
4. Inicia Project Zomboid.
5. Activa `MisRecetasDev` en el menú de mods (y `MisRecetas` si vas a probar sus recetas).
6. Entra en una partida de prueba. Es recomendable usar una **copia** de tu partida habitual.
7. Comprueba si aparece el panel del mod.
8. Si aparece el botón, púlsalo y comprueba el **resultado real en el juego** antes de concluir que la recarga funciona.

---

## 🧪 Pruebas

<details>
<summary><b>📜 Cómo probar las recetas</b></summary>

<br>

1. Mantén el juego abierto en una partida de prueba.
2. Haz una copia de seguridad del archivo de recetas que vas a editar.
3. Abre la carpeta de scripts de `MisRecetas`, normalmente:

   ```text
   MisRecetas\common\media\scripts\
   ```

4. Añade una receta de prueba con un nombre fácil de reconocer o modifica una receta de prueba existente.
5. Guarda el archivo con `Ctrl + S`.
6. Vuelve al juego y pulsa el botón de recarga.
7. Abre el menú de fabricación y comprueba si la receta nueva o modificada aparece y funciona.
8. Si no aparece, **no asumas que la recarga se ha realizado**: consulta los registros.

</details>

<details>
<summary><b>🌐 Cómo probar las traducciones</b></summary>

<br>

1. Haz una copia del JSON que vas a cambiar.
2. Abre el archivo correspondiente dentro de `Translate`, por ejemplo `IG_UI.json` o `Recipes.json`.
3. Cambia temporalmente el texto de una entrada de prueba, manteniendo un JSON válido.
4. Guarda con `Ctrl + S`.
5. Pulsa el botón de recarga de traducciones (si está disponible en la versión instalada).
6. Comprueba el texto en el juego. Un texto ya mostrado en pantalla puede no actualizarse hasta que vuelvas a abrir la interfaz.
7. Restaura el texto original cuando termines.

</details>

---

## 🔍 Diagnóstico de errores

En Windows, el registro habitual se encuentra en:

```text
C:\Users\<USUARIO>\Zomboid\console.txt
```

Si algo falla:

1. Busca las líneas que contengan `MisRecetasDev`.
2. Copia también las líneas de error que aparecen justo antes y después.
3. Anota qué botón pulsaste y qué esperabas que ocurriera.
4. Incluye la versión exacta del juego y si estabas en una partida nueva o guardada.
5. Comparte el fragmento del registro al abrir un issue en GitHub.

> [!NOTE]
> Un mensaje que indique que se llamó a un método **no es prueba suficiente** de que el contenido se haya recargado. La prueba debe comprobar el resultado dentro del juego.

---

## ⚠️ Seguridad y limitaciones

- Haz las pruebas en una **copia** de tu partida.
- No des por hecho que recargar scripts durante una partida es seguro.
- La recarga de recetas y la de traducciones son **sistemas diferentes**.
- La detección de cambios de archivos no garantiza que el juego pueda aplicarlos en caliente.
- La recarga automática está pendiente de validación.
- No publiques archivos de registro con información privada.

---

## 🗺️ Estado de las funciones

- [ ] Verificar que el panel aparece en Build 42.21.0
- [ ] Verificar la recarga real de una receta nueva
- [ ] Verificar la modificación de una receta existente
- [ ] Verificar la recarga real de traducciones JSON
- [ ] Revisar errores y efectos secundarios durante una partida
- [ ] Añadir detección automática de archivos modificados
- [ ] Añadir un intervalo configurable de comprobación
- [ ] Documentar resultados reproducibles

---

## 🤝 Cómo contribuir

1. Abre un issue describiendo el comportamiento observado.
2. Incluye la versión exacta de Project Zomboid y los pasos para reproducir el problema.
3. Adjunta solo los fragmentos relevantes de `console.txt`, ocultando información privada.
4. Para cambios de código, crea una rama y envía un pull request.
5. Se agradecen las pruebas reproducibles y los informes que distingan entre *"la llamada no dio error"* y *"el cambio se reflejó realmente en el juego"*.

---

## 📄 Licencia

Todavía no se ha seleccionado ninguna licencia. Añade un archivo `LICENSE` antes de invitar a otras personas a reutilizar, modificar o redistribuir el código. Elige una licencia solo después de confirmar que tienes derecho a licenciar todos los archivos incluidos.

<div align="center">

<sub>Hecho con 🧠 y muchos zombis 🧟</sub>

</div>
