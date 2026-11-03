## 📖 What is MisRecetasDev?

**MisRecetasDev** is an experimental helper mod for developing and testing **Project Zomboid** recipes **without closing the game** every time you edit a file.

It is designed to work alongside a separate mod named `MisRecetas`, which contains your recipes and translations.

### ✨ What it investigates

| | Feature | Status |
|---|---|---|
| 📜 | Reload `craftRecipe` definitions from `.txt` files | 🧪 Experimental |
| 🌐 | Reload JSON translations (`IG_UI.json`, `Recipes.json`) | 🧪 Experimental |
| 🖱️ | In-game button to run reload tests manually | 🧪 Experimental |
| 🪵 | Log real results and errors for debugging | 🧪 Experimental |
| 👀 | Detect files saved from VS Code and auto-reload | 🔜 Planned |

> [!WARNING]
> This project is **experimental**. Seeing the panel or button does **not** prove that recipes or translations were reloaded. Every feature must be verified in-game and in `console.txt`. Compatibility with every Project Zomboid version is not guaranteed.

---

## 🎯 Goals

1. Investigate Lua access to `ScriptManager`, `ScriptType.CraftRecipe` and `ReloadScripts()`.
2. Verify whether new recipes and edits to existing ones become available during an active session.
3. Investigate whether JSON translations can be reloaded without restarting.
4. Log real results and errors instead of reporting a false success.
5. Add automatic change detection **only after** manual reload has been validated.

---

## 📋 Requirements

- 🪟 Project Zomboid on Windows
- 🎮 Exact game version used for testing (current target: **Build 42.21.0**)
- 📦 The original `MisRecetas` mod, if testing its recipes
- 🧩 The `MisRecetasDev` prototype
- 💻 Visual Studio Code (recommended)
- 🐞 Enabling `-debug` is **not** required for initial tests

---

## 🚀 Local installation

1. Download or extract the complete `MisRecetasDev` mod folder.
2. Copy it to:

   ```text
   C:\Users\<USERNAME>\Zomboid\mods\MisRecetasDev
   ```

3. Make sure `mod.info` is **directly** inside `MisRecetasDev` (no duplicated nested folder).
4. Start Project Zomboid.
5. Enable `MisRecetasDev` in the Mods menu (and `MisRecetas` if you want to test its recipes).
6. Load a test save. Using a **copy** of your main save is recommended.
7. Check whether the mod panel appears.
8. If the button appears, click it and verify the **actual in-game result** before concluding that reloading works.

---

## 🧪 Testing

<details>
<summary><b>📜 Testing recipes</b></summary>

<br>

1. Keep the game open in a test session.
2. Back up the recipe file before editing it.
3. Open the `MisRecetas` scripts folder, usually:

   ```text
   MisRecetas\common\media\scripts\
   ```

4. Add a test recipe with a distinctive name, or edit an existing test recipe.
5. Save the file with `Ctrl + S`.
6. Return to the game and click the reload button.
7. Open the crafting menu and check whether the new or modified recipe appears and works.
8. If it does not appear, **do not assume the reload succeeded**; inspect the logs.

</details>

<details>
<summary><b>🌐 Testing translations</b></summary>

<br>

1. Back up the JSON file you plan to edit.
2. Open the relevant file under `Translate`, such as `IG_UI.json` or `Recipes.json`.
3. Temporarily change a test entry, keeping the JSON valid.
4. Save with `Ctrl + S`.
5. Click the translation reload button, if available in the installed version.
6. Check the text in-game. Text already on screen may not update until the interface is reopened.
7. Restore the original text when finished.

</details>

---

## 🔍 Troubleshooting

On Windows, the usual log file is:

```text
C:\Users\<USERNAME>\Zomboid\console.txt
```

If something goes wrong:

1. Search for lines containing `MisRecetasDev`.
2. Include the error lines immediately before and after those entries.
3. State which button you clicked and what you expected to happen.
4. Include the exact game version and whether you used a new or existing save.
5. Share the relevant log excerpt when opening a GitHub issue.

> [!NOTE]
> A message saying that a method was called is **not enough** to prove that content was reloaded. The result must be verified in-game.

---

## ⚠️ Safety and limitations

- Test on a **copy** of your save.
- Do not assume that reloading scripts during an active session is safe.
- Recipe reloads and translation reloads are **separate systems**.
- Detecting changed files does not guarantee that the game can apply those changes at runtime.
- Automatic reload is pending validation.
- Do not publish log files containing private information.

---

## 🗺️ Feature status

- [ ] Verify that the panel appears in Build 42.21.0
- [ ] Verify that a new recipe actually reloads
- [ ] Verify that an existing recipe can be changed
- [ ] Verify that JSON translations actually reload
- [ ] Check errors and side effects during an active session
- [ ] Add automatic detection of modified files
- [ ] Add a configurable polling interval
- [ ] Document reproducible test results

---

## 🤝 Contributing

1. Open an issue describing the observed behavior.
2. Include the exact Project Zomboid version and reproduction steps.
3. Attach only relevant `console.txt` excerpts, with private information removed.
4. For code changes, create a branch and submit a pull request.
5. Reproducible tests are especially helpful. Please distinguish between *"the method call did not error"* and *"the change actually appeared in-game."*

---

## 📄 License

No license has been selected yet. Add a `LICENSE` file before inviting others to reuse, modify or redistribute the code. Only choose a license after confirming that you have the right to license all included files.

<div align="center">

<sub>Made with 🧠 and a lot of zombies 🧟</sub>

</div>
