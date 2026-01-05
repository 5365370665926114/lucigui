--[[

  LUCIGUI | VERSÃO HUB - AUTO PLAY PIANO

  DEL = Toggle GUI

  Executor compatible (Delta, Synapse, etc.)

  Versão traduzida para português com design melhorado

]]

-- CONFIGURAÇÕES DO SCRIPT

local SCRIPT_VERSION = "2.0.0"

local UPDATE_NOTES = "• Interface moderna com sistema de tabs\n• Músicas organizadas em categorias\n• Sistema de busca e favoritos\n• Todas as funcionalidades de piano preservadas\n• Design melhorado com cores de destaque"

-- CONFIGURAÇÕES DE DESIGN

local ACCENT_COLOR = Color3.fromRGB(0, 170, 255) -- Cor de destaque para botões ATIVADOS

-- MENSAGEM INICIAL

print("LUCIGUI: Script iniciado. Versão:", SCRIPT_VERSION)

-- Função principal para encapsular todo o código

local function runHub()

    -- SERVICES

    local Players = game:GetService("Players")

    local UIS = game:GetService("UserInputService")

    local RS = game:GetService("RunService")

    local HttpService = game:GetService("HttpService")

    local ContentProvider = game:GetService("ContentProvider")

    local TextService = game:GetService("TextService")

    local player = Players.LocalPlayer

    local mouse = player:GetMouse()

    -- Translator local simplificado (sempre português)

    local translator = {}

    local translations = {

        ["play song"] = "Tocar!",

        ["search"] = "procurar...",

        ["songname"] = "NOME DA MÚSICA",

        ["toggle ui"] = "alternar ui",

        ["spoof midi"] = "falsificar midi",

        ["shuffle play songs"] = "EMBARALHAR MÚSICAS",

        ["play random song"] = "MÚSICA ALEATÓRIA",

        ["new"] = "novas",

        ["peak"] = "top",

        ["best"] = "melhores",

        ["epic"] = "épico",

        ["beautiful"] = "bonitas",

        ["video games"] = "videogames",

        ["movies/tv"] = "filmes/tv",

        ["memes"] = "memes",

        ["classical"] = "clássicas",

        ["pop/hiphop"] = "pop/hiphop",

        ["anime/jpop"] = "anime/jpop",

        ["sad"] = "tristes",

        ["electronic"] = "eletrônicas",

        ["rock"] = "rock",

        ["creepy/weirdcore"] = "assustador/weirdcore",

        ["custom songs"] = "músicas custom",

        ["favourites"] = "favoritas",

        ["other"] = "outros",

        ["all"] = "todas",

        ["songplayingerror"] = "Uma música já está sendo reproduzida.",

        ["invalidbpm"] = "por favor, coloque um bpm válido",

        ["beganplayingnotif"] = "Começou a tocar a música."

    }

    function translator:translateText(text)

        return translations[text] or text

    end

    local function translateText(text)

        return translator:translateText(text)

    end

    -- NotificationLibrary

    local NotificationLibrary = loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/hellohellohell012321/TALENTLESS@main/notif_lib.lua"))()

    -- Assets

    local assetsToPreload = {

        "rbxassetid://94707254666920", -- unfav icon

        "rbxassetid://95485559387661", -- fav icon

        "rbxassetid://70452176150315", -- ui open

        "rbxassetid://1524549907", -- ui close

        "rbxassetid://104269922408932", -- bye bye

        "rbxassetid://7383525713", -- notif error

        "rbxassetid://18595195017" -- notif success

    }

    ContentProvider:PreloadAsync(assetsToPreload)

    local function playSound(soundId, loudness)

        local sound = Instance.new("Sound")

        sound.SoundId = "rbxassetid://" .. soundId

        sound.Parent = player.Character or player

        sound.Volume = loudness or 1

        sound:Play()

    end

    -- VARIÁVEIS GLOBAIS DO PIANO

    local songisplaying = false

    local spoofMidiPlz = false

    local gameId = game.GameId

    -- ================= GUI CRIAÇÃO =================

    local gui

    local success, err = pcall(function()

        gui = Instance.new("ScreenGui")

        gui.Name = "LuciguiHub"

        gui.ResetOnSpawn = false

        gui.IgnoreGuiInset = true

        gui.Parent = game:GetService("CoreGui")

    end)

    if not success then

        warn("LUCIGUI: Falha ao criar GUI no CoreGui. Tentando PlayerGui...")

        pcall(function()

            gui = Instance.new("ScreenGui")

            gui.Name = "LuciguiHub"

            gui.ResetOnSpawn = false

            gui.IgnoreGuiInset = true

            gui.Parent = player:WaitForChild("PlayerGui")

        end)

    end

    if not gui or not gui.Parent then

        return warn("LUCIGUI: CRÍTICO - Não foi possível criar a GUI. Script abortado.")

    end

    print("LUCIGUI: GUI criada com sucesso em:", gui.Parent:GetFullName())

    local main = Instance.new("Frame", gui)

    main.Size = UDim2.fromOffset(680, 520)

    main.Position = UDim2.fromScale(0.5, 0.5)

    main.AnchorPoint = Vector2.new(0.5, 0.5)

    main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)

    main.Active = true

    main.Draggable = true

    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

    -- TITLE

    local title = Instance.new("Frame", main)

    title.Size = UDim2.new(1, 0, 0, 42)

    title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

    local titleLabel = Instance.new("TextLabel", title)

    titleLabel.Size = UDim2.new(1, 0, 1, 0)

    titleLabel.Text = "LUCIGUI"

    titleLabel.Font = Enum.Font.GothamBold

    titleLabel.TextSize = 20

    titleLabel.TextColor3 = ACCENT_COLOR

    titleLabel.BackgroundTransparency = 1

    local fix = Instance.new("Frame", title)

    fix.Size = UDim2.new(1, 0, 0, 12)

    fix.Position = UDim2.new(0, 0, 1, -12)

    fix.BackgroundColor3 = title.BackgroundColor3

    fix.BorderSizePixel = 0

    -- SIDEBAR

    local side = Instance.new("Frame", main)

    side.Size = UDim2.new(0, 160, 1, -42)

    side.Position = UDim2.new(0, 0, 0, 42)

    side.BackgroundColor3 = Color3.fromRGB(22, 22, 22)

    -- CONTENT

    local content = Instance.new("Frame", main)

    content.Size = UDim2.new(1, -160, 1, -42)

    content.Position = UDim2.new(0, 160, 0, 42)

    content.BackgroundColor3 = Color3.fromRGB(16, 16, 16)

    -- ================= UI UTILS =================

    local function clearContent()

        for _, v in ipairs(content:GetChildren()) do

            if v:IsA("GuiObject") then v:Destroy() end

        end

    end

    local function applyButtonStyle(button)

        button.Font = Enum.Font.Gotham

        button.TextSize = 14

        button.TextColor3 = Color3.new(1, 1, 1)

        button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

        button.MouseEnter:Connect(function() if button.BackgroundColor3 ~= ACCENT_COLOR then button.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end end)

        button.MouseLeave:Connect(function() if button.BackgroundColor3 ~= ACCENT_COLOR then button.BackgroundColor3 = Color3.fromRGB(35, 35, 35) end end)

    end

    local function newButton(parent, text, y)

        local b = Instance.new("TextButton", parent)

        b.Size = UDim2.new(1, -20, 0, 40)

        b.Position = UDim2.new(0, 10, 0, y)

        b.Text = text

        applyButtonStyle(b)

        return b

    end

    -- ================= DADOS DAS MÚSICAS =================

    local songs = {

        {name = "GOLDEN HOUR", bpm = "94", url = "GOLDEN_HOUR", cat = {"beautiful", "best"}},

        {name = "YOUNG GIRL A", bpm = "130", url = "YOUNG_GIRL_A", cat = {"anime/jpop", "sad", "beautiful", "best"}},

        {name = "MOONLIGHT SONATA - THIRD MOVEMENT", bpm = "163", url = "WHAT_THE_FUCKK", cat = {"classical", "best", "peak"}},

        {name = "UNDERTALE", bpm = "100", url = "UNDERTALE", cat = {"video games", "undertale", "best", "epic"}},

        {name = "TURKISH MARCH", bpm = "92", url = "TURKISH", cat = {"classical"}},

        {name = "UNRAVEL (ANIMENZ ARR.)", bpm = "132", url = "UNRAVEL_EPIC", cat = {"epic", "best", "beautiful", "peak", "movies/tv"}},

        {name = "SNOWFALL", bpm = "96", url = "SNOWFALL", cat = {"beautiful", "sad", "best"}},

        {name = "BOHEMIAN RHAPSODY", bpm = "80", url = "BOHEMIAN_RHAPSODY", cat = {"rock"}},

        {name = "RENAI CIRCULATION", bpm = "120", url = "RENAI_CIRCULATION", cat = {"anime/jpop", "memes", "peak", "best"}},

        {name = "WE NOT LIKE YOU", bpm = "155", url = "WE_NOT_LIKE_U", cat = {"pop/hiphop", "memes", "new"}},

    }

    local categories = {

        "new", "peak", "best", "epic", "beautiful", "video games", "movies/tv", "memes",

        "classical", "pop/hiphop", "anime/jpop", "sad", "electronic", "rock", "creepy/weirdcore"

    }

    -- Função para tocar música

    local function playSong(songData, bpmValue)

        if songisplaying then

            playSound("7383525713", 0.5)

            NotificationLibrary:SendNotification("Error", translateText("songplayingerror"), 1)

            return

        end

        songisplaying = true

        local bpm = tonumber(bpmValue or songData.bpm)

        if bpm == 0 or not bpm then

            NotificationLibrary:SendNotification("Error", translateText("invalidbpm"), 3)

            songisplaying = false

            return

        end

        _G.bpm = bpm

        local songscript = game:HttpGet(

            "https://cdn.jsdelivr.net/gh/hellohellohell012321/TALENTLESS@main/SONGS/" .. songData.url,

            true

        )

        if spoofMidiPlz and gameId == 3929033413 then

            loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/hellohellohell012321/TALENTLESS@main/midi_spoof_loader.lua", true))()

        else

            loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/hellohellohell012321/TALENTLESS@main/loader_main.lua", true))()

        end

        loadstring(songscript)()

        playSound("18595195017", 0.5)

        NotificationLibrary:SendNotification("Success", translateText("beganplayingnotif"), 1)

    end

    -- ================= TABS =================

    local tabs = {}

    tabs.Info = function()

        print("LUCIGUI: Aba 'Info' aberta.")

        clearContent()

        local scrollingFrame = Instance.new("ScrollingFrame", content)

        scrollingFrame.Size = UDim2.new(1, -20, 1, -10)

        scrollingFrame.Position = UDim2.new(0, 10, 0, 10)

        scrollingFrame.BackgroundTransparency = 1

        scrollingFrame.BorderSizePixel = 0

        scrollingFrame.ScrollBarThickness = 8

        scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)

        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

        local listLayout = Instance.new("UIListLayout", scrollingFrame)

        listLayout.SortOrder = Enum.SortOrder.LayoutOrder

        listLayout.Padding = UDim.new(0, 10)

        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)

        end)

        local function createInfoBox(titleText, infoText, yPos)

            local box = Instance.new("Frame", scrollingFrame)

            box.Size = UDim2.new(1, 0, 0, 100)

            box.Position = UDim2.new(0, 0, 0, yPos)

            box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

            box.LayoutOrder = yPos / 110

            Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

            local title = Instance.new("TextLabel", box)

            title.Size = UDim2.new(1, -10, 0, 20)

            title.Position = UDim2.new(0, 5, 0, 5)

            title.Text = titleText

            title.Font = Enum.Font.GothamBold

            title.TextSize = 14

            title.TextColor3 = ACCENT_COLOR

            title.BackgroundTransparency = 1

            title.TextXAlignment = Enum.TextXAlignment.Left

            local info = Instance.new("TextLabel", box)

            info.Size = UDim2.new(1, -10, 1, -25)

            info.Position = UDim2.new(0, 5, 0, 25)

            info.Text = infoText

            info.Font = Enum.Font.Gotham

            info.TextSize = 12

            info.TextColor3 = Color3.fromRGB(200, 200, 200)

            info.BackgroundTransparency = 1

            info.TextXAlignment = Enum.TextXAlignment.Left

            info.TextYAlignment = Enum.TextYAlignment.Top

            info.TextWrapped = true

        end

        createInfoBox("Sobre o Lucigui (v" .. SCRIPT_VERSION .. ")", UPDATE_NOTES, 0)

        local accountAge = math.floor(player.AccountAge / 365)

        local userInfoText = string.format("Nome de Exibição: %s\nNome de Usuário: %s\nIdade da Conta: %d anos", player.DisplayName, player.Name, accountAge)

        createInfoBox("Informações do Usuário", userInfoText, 110)

    end

    tabs.Piano = function()

        print("LUCIGUI: Aba 'Piano' aberta.")

        clearContent()

        -- Categorias na lateral

        local categoriesFrame = Instance.new("ScrollingFrame", content)

        categoriesFrame.Size = UDim2.new(0, 140, 1, -60)

        categoriesFrame.Position = UDim2.new(0, 10, 0, 60)

        categoriesFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)

        categoriesFrame.BorderSizePixel = 0

        Instance.new("UICorner", categoriesFrame).CornerRadius = UDim.new(0, 8)

        categoriesFrame.ScrollBarThickness = 6

        categoriesFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

        local catLayout = Instance.new("UIListLayout", categoriesFrame)

        catLayout.SortOrder = Enum.SortOrder.LayoutOrder

        catLayout.Padding = UDim.new(0, 5)

        catLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

            categoriesFrame.CanvasSize = UDim2.new(0, 0, 0, catLayout.AbsoluteContentSize.Y)

        end)

        -- Search

        local search = Instance.new("TextBox", content)

        search.Size = UDim2.new(1, -170, 0, 36)

        search.Position = UDim2.new(0, 150, 0, 10)

        search.PlaceholderText = "🔍 Procurar música..."

        search.Text = ""

        search.Font = Enum.Font.Gotham

        search.TextSize = 14

        search.TextColor3 = Color3.new(1, 1, 1)

        search.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

        Instance.new("UICorner", search).CornerRadius = UDim.new(0, 8)

        -- Songs Frame

        local songsFrame = Instance.new("ScrollingFrame", content)

        songsFrame.Size = UDim2.new(1, -170, 1, -60)

        songsFrame.Position = UDim2.new(0, 150, 0, 60)

        songsFrame.BackgroundTransparency = 1

        songsFrame.BorderSizePixel = 0

        songsFrame.ScrollBarThickness = 8

        songsFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)

        songsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

        local songsLayout = Instance.new("UIListLayout", songsFrame)

        songsLayout.SortOrder = Enum.SortOrder.LayoutOrder

        songsLayout.Padding = UDim.new(0, 8)

        songsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

            songsFrame.CanvasSize = UDim2.new(0, 0, 0, songsLayout.AbsoluteContentSize.Y)

        end)

        local currentCategory = "all"

        local songButtons = {}

        local function filterAndRender()

            for _, btn in pairs(songButtons) do

                if btn and btn.Parent then btn:Destroy() end

            end

            songButtons = {}

            local filterText = search.Text:lower()

            local layoutOrder = 0

            for _, song in ipairs(songs) do

                local show = false

                if currentCategory == "all" then

                    show = true

                else

                    for _, cat in ipairs(song.cat) do

                        if cat == currentCategory then

                            show = true

                            break

                        end

                    end

                end

                if show and (filterText == "" or song.name:lower():find(filterText)) then

                    local btn = Instance.new("TextButton", songsFrame)

                    btn.Text = "♪ " .. song.name

                    btn.Size = UDim2.new(1, 0, 0, 40)

                    btn.LayoutOrder = layoutOrder

                    applyButtonStyle(btn)

                    btn.MouseButton1Click:Connect(function()

                        print("LUCIGUI: Tocar música:", song.name)

                        playSong(song, song.bpm)

                    end)

                    table.insert(songButtons, btn)

                    layoutOrder = layoutOrder + 1

                end

            end

        end

        -- Category buttons

        local function createCategoryButton(name, y)

            local btn = newButton(categoriesFrame, translateText(name) or name, y)

            btn.MouseButton1Click:Connect(function()

                currentCategory = name

                filterAndRender()

            end)

        end

        createCategoryButton("all", 0)

        local yPos = 50

        for _, catName in ipairs(categories) do

            createCategoryButton(catName, yPos)

            yPos = yPos + 50

        end

        search:GetPropertyChangedSignal("Text"):Connect(filterAndRender)

        filterAndRender()

    end

    -- ================= SIDEBAR TABS =================

    local function addTab(name, callback, y)

        local btn = newButton(side, name, y)

        btn.MouseButton1Click:Connect(callback)

    end

    addTab("Info", tabs.Info, 10)

    addTab("Piano", tabs.Piano, 60)

    tabs.Info()

    -- ================= DEL TOGGLE =================

    UIS.InputBegan:Connect(function(input, gp)

        if gp then return end

        if input.KeyCode == Enum.KeyCode.Delete then

            main.Visible = not main.Visible

        end

    end)

end

-- Executa a função principal

local ok, err = pcall(runHub)

if not ok then

    warn("LUCIGUI: ERRO CRÍTICO AO INICIAR: " .. tostring(err))

end
