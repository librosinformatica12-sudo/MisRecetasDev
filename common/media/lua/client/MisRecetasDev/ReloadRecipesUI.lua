-- MisRecetasDev - Build 42.21.0
-- Experimental: this tests the public Java API exposed to Lua. It is NOT yet
-- confirmed that the game refreshes every live crafting UI/cache after reload.

MisRecetasDev = MisRecetasDev or {}

-- Keep this at 0 for the first test. If set to e.g. 10, it attempts a reload
-- every 10 seconds (not file-change detection). Use only after manual testing.
MisRecetasDev.AUTO_RELOAD_SECONDS = 0
MisRecetasDev._tickCounter = 0
MisRecetasDev._lastAutoReload = 0
MisRecetasDev._window = nil

local function log(message)
    print("[MisRecetasDev] " .. tostring(message))
end

local function getRecipeCount()
    local ok, result = pcall(function()
        local manager = nil
        if type(getScriptManager) == "function" then
            manager = getScriptManager()
        end
        if manager == nil and ScriptManager ~= nil then
            manager = ScriptManager.instance
        end
        if manager == nil then return "no disponible" end
        local recipes = manager:getAllCraftRecipes()
        if recipes == nil then return "lista nula" end
        return recipes:size()
    end)
    if ok then return tostring(result) end
    return "error al consultar: " .. tostring(result)
end

function MisRecetasDev.reloadRecipesAndTranslations()
    log("----------------------------------------")
    log("Inicio de recarga experimental.")
    log("Recetas craftRecipe antes: " .. getRecipeCount())

    local recipeOK, recipeError = pcall(function()
        local manager = nil

        -- Prefer the global helper if this game build exposes it to Lua.
        if type(getScriptManager) == "function" then
            manager = getScriptManager()
        end

        -- Fallback: the Java class documents a static ScriptManager.instance.
        if manager == nil and ScriptManager ~= nil then
            manager = ScriptManager.instance
        end

        if manager == nil then
            error("No se pudo obtener ScriptManager desde Lua")
        end
        if ScriptType == nil or ScriptType.CraftRecipe == nil then
            error("ScriptType.CraftRecipe no está disponible desde Lua")
        end

        manager:ReloadScripts(ScriptType.CraftRecipe)
    end)

    if recipeOK then
        log("La llamada ReloadScripts(CraftRecipe) terminó sin excepción.")
    else
        log("FALLO al recargar recetas: " .. tostring(recipeError))
    end
    log("Recetas craftRecipe después: " .. getRecipeCount())

    -- Build 42 documents Translator.loadFiles() as a public static method.
    -- Whether it fully refreshes the active language's UI at runtime must be
    -- verified in-game; this pcall only reports whether the call threw.
    local translationOK, translationError = pcall(function()
        if Translator == nil or Translator.loadFiles == nil then
            error("Translator.loadFiles no está disponible desde Lua")
        end
        Translator.loadFiles()
    end)

    if translationOK then
        log("La llamada Translator.loadFiles() terminó sin excepción.")
    else
        log("FALLO al recargar traducciones: " .. tostring(translationError))
    end

    log("Fin de la prueba. Comprueba el menú de fabricación y los textos.")
    log("IMPORTANTE: ausencia de excepción no demuestra que el juego haya actualizado sus cachés.")

    if MisRecetasDev._window and MisRecetasDev._window.statusLabel then
        local status = "Recetas: " .. (recipeOK and "llamada OK" or "ERROR")
        status = status .. " | JSON: " .. (translationOK and "llamada OK" or "ERROR")
        MisRecetasDev._window.statusLabel:setName(status)
    end
end

local MisRecetasDevPanel = ISPanel:derive("MisRecetasDevPanel")

function MisRecetasDevPanel:new(x, y, width, height)
    local o = ISPanel.new(self, x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.moveWithMouse = true
    o.background = true
    o.borderColor = { r = 0.75, g = 0.75, b = 0.75, a = 1 }
    o.backgroundColor = { r = 0.08, g = 0.08, b = 0.08, a = 0.90 }
    return o
end

function MisRecetasDevPanel:createChildren()
    ISPanel.createChildren(self)

    self.titleLabel = ISLabel:new(10, 8, 20, "MisRecetasDev (experimental)", 1, 1, 1, 1, UIFont.Small, true)
    self.titleLabel:initialise()
    self.titleLabel:instantiate()
    self:addChild(self.titleLabel)

    self.reloadButton = ISButton:new(10, 34, self.width - 20, 28, "RECARGAR RECETAS + JSON", self, function()
        MisRecetasDev.reloadRecipesAndTranslations()
    end)
    self.reloadButton:initialise()
    self.reloadButton:instantiate()
    self:addChild(self.reloadButton)

    self.statusLabel = ISLabel:new(10, 66, 18, "Pulsa el botón para probar la recarga", 0.9, 0.9, 0.9, 1, UIFont.Small, true)
    self.statusLabel:initialise()
    self.statusLabel:instantiate()
    self:addChild(self.statusLabel)
end

function MisRecetasDev.onGameStart()
    if MisRecetasDev._window then return end
    local panel = MisRecetasDevPanel:new(20, 100, 300, 92)
    panel:initialise()
    panel:instantiate()
    panel:addToUIManager()
    panel:setVisible(true)
    panel:setAlwaysOnTop(true)
    MisRecetasDev._window = panel
    log("Panel cargado. Build de destino: 42.21.0. Recarga automática desactivada.")
    log("Cantidad inicial de craftRecipe: " .. getRecipeCount())
end

Events.OnGameStart.Add(MisRecetasDev.onGameStart)

-- Optional timed attempts. This does not watch files or detect Ctrl+S; it only
-- repeats the same reload attempt at the configured interval.
Events.OnTick.Add(function()
    local seconds = tonumber(MisRecetasDev.AUTO_RELOAD_SECONDS) or 0
    if seconds <= 0 then return end

    MisRecetasDev._tickCounter = MisRecetasDev._tickCounter + 1
    -- OnTick runs roughly once per frame; getTimestamp() is game-provided.
    local now = getTimestamp and getTimestamp() or nil
    if now ~= nil then
        if MisRecetasDev._lastAutoReload == 0 then
            MisRecetasDev._lastAutoReload = now
        elseif (now - MisRecetasDev._lastAutoReload) >= seconds then
            MisRecetasDev._lastAutoReload = now
            MisRecetasDev.reloadRecipesAndTranslations()
        end
    else
        local ticksPerInterval = math.max(1, seconds * 60)
        if MisRecetasDev._tickCounter >= ticksPerInterval then
            MisRecetasDev._tickCounter = 0
            MisRecetasDev.reloadRecipesAndTranslations()
        end
    end
end)
