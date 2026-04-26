--[[

  LUCIGUI | VERSÃƒÆ’O HUB - AUTO PLAY PIANO

  DEL = Toggle GUI

  Executor compatible (Delta, Synapse, etc.)

  VersÃƒÂ£o traduzida para portuguÃƒÂªs com design melhorado

]]

-- CONFIGURAÃƒâ€¡Ãƒâ€¢ES DO SCRIPT

local SCRIPT_VERSION = "2.0.0"

local UPDATE_NOTES = "Ã¢â‚¬Â¢ Interface moderna com sistema de tabs\nÃ¢â‚¬Â¢ MÃƒÂºsicas organizadas em categorias\nÃ¢â‚¬Â¢ Sistema de busca e favoritos\nÃ¢â‚¬Â¢ Todas as funcionalidades de piano preservadas\nÃ¢â‚¬Â¢ Design melhorado com cores de destaque"

-- CONFIGURAÃƒâ€¡Ãƒâ€¢ES DE DESIGN

local ACCENT_COLOR = Color3.fromRGB(138, 43, 226) -- Premium Purple

-- MENSAGEM INICIAL

print("LUCIGUI: Script iniciado. VersÃƒÂ£o:", SCRIPT_VERSION)
local TS = game:GetService("TweenService")

-- FunÃƒÂ§ÃƒÂ£o principal para encapsular todo o cÃƒÂ³digo

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

    -- Translator local simplificado (sempre portuguÃƒÂªs)

    local translator = {}

    local translations = {

        ["play song"] = "Tocar!",

        ["search"] = "procurar...",

        ["songname"] = "NOME DA MÃƒÅ¡SICA",

        ["toggle ui"] = "alternar ui",

        ["spoof midi"] = "falsificar midi",

        ["shuffle play songs"] = "EMBARALHAR MÃƒÅ¡SICAS",

        ["play random song"] = "MÃƒÅ¡SICA ALEATÃƒâ€œRIA",

        ["new"] = "novas",

        ["peak"] = "top",

        ["best"] = "melhores",

        ["epic"] = "ÃƒÂ©pico",

        ["beautiful"] = "bonitas",

        ["video games"] = "videogames",

        ["movies/tv"] = "filmes/tv",

        ["memes"] = "memes",

        ["classical"] = "clÃƒÂ¡ssicas",

        ["pop/hiphop"] = "pop/hiphop",

        ["anime/jpop"] = "anime/jpop",

        ["sad"] = "tristes",

        ["electronic"] = "eletrÃƒÂ´nicas",

        ["rock"] = "rock",

        ["creepy/weirdcore"] = "assustador/weirdcore",

        ["custom songs"] = "mÃƒÂºsicas custom",

        ["favourites"] = "favoritas",

        ["other"] = "outros",

        ["all"] = "todas",

        ["songplayingerror"] = "Uma mÃƒÂºsica jÃƒÂ¡ estÃƒÂ¡ sendo reproduzida.",

        ["invalidbpm"] = "por favor, coloque um bpm vÃƒÂ¡lido",

        ["beganplayingnotif"] = "ComeÃƒÂ§ou a tocar a mÃƒÂºsica."

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

    -- VARIÃƒÂVEIS GLOBAIS DO PIANO

    local songisplaying = false
    local spoofMidiPlz = false
    local gameId = game.GameId

    -- ================= FAVORITOS SYSTEM =================
    local favFile = "lucigui_favorites.json"
    local favorites = {}
    
    local isfile = isfile or function() return false end
    local readfile = readfile or function() return "{}" end
    local writefile = writefile or function() end

    if isfile(favFile) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(favFile))
        end)
        if success and type(result) == "table" then
            favorites = result
        end
    end

    local function saveFavorites()
        pcall(function()
            writefile(favFile, HttpService:JSONEncode(favorites))
        end)
    end

    local function toggleFavorite(songName)
        local idx = table.find(favorites, songName)
        if idx then
            table.remove(favorites, idx)
        else
            table.insert(favorites, songName)
        end
        saveFavorites()
    end

    local function isFavorite(songName)
        return table.find(favorites, songName) ~= nil
    end

    -- ================= GUI CRIAÃƒâ€¡ÃƒÆ’O =================

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

        return warn("LUCIGUI: CRÃƒÂTICO - NÃƒÂ£o foi possÃƒÂ­vel criar a GUI. Script abortado.")

    end

    print("LUCIGUI: GUI criada com sucesso em:", gui.Parent:GetFullName())

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.fromOffset(680, 520)
    main.Position = UDim2.fromScale(0.5, 0.5)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(50, 50, 65)
    mainStroke.Thickness = 1
    
    local dropShadow = Instance.new("ImageLabel", main)
    dropShadow.BackgroundTransparency = 1
    dropShadow.Image = "rbxassetid://6015897843"
    dropShadow.ImageColor3 = Color3.new(0,0,0)
    dropShadow.ImageTransparency = 0.5
    dropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    dropShadow.ScaleType = Enum.ScaleType.Slice
    dropShadow.Size = UDim2.new(1, 30, 1, 30)
    dropShadow.Position = UDim2.new(0, -15, 0, -15)
    dropShadow.ZIndex = 0

    -- TITLE

    local title = Instance.new("Frame", main)
    title.Size = UDim2.new(1, 0, 0, 42)
    title.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel", title)
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Text = "Ã¢Å“Â§ LUCIGUI PREMIER Ã¢Å“Â§"
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = ACCENT_COLOR
    titleLabel.BackgroundTransparency = 1

    local fix = Instance.new("Frame", title)
    fix.Size = UDim2.new(1, 0, 0, 12)
    fix.Position = UDim2.new(0, 0, 1, -12)
    fix.BackgroundColor3 = title.BackgroundColor3
    fix.BorderSizePixel = 0
    
    local divider = Instance.new("Frame", title)
    divider.Size = UDim2.new(1, 0, 0, 1)
    divider.Position = UDim2.new(0, 0, 1, -1)
    divider.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    divider.BorderSizePixel = 0

    -- SIDEBAR

    local side = Instance.new("Frame", main)
    side.Size = UDim2.new(0, 160, 1, -42)
    side.Position = UDim2.new(0, 0, 0, 42)
    side.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
    side.BorderSizePixel = 0

    local sideDivider = Instance.new("Frame", side)
    sideDivider.Size = UDim2.new(0, 1, 1, 0)
    sideDivider.Position = UDim2.new(1, -1, 0, 0)
    sideDivider.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    sideDivider.BorderSizePixel = 0

    -- CONTENT

    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1, -160, 1, -42)
    content.Position = UDim2.new(0, 160, 0, 42)
    content.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    content.BorderSizePixel = 0

    -- ================= UI UTILS =================

    local function clearContent()

        for _, v in ipairs(content:GetChildren()) do

            if v:IsA("GuiObject") then v:Destroy() end

        end

    end

    local function applyButtonStyle(button)
        button.Font = Enum.Font.GothamMedium
        button.TextSize = 13
        button.TextColor3 = Color3.new(0.9, 0.9, 0.9)
        button.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        button.AutoButtonColor = false
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
        
        local btnStroke = Instance.new("UIStroke", button)
        btnStroke.Color = Color3.fromRGB(55, 55, 70)
        btnStroke.Thickness = 1

        button.MouseEnter:Connect(function() 
            if button.BackgroundColor3 ~= ACCENT_COLOR then 
                TS:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 65)}):Play()
            end 
        end)
        
        button.MouseLeave:Connect(function() 
            if button.BackgroundColor3 ~= ACCENT_COLOR then 
                TS:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
            end 
        end)
    end

    local function newButton(parent, text, y)

        local b = Instance.new("TextButton", parent)

        b.Size = UDim2.new(1, -20, 0, 40)

        b.Position = UDim2.new(0, 10, 0, y)

        b.Text = text

        applyButtonStyle(b)

        return b

    end

    -- ================= DADOS DAS MÃƒÅ¡SICAS =================

    local songs = {
    {name = "A THOUSAND YEARS", bpm = 139, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/a%20thousand%20years.txt", cat = {"all"}},
    {name = "A VIDA ÃƒÂ© DESAFIO", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/a%20vida%20%C3%83%C2%A9%20desafio.txt", cat = {"all"}},
    {name = "ALL OF ME", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/all%20of%20me.txt", cat = {"all"}},
    {name = "BAILE DE FAVELA", bpm = 130, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/Baile%20de%20favela.txt", cat = {"all"}},
    {name = "BARÃƒÎœES DA PISADINHA", bpm = 85, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/bar%C3%83%C2%B5es%20da%20pisadinha.txt", cat = {"all"}},
    {name = "BRILHA", bpm = 110, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/brilha.txt", cat = {"all"}},
    {name = "CASAMENTO", bpm = 128, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/casamento.txt", cat = {"all"}},
    {name = "DEPOIS DO UNIVERSO", bpm = 94, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/depois%20do%20universo.txt", cat = {"all"}},
    {name = "DIVERTIDAMENTE", bpm = 110, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/DIVERTIDAMENTE.txt", cat = {"all"}},
    {name = "KIDS - STRANGER THINGS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/kids%20-%20stranger%20things.txt", cat = {"all"}},
    {name = "LEI DA VIDA", bpm = 60, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/lei%20da%20vida.txt", cat = {"all"}},
    {name = "LIGHTS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LIGHTS", cat = {"all"}},
    {name = "LIKE HIM", bpm = 96, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LIKE_HIM", cat = {"all"}},
    {name = "LIKE HIM BEST", bpm = 96, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LIKE_HIM_BEST", cat = {"all"}},
    {name = "LIVING MICE", bpm = 75, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LIVING_MICE", cat = {"all"}},
    {name = "LOST LIBRARY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LOST_LIBRARY", cat = {"all"}},
    {name = "LOST UMB", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LOST_UMB", cat = {"all"}},
    {name = "LOVE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LOVE", cat = {"all"}},
    {name = "LOVELY", bpm = 115, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LOVELY", cat = {"all"}},
    {name = "LOVELY B", bpm = 115, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LOVELY_B", cat = {"all"}},
    {name = "LOVER IS A DAY", bpm = 95, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LOVER_IS_A_DAY", cat = {"all"}},
    {name = "LOVE STORY", bpm = 119, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LOVE_STORY", cat = {"all"}},
    {name = "LUTHER", bpm = 135, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LUTHER", cat = {"all"}},
    {name = "LUX AETERNA", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/LUX_AETERNA", cat = {"all"}},
    {name = "MAGICAL CURE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MAGICAL_CURE", cat = {"all"}},
    {name = "MANGOMANGOMANGO", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MANGOMANGOMANGO", cat = {"all"}},
    {name = "MARI BOSS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MARI_BOSS", cat = {"all"}},
    {name = "MARRIED", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MARRIED", cat = {"all"}},
    {name = "MARY ON", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MARY_ON", cat = {"all"}},
    {name = "MASTER OF PUPPETS", bpm = 105, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MASTER_OF_PUPPETS", cat = {"all"}},
    {name = "MA MEILLEUR", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MA_MEILLEUR", cat = {"all"}},
    {name = "MEGALOVANIA", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MEGALOVANIA", cat = {"all"}},
    {name = "MERRY CHRISTMAS MR LAWRENCE", bpm = 100, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MERRY_CHRISTMAS_MR_LAWRENCE", cat = {"all"}},
    {name = "METAMORPH", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/METAMORPH", cat = {"all"}},
    {name = "MICE ON", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MICE_ON", cat = {"all"}},
    {name = "MICHAEL MYERS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MICHAEL_MYERS", cat = {"all"}},
    {name = "MIDDLE OF THE NIGHT", bpm = 86, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MIDDLE_OF_THE_NIGHT", cat = {"all"}},
    {name = "MII", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MII", cat = {"all"}},
    {name = "MIKU", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MIKU", cat = {"all"}},
    {name = "MINECRAFT", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MINECRAFT", cat = {"all"}},
    {name = "MINGLE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MINGLE", cat = {"all"}},
    {name = "MONODY", bpm = 107, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MONODY", cat = {"all"}},
    {name = "MONTAGEM CORAL", bpm = 145, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MONTAGEM_CORAL", cat = {"all"}},
    {name = "MONTAGEM TOMADA", bpm = 140, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MONTAGEM_TOMADA", cat = {"all"}},
    {name = "MONTAGEM XONADA", bpm = 140, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MONTAGEM_XONADA", cat = {"all"}},
    {name = "MOOD", bpm = 91, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MOOD", cat = {"all"}},
    {name = "MOOG CITY", bpm = 105, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MOOG_CITY", cat = {"all"}},
    {name = "MOONLIGHT", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MOONLIGHT", cat = {"all"}},
    {name = "MORNING MOOD", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MORNING_MOOD", cat = {"all"}},
    {name = "MRS MAGIC", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MRS_MAGIC", cat = {"all"}},
    {name = "MULTO", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MULTO", cat = {"all"}},
    {name = "MY CASTLE TOWN", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MY_CASTLE_TOWN", cat = {"all"}},
    {name = "MY EYES", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MY_EYES", cat = {"all"}},
    {name = "MY HEART WILL GO ON", bpm = 99, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MY_HEART_WILL_GO_ON", cat = {"all"}},
    {name = "MY KIND OF WOMAN", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MY_KIND_OF_WOMAN", cat = {"all"}},
    {name = "MY LOVE ALL MINE", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MY_LOVE_ALL_MINE", cat = {"all"}},
    {name = "MY ORDINARY LIFE", bpm = 128, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MY_ORDINARY_LIFE", cat = {"all"}},
    {name = "MY WAR", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MY_WAR", cat = {"all"}},
    {name = "MY WAY", bpm = 75, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/MY_WAY", cat = {"all"}},
    {name = "NERVES", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NERVES", cat = {"all"}},
    {name = "NEVER BE ALONE", bpm = 98, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NEVER_BE_ALONE", cat = {"all"}},
    {name = "NEVER MEANT", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NEVER_MEANT", cat = {"all"}},
    {name = "NEVER SEE ME AGAIN", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NEVER_SEE_ME_AGAIN", cat = {"all"}},
    {name = "NEW COMPUTERS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NEW_COMPUTERS", cat = {"all"}},
    {name = "NEW HOME", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NEW_HOME", cat = {"all"}},
    {name = "NIGHT DANCER", bpm = 130, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NIGHT_DANCER", cat = {"all"}},
    {name = "NOCTURNE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NOCTURNE", cat = {"all"}},
    {name = "NOPE YOUR TOO LATE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NOPE_YOUR_TOO_LATE", cat = {"all"}},
    {name = "NOTHING ELSE MATTERS", bpm = 142, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NOTHING_ELSE_MATTERS", cat = {"all"}},
    {name = "NOTION", bpm = 160, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NOTION", cat = {"all"}},
    {name = "NOT A SLACKER", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NOT_A_SLACKER", cat = {"all"}},
    {name = "NOT LIKE US", bpm = 101, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NOT_LIKE_US", cat = {"all"}},
    {name = "NO SURPRISES", bpm = 76, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NO_SURPRISES", cat = {"all"}},
    {name = "NUMBERS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NUMBERS", cat = {"all"}},
    {name = "NYAN CAT", bpm = 140, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NYAN_CAT", cat = {"all"}},
    {name = "NYEH", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/NYEH", cat = {"all"}},
    {name = "OBLIVION", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/OBLIVION", cat = {"all"}},
    {name = "OLD DOLL", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/OLD_DOLL", cat = {"all"}},
    {name = "OLD TOWN ROAD", bpm = 136, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/OLD_TOWN_ROAD", cat = {"all"}},
    {name = "ONCE UPON", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ONCE_UPON", cat = {"all"}},
    {name = "ONCE UPON A DECEMBER", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ONCE_UPON_A_DECEMBER", cat = {"all"}},
    {name = "ONE DANCE", bpm = 104, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ONE_DANCE", cat = {"all"}},
    {name = "ONE OF THE GIRLS", bpm = 83, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ONE_OF_THE_GIRLS", cat = {"all"}},
    {name = "ONE SUMMERS DAY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ONE_SUMMERS_DAY", cat = {"all"}},
    {name = "ON MY WAY", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ON_MY_WAY", cat = {"all"}},
    {name = "ORDER", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ORDER", cat = {"all"}},
    {name = "ORDINARY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ORDINARY", cat = {"all"}},
    {name = "OVERTAKEN", bpm = 140, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/OVERTAKEN", cat = {"all"}},
    {name = "PANTERA COR DE ROSA", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/pantera%20cor%20de%20rosa.txt", cat = {"all"}},
    {name = "PARADISE", bpm = 140, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PARADISE", cat = {"all"}},
    {name = "PASILYO", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PASILYO", cat = {"all"}},
    {name = "PASSACAGLIA", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PASSACAGLIA", cat = {"all"}},
    {name = "PASSO BEM SOLTO", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PASSO_BEM_SOLTO", cat = {"all"}},
    {name = "PAST LIVES", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PAST_LIVES", cat = {"all"}},
    {name = "PATHETIQUE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PATHETIQUE", cat = {"all"}},
    {name = "PAYPHONE", bpm = 110, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PAYPHONE", cat = {"all"}},
    {name = "PEACHES", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PEACHES", cat = {"all"}},
    {name = "PIANO MAN", bpm = 178, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PIANO_MAN", cat = {"all"}},
    {name = "PIXEL PEEKER POLKA", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PIXEL_PEEKER_POLKA", cat = {"all"}},
    {name = "PLANT VS ZOMBIES", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PLANT_VS_ZOMBIES", cat = {"all"}},
    {name = "PLEAD", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PLEAD", cat = {"all"}},
    {name = "POKEMON", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/POKEMON", cat = {"all"}},
    {name = "POKEMON RED", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/POKEMON_RED", cat = {"all"}},
    {name = "POLONAISE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/POLONAISE", cat = {"all"}},
    {name = "PRAYER", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PRAYER", cat = {"all"}},
    {name = "PRELUDE NO2", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PRELUDE_NO2", cat = {"all"}},
    {name = "PRELUDE OP28", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PRELUDE_OP28", cat = {"all"}},
    {name = "PROPOSE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/PROPOSE", cat = {"all"}},
    {name = "RACING INTO", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RACING_INTO", cat = {"all"}},
    {name = "RACIONAIS 2", bpm = 180, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/racionais%202.txt", cat = {"all"}},
    {name = "RAIN", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RAIN", cat = {"all"}},
    {name = "RANSOM", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RANSOM", cat = {"all"}},
    {name = "RAT DANCE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RAT_DANCE", cat = {"all"}},
    {name = "READY OR NOT", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/READY_OR_NOT", cat = {"all"}},
    {name = "REFLECTIONS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/REFLECTIONS", cat = {"all"}},
    {name = "RENAI CIRCULATION", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RENAI_CIRCULATION", cat = {"all"}},
    {name = "RESONANCE", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RESONANCE", cat = {"all"}},
    {name = "REVENGE", bpm = 140, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/REVENGE", cat = {"all"}},
    {name = "REVOLUTIONARY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/REVOLUTIONARY", cat = {"all"}},
    {name = "RIGHTEOUS", bpm = 140, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RIGHTEOUS", cat = {"all"}},
    {name = "RIPTIDE", bpm = 102, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RIPTIDE", cat = {"all"}},
    {name = "RISES THE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RISES_THE", cat = {"all"}},
    {name = "RISE UP", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RISE_UP", cat = {"all"}},
    {name = "RIVER FLOWS IN YOU", bpm = 72, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RIVER_FLOWS_IN_YOU", cat = {"all"}},
    {name = "ROBBERY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ROBBERY", cat = {"all"}},
    {name = "ROI", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ROI", cat = {"all"}},
    {name = "ROMANTIC HOMICIDE", bpm = 85, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/ROMANTIC_HOMICIDE", cat = {"all"}},
    {name = "RUDER BUSTER", bpm = 130, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUDER_BUSTER", cat = {"all"}},
    {name = "RUDE BUSTER", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUDE_BUSTER", cat = {"all"}},
    {name = "RUE DES TROIS FRERES", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUE_DES_TROIS_FRERES", cat = {"all"}},
    {name = "RUINS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUINS", cat = {"all"}},
    {name = "RUNAWAY", bpm = 87, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUNAWAY", cat = {"all"}},
    {name = "RUNAWAY AURORA", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUNAWAY_AURORA", cat = {"all"}},
    {name = "RUNNING IN THE 90S", bpm = 160, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUNNING_IN_THE_90S", cat = {"all"}},
    {name = "RUNNING UP", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUNNING_UP", cat = {"all"}},
    {name = "RUSH C", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUSH_C", cat = {"all"}},
    {name = "RUSH E", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUSH_E", cat = {"all"}},
    {name = "RUSH F", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUSH_F", cat = {"all"}},
    {name = "RUSH G", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUSH_G", cat = {"all"}},
    {name = "RUSH OF LIFE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/RUSH_OF_LIFE", cat = {"all"}},
    {name = "SADNESS AND SORROW", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SADNESS_AND_SORROW", cat = {"all"}},
    {name = "SAILOR SONG", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SAILOR_SONG", cat = {"all"}},
    {name = "SAITAMAS THEME", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SAITAMAS_THEME", cat = {"all"}},
    {name = "SANS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SANS", cat = {"all"}},
    {name = "SANTA CLAUS IS COMING", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SANTA_CLAUS_IS_COMING", cat = {"all"}},
    {name = "SAVE YOUR", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SAVE_YOUR", cat = {"all"}},
    {name = "SCARLET FOREST", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SCARLET_FOREST", cat = {"all"}},
    {name = "SEE YOU AGAIN", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SEE_YOU_AGAIN", cat = {"all"}},
    {name = "SEE YOU AGAIN CHARLIE", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SEE_YOU_AGAIN_CHARLIE", cat = {"all"}},
    {name = "SERENADE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SERENADE", cat = {"all"}},
    {name = "SHAPE OF", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SHAPE_OF", cat = {"all"}},
    {name = "SHIAWASE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SHIAWASE", cat = {"all"}},
    {name = "SHIKAIRO", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SHIKAIRO", cat = {"all"}},
    {name = "SHINZOU WO SASEGEYO", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SHINZOU_WO_SASEGEYO", cat = {"all"}},
    {name = "SHOP", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SHOP", cat = {"all"}},
    {name = "SICK OF U", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SICK_OF_U", cat = {"all"}},
    {name = "SILHOUETTE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SILHOUETTE", cat = {"all"}},
    {name = "SILLY BILLY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SILLY_BILLY", cat = {"all"}},
    {name = "SINKING TOWN", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SINKING_TOWN", cat = {"all"}},
    {name = "SKELETAL SHENANIGANS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SKELETAL_SHENANIGANS", cat = {"all"}},
    {name = "SKYFALL", bpm = 75, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SKYFALL", cat = {"all"}},
    {name = "SLAY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SLAY", cat = {"all"}},
    {name = "SLOW DANCING IN", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SLOW_DANCING_IN", cat = {"all"}},
    {name = "SNOWFALL", bpm = 70, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SNOWFALL", cat = {"all"}},
    {name = "SNOWMAN", bpm = 105, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SNOWMAN", cat = {"all"}},
    {name = "SNOWY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SNOWY", cat = {"all"}},
    {name = "SOLAS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SOLAS", cat = {"all"}},
    {name = "SOMEBODY THAT I USED", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SOMEBODY_THAT_I_USED", cat = {"all"}},
    {name = "SOMETHING JUST", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SOMETHING_JUST", cat = {"all"}},
    {name = "SONG THAT MIGHT", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SONG_THAT_MIGHT", cat = {"all"}},
    {name = "SOVIET UNION ANTHEM", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SOVIET_UNION_ANTHEM", cat = {"all"}},
    {name = "SPACE SONG", bpm = 147, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPACE_SONG", cat = {"all"}},
    {name = "SPARKLE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPARKLE", cat = {"all"}},
    {name = "SPAWN", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPAWN", cat = {"all"}},
    {name = "SPEAR OF", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPEAR_OF", cat = {"all"}},
    {name = "SPECIALZ", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPECIALZ", cat = {"all"}},
    {name = "SPECTRE", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPECTRE", cat = {"all"}},
    {name = "SPEED OF", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPEED_OF", cat = {"all"}},
    {name = "SPIDER DANCE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPIDER_DANCE", cat = {"all"}},
    {name = "SPOOKY SCARY SKELETONS", bpm = 200, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPOOKY_SCARY_SKELETONS", cat = {"all"}},
    {name = "SPRING", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SPRING", cat = {"all"}},
    {name = "STAY", bpm = 102, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STAY", cat = {"all"}},
    {name = "STAYIN ALIVE", bpm = 102, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STAYIN_ALIVE", cat = {"all"}},
    {name = "STEREO HEARTS", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STEREO_HEARTS", cat = {"all"}},
    {name = "STEREO LOVE", bpm = 127, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STEREO_LOVE", cat = {"all"}},
    {name = "STEREO MADNESS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STEREO_MADNESS", cat = {"all"}},
    {name = "STILL DRE", bpm = 93, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STILL_DRE", cat = {"all"}},
    {name = "STRANGERS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STRANGERS", cat = {"all"}},
    {name = "STRANGER THINGS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STRANGER_THINGS", cat = {"all"}},
    {name = "STRESSED OUT", bpm = 170, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/STRESSED_OUT", cat = {"all"}},
    {name = "SUBWOOFER", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SUBWOOFER", cat = {"all"}},
    {name = "SUGAR PLUM", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SUGAR_PLUM", cat = {"all"}},
    {name = "SUMMER", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SUMMER", cat = {"all"}},
    {name = "SUNFLOWER", bpm = 90, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SUNFLOWER", cat = {"all"}},
    {name = "SUPER IDOL", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SUPER_IDOL", cat = {"all"}},
    {name = "SUPER MARIOS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SUPER_MARIOS", cat = {"all"}},
    {name = "SUPER SMASH BROS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SUPER_SMASH_BROS", cat = {"all"}},
    {name = "SURVIVE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SURVIVE", cat = {"all"}},
    {name = "SUZUME", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SUZUME", cat = {"all"}},
    {name = "SWAN LAKE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SWAN_LAKE", cat = {"all"}},
    {name = "SWEATER WEATHER", bpm = 124, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SWEATER_WEATHER", cat = {"all"}},
    {name = "SWEDEN", bpm = 80, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SWEDEN", cat = {"all"}},
    {name = "SWEET DREAMS", bpm = 125, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SWEET_DREAMS", cat = {"all"}},
    {name = "SWIMMING", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SWIMMING", cat = {"all"}},
    {name = "SYMPHONY NO5", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/SYMPHONY_NO5", cat = {"all"}},
    {name = "TAKE FIVE", bpm = 176, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/TAKE_FIVE", cat = {"all"}},
    {name = "TAKE ON ME", bpm = 169, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/TAKE_ON_ME", cat = {"all"}},
    {name = "TEK IT", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/TEK_IT", cat = {"all"}},
    {name = "TEST DRIVE", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/TEST_DRIVE", cat = {"all"}},
    {name = "THANG DIEN", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/THANG_DIEN", cat = {"all"}},
    {name = "THATS WHAT I WANT", bpm = 150, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/THATS_WHAT_I_WANT", cat = {"all"}},
    {name = "THE INTERESTELLAR EXPERIENCE", bpm = 100, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/the%20interestellar%20experience.txt", cat = {"all"}},
    {name = "THE ABYSS", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/THE_ABYSS", cat = {"all"}},
    {name = "THE AMAZING DIGITAL", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/THE_AMAZING_DIGITAL", cat = {"all"}},
    {name = "TOY STORY", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/toy%20story.txt", cat = {"all"}},
    {name = "TWD", bpm = 195, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/twd.txt", cat = {"all"}},
    {name = "WILDFLOWER", bpm = 120, url = "https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/SONGS/wildflower.txt", cat = {"all"}},
}

    table.sort(songs, function(a, b) return a.name:lower() < b.name:lower() end)

    local categories = {
        "favoritas", "new", "peak", "best", "epic", "beautiful", "video games", "movies/tv", "memes",
        "classical", "pop/hiphop", "anime/jpop", "sad", "electronic", "rock", "creepy/weirdcore"
    }

    -- FunÃƒÂ§ÃƒÂ£o para tocar mÃƒÂºsica

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

        local userInfoText = string.format("Nome de ExibiÃƒÂ§ÃƒÂ£o: %s\nNome de UsuÃƒÂ¡rio: %s\nIdade da Conta: %d anos", player.DisplayName, player.Name, accountAge)

        createInfoBox("InformaÃƒÂ§ÃƒÂµes do UsuÃƒÂ¡rio", userInfoText, 110)

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
        search.PlaceholderText = "Ã°Å¸â€Â Procurar mÃƒÂºsica... (BotÃƒÂ£o Direito para Favoritar)"
        search.Text = ""
        search.Font = Enum.Font.GothamMedium
        search.TextSize = 14
        search.TextColor3 = Color3.new(1, 1, 1)
        search.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Instance.new("UICorner", search).CornerRadius = UDim.new(0, 6)
        
        local searchStroke = Instance.new("UIStroke", search)
        searchStroke.Color = Color3.fromRGB(60, 60, 75)
        searchStroke.Thickness = 1

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
                elseif currentCategory == "favoritas" then
                    if isFavorite(song.name) then show = true end
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
                    local favIcon = isFavorite(song.name) and "Ã¢Ëœâ€¦ " or "Ã¢Ëœâ€  "
                    btn.Text = favIcon .. song.name
                    btn.Size = UDim2.new(1, 0, 0, 40)
                    btn.LayoutOrder = layoutOrder
                    applyButtonStyle(btn)
                    
                    btn.MouseButton1Click:Connect(function()
                        print("LUCIGUI: Tocar mÃƒÂºsica:", song.name)
                        playSong(song, song.bpm)
                    end)
                    
                    btn.MouseButton2Click:Connect(function()
                        toggleFavorite(song.name)
                        filterAndRender()
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

-- Executa a funÃƒÂ§ÃƒÂ£o principal

local ok, err = pcall(runHub)

if not ok then

    warn("LUCIGUI: ERRO CRÃƒÂTICO AO INICIAR: " .. tostring(err))

end

