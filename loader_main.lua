-- Copyright (C) 2025 Lúcifer Scripts
-- Licensed under the GNU GPL v3. See LICENSE file for details.

_G.STOPIT = true

local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/notif_lib.lua"))()

function playSound(soundId, loudness)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Parent = game.Players.LocalPlayer.Character or game.Players.LocalPlayer
    sound.Volume = loudness or 1
    sound:Play()
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/load.lua", true))()

-- GUI OTIMIZADA PARA ROBLOX
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LuciferScriptsGUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- FRAME PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderColor3 = Color3.fromRGB(138, 43, 226)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 220)
MainFrame.ZIndex = 10

-- CORNER PRINCIPAL
local MainCorner = Instance.new("UICorner")
MainCorner.Name = "MainCorner"
MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 20)

-- BARRA DE TÍTULO
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
TitleBar.BorderSizePixel = 0
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.ZIndex = 11

-- CORNER DA BARRA DE TÍTULO
local TitleCorner = Instance.new("UICorner")
TitleCorner.Name = "TitleCorner"
TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0, 20)

-- TÍTULO
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1
TitleLabel.BorderSizePixel = 0
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "🎵 Lúcifer Scripts"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true
TitleLabel.TextSize = 18
TitleLabel.TextWrapped = true
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- CONTAINER DE CONTROLES
local ControlContainer = Instance.new("Frame")
ControlContainer.Name = "ControlContainer"
ControlContainer.Parent = MainFrame
ControlContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ControlContainer.BorderSizePixel = 0
ControlContainer.Position = UDim2.new(0, 10, 0, 55)
ControlContainer.Size = UDim2.new(1, -20, 0, 60)
ControlContainer.ZIndex = 9

-- CORNER DO CONTAINER
local ControlCorner = Instance.new("UICorner")
ControlCorner.Name = "ControlCorner"
ControlCorner.Parent = ControlContainer
ControlCorner.CornerRadius = UDim.new(0, 15)

-- BOTÃO PAUSE
local PauseButton = Instance.new("ImageButton")
PauseButton.Name = "PauseButton"
PauseButton.Parent = ControlContainer
PauseButton.BackgroundColor3 = Color3.fromRGB(75, 75, 100)
PauseButton.BackgroundTransparency = 0.1
PauseButton.BorderColor3 = Color3.fromRGB(138, 43, 226)
PauseButton.BorderSizePixel = 1
PauseButton.Position = UDim2.new(0, 10, 0, 10)
PauseButton.Size = UDim2.new(0, 40, 0, 40)
PauseButton.Image = "http://www.roblox.com/asset/?id=86903979265676"
PauseButton.ZIndex = 12

-- CORNER DO BOTÃO PAUSE
local PauseCorner = Instance.new("UICorner")
PauseCorner.Name = "PauseCorner"
PauseCorner.Parent = PauseButton
PauseCorner.CornerRadius = UDim.new(0, 8)

-- BOTÃO STOP
local StopButton = Instance.new("ImageButton")
StopButton.Name = "StopButton"
StopButton.Parent = ControlContainer
StopButton.BackgroundColor3 = Color3.fromRGB(75, 75, 100)
StopButton.BackgroundTransparency = 0.1
StopButton.BorderColor3 = Color3.fromRGB(138, 43, 226)
StopButton.BorderSizePixel = 1
StopButton.Position = UDim2.new(0, 60, 0, 10)
StopButton.Size = UDim2.new(0, 40, 0, 40)
StopButton.Image = "http://www.roblox.com/asset/?id=99665585363395"
StopButton.ZIndex = 12

-- CORNER DO BOTÃO STOP
local StopCorner = Instance.new("UICorner")
StopCorner.Name = "StopCorner"
StopCorner.Parent = StopButton
StopCorner.CornerRadius = UDim.new(0, 8)

-- CONTAINER BPM
local BpmContainer = Instance.new("Frame")
BpmContainer.Name = "BpmContainer"
BpmContainer.Parent = ControlContainer
BpmContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
BpmContainer.BorderSizePixel = 0
BpmContainer.Position = UDim2.new(0, 120, 0, 10)
BpmContainer.Size = UDim2.new(0, 120, 0, 40)
BpmContainer.ZIndex = 11

-- CORNER DO BPM CONTAINER
local BpmCorner = Instance.new("UICorner")
BpmCorner.Name = "BpmCorner"
BpmCorner.Parent = BpmContainer
BpmCorner.CornerRadius = UDim.new(0, 8)

-- TEXTO BPM
local BpmText = Instance.new("TextLabel")
BpmText.Name = "BpmText"
BpmText.Parent = BpmContainer
BpmText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BpmText.BackgroundTransparency = 1
BpmText.BorderSizePixel = 0
BpmText.Position = UDim2.new(0, 25, 0, 0)
BpmText.Size = UDim2.new(0, 70, 1, 0)
BpmText.Font = Enum.Font.GothamBold
BpmText.Text = "BPM: 120"
BpmText.TextColor3 = Color3.fromRGB(255, 255, 255)
BpmText.TextScaled = true
BpmText.TextSize = 14
BpmText.TextWrapped = true

-- BOTÃO AUMENTAR BPM
local UpBpmButton = Instance.new("TextButton")
UpBpmButton.Name = "UpBpmButton"
UpBpmButton.Parent = BpmContainer
UpBpmButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
UpBpmButton.BorderSizePixel = 0
UpBpmButton.Position = UDim2.new(0, 5, 0, 5)
UpBpmButton.Size = UDim2.new(0, 15, 0, 15)
UpBpmButton.Font = Enum.Font.GothamBold
UpBpmButton.Text = "▲"
UpBpmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpBpmButton.TextScaled = true
UpBpmButton.ZIndex = 13

-- CORNER DO BOTÃO AUMENTAR BPM
local UpBpmCorner = Instance.new("UICorner")
UpBpmCorner.Name = "UpBpmCorner"
UpBpmCorner.Parent = UpBpmButton
UpBpmCorner.CornerRadius = UDim.new(0, 3)

-- BOTÃO DIMINUIR BPM
local DownBpmButton = Instance.new("TextButton")
DownBpmButton.Name = "DownBpmButton"
DownBpmButton.Parent = BpmContainer
DownBpmButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
DownBpmButton.BorderSizePixel = 0
DownBpmButton.Position = UDim2.new(0, 5, 0, 20)
DownBpmButton.Size = UDim2.new(0, 15, 0, 15)
DownBpmButton.Font = Enum.Font.GothamBold
DownBpmButton.Text = "▼"
DownBpmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DownBpmButton.TextScaled = true
DownBpmButton.ZIndex = 13

-- CORNER DO BOTÃO DIMINUIR BPM
local DownBpmCorner = Instance.new("UICorner")
DownBpmCorner.Name = "DownBpmCorner"
DownBpmCorner.Parent = DownBpmButton
DownBpmCorner.CornerRadius = UDim.new(0, 3)

-- CONTAINER ERROR MARGIN
local ErrorContainer = Instance.new("Frame")
ErrorContainer.Name = "ErrorContainer"
ErrorContainer.Parent = ControlContainer
ErrorContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
ErrorContainer.BorderSizePixel = 0
ErrorContainer.Position = UDim2.new(0, 250, 0, 10)
ErrorContainer.Size = UDim2.new(0, 130, 0, 40)
ErrorContainer.ZIndex = 11

-- CORNER DO ERROR CONTAINER
local ErrorCorner = Instance.new("UICorner")
ErrorCorner.Name = "ErrorCorner"
ErrorCorner.Parent = ErrorContainer
ErrorCorner.CornerRadius = UDim.new(0, 8)

-- TEXTO ERROR MARGIN
local ErrorText = Instance.new("TextLabel")
ErrorText.Name = "ErrorText"
ErrorText.Parent = ErrorContainer
ErrorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ErrorText.BackgroundTransparency = 1
ErrorText.BorderSizePixel = 0
ErrorText.Position = UDim2.new(0, 35, 0, 0)
ErrorText.Size = UDim2.new(0, 80, 1, 0)
ErrorText.Font = Enum.Font.GothamBold
ErrorText.Text = "Error: 0.00"
ErrorText.TextColor3 = Color3.fromRGB(255, 255, 255)
ErrorText.TextScaled = true
ErrorText.TextSize = 12
ErrorText.TextWrapped = true

-- BOTÃO AUMENTAR ERROR
local UpErrorButton = Instance.new("TextButton")
UpErrorButton.Name = "UpErrorButton"
UpErrorButton.Parent = ErrorContainer
UpErrorButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
UpErrorButton.BorderSizePixel = 0
UpErrorButton.Position = UDim2.new(0, 5, 0, 5)
UpErrorButton.Size = UDim2.new(0, 15, 0, 15)
UpErrorButton.Font = Enum.Font.GothamBold
UpErrorButton.Text = "▲"
UpErrorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpErrorButton.TextScaled = true
UpErrorButton.ZIndex = 13

-- CORNER DO BOTÃO AUMENTAR ERROR
local UpErrorCorner = Instance.new("UICorner")
UpErrorCorner.Name = "UpErrorCorner"
UpErrorCorner.Parent = UpErrorButton
UpErrorCorner.CornerRadius = UDim.new(0, 3)

-- BOTÃO DIMINUIR ERROR
local DownErrorButton = Instance.new("TextButton")
DownErrorButton.Name = "DownErrorButton"
DownErrorButton.Parent = ErrorContainer
DownErrorButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
DownErrorButton.BorderSizePixel = 0
DownErrorButton.Position = UDim2.new(0, 5, 0, 20)
DownErrorButton.Size = UDim2.new(0, 15, 0, 15)
DownErrorButton.Font = Enum.Font.GothamBold
DownErrorButton.Text = "▼"
DownErrorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DownErrorButton.TextScaled = true
DownErrorButton.ZIndex = 13

-- CORNER DO BOTÃO DIMINUIR ERROR
local DownErrorCorner = Instance.new("UICorner")
DownErrorCorner.Name = "DownErrorCorner"
DownErrorCorner.Parent = DownErrorButton
DownErrorCorner.CornerRadius = UDim.new(0, 3)

-- BARRA DE PROGRESSO
local ProgressContainer = Instance.new("Frame")
ProgressContainer.Name = "ProgressContainer"
ProgressContainer.Parent = MainFrame
ProgressContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
ProgressContainer.BorderSizePixel = 0
ProgressContainer.Position = UDim2.new(0, 20, 0, 130)
ProgressContainer.Size = UDim2.new(0, 360, 0, 30)
ProgressContainer.ZIndex = 9

-- CORNER DA BARRA DE PROGRESSO
local ProgressCorner = Instance.new("UICorner")
ProgressCorner.Name = "ProgressCorner"
ProgressCorner.Parent = ProgressContainer
ProgressCorner.CornerRadius = UDim.new(0, 15)

-- BARRA DE PROGRESSO FUNDO
local ProgressBar = Instance.new("Frame")
ProgressBar.Name = "ProgressBar"
ProgressBar.Parent = ProgressContainer
ProgressBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ProgressBar.BorderSizePixel = 0
ProgressBar.Position = UDim2.new(0, 5, 0, 5)
ProgressBar.Size = UDim2.new(0, 350, 0, 20)
ProgressBar.ZIndex = 10

-- CORNER DA PROGRESS BAR
local ProgressBgCorner = Instance.new("UICorner")
ProgressBgCorner.Name = "ProgressBgCorner"
ProgressBgCorner.Parent = ProgressBar
ProgressBgCorner.CornerRadius = UDim.new(0, 10)

-- PREENCHIMENTO DA PROGRESS BAR
local ProgressFill = Instance.new("Frame")
ProgressFill.Name = "ProgressFill"
ProgressFill.Parent = ProgressBar
ProgressFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
ProgressFill.BorderSizePixel = 0
ProgressFill.Position = UDim2.new(0, 0, 0, 0)
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.ZIndex = 11

-- CORNER DO PREENCHIMENTO
local FillCorner = Instance.new("UICorner")
FillCorner.Name = "FillCorner"
FillCorner.Parent = ProgressFill
FillCorner.CornerRadius = UDim.new(0, 10)

-- INDICADOR DE PROGRESSO
local Playhead = Instance.new("Frame")
Playhead.Name = "Playhead"
Playhead.Parent = ProgressBar
Playhead.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Playhead.BorderSizePixel = 0
Playhead.Position = UDim2.new(0, -8, 0.5, -8)
Playhead.Size = UDim2.new(0, 16, 0, 16)
Playhead.ZIndex = 12

-- CORNER DO PLAYHEAD
local PlayheadCorner = Instance.new("UICorner")
PlayheadCorner.Name = "PlayheadCorner"
PlayheadCorner.Parent = Playhead
PlayheadCorner.CornerRadius = UDim.new(1, 0)

-- TEXTO DE STATUS
local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Parent = MainFrame
StatusText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StatusText.BackgroundTransparency = 1
StatusText.BorderSizePixel = 0
StatusText.Position = UDim2.new(0, 20, 0, 170)
StatusText.Size = UDim2.new(0, 360, 0, 30)
StatusText.Font = Enum.Font.Gotham
StatusText.Text = "🎹 Lúcifer Scripts - Ready to Play"
StatusText.TextColor3 = Color3.fromRGB(200, 200, 255)
StatusText.TextScaled = true
StatusText.TextSize = 14
StatusText.TextWrapped = true

-- EFEITO DE BRILHO
local GlowEffect = Instance.new("Frame")
GlowEffect.Name = "GlowEffect"
GlowEffect.Parent = MainFrame
GlowEffect.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
GlowEffect.BorderSizePixel = 0
GlowEffect.Position = UDim2.new(0, -10, 0, -10)
GlowEffect.Size = UDim2.new(1, 20, 1, 20)
GlowEffect.BackgroundTransparency = 0.85
GlowEffect.ZIndex = 8

-- CORNER DO BRILHO
local GlowCorner = Instance.new("UICorner")
GlowCorner.Name = "GlowCorner"
GlowCorner.Parent = GlowEffect
GlowCorner.CornerRadius = UDim.new(0, 25)

-- SISTEMA DE DRAG OTIMIZADO
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local dragging = false
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        -- Animação de feedback
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.1), {Size = UDim2.new(0, 410, 0, 230)})
        tween:Play()
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        
        -- Animação de feedback
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.1), {Size = UDim2.new(0, 400, 0, 220)})
        tween:Play()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- VARIÁVEIS GLOBAIS
local song = {}
local songThread = nil
local finishedLoading = false
local pausing = false
local bpm = 120
local errormargin = 0
local currentSongPosition = 0
local totalSongBeats = 0
local songisplaying = false

-- FUNÇÕES DE ATUALIZAÇÃO DE UI
local function updateBpmText()
    BpmText.Text = "BPM: " .. tostring(bpm)
end

local function updateErrorText()
    ErrorText.Text = "Error: " .. string.format("%.2f", errormargin)
end

local function updateStatus(text)
    StatusText.Text = "🎹 " .. text
end

local function updateProgress()
    if totalSongBeats > 0 then
        local percentage = math.clamp(currentSongPosition / totalSongBeats, 0, 1)
        ProgressFill:TweenSize(UDim2.new(percentage, 0, 1, 0), "Out", "Quad", 0.1)
        Playhead:TweenPosition(UDim2.new(percentage, -8, 0.5, -8), "Out", "Quad", 0.1)
    end
end

-- FUNÇÕES DE CONTROLE
local function pauseSong()
    pausing = not pausing
    if pausing then
        PauseButton.Image = "http://www.roblox.com/asset/?id=130610056660845"
        updateStatus("Paused - Lúcifer Scripts")
    else
        PauseButton.Image = "http://www.roblox.com/asset/?id=86903979265676"
        updateStatus("Playing - Lúcifer Scripts")
    end
end

local function stopSong()
    _G.STOPIT = true
    songisplaying = false
    pausing = false
    PauseButton.Image = "http://www.roblox.com/asset/?id=86903979265676"
    updateStatus("Stopped - Lúcifer Scripts")
    ProgressFill:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.3)
    Playhead:TweenPosition(UDim2.new(0, -8, 0.5, -8), "Out", "Quad", 0.3)
    playSound("18595195017", 0.5)
    NotificationLibrary:SendNotification("Success", "Song stopped", 1)
end

-- EVENTOS DOS BOTÕES
PauseButton.MouseButton1Click:Connect(pauseSong)
StopButton.MouseButton1Click:Connect(stopSong)

UpBpmButton.MouseButton1Click:Connect(function()
    bpm = bpm + 10
    updateBpmText()
end)

DownBpmButton.MouseButton1Click:Connect(function()
    bpm = math.max(10, bpm - 10)
    updateBpmText()
end)

UpErrorButton.MouseButton1Click:Connect(function()
    errormargin = math.min(1, errormargin + 0.01)
    updateErrorText()
end)

DownErrorButton.MouseButton1Click:Connect(function()
    errormargin = math.max(0, errormargin - 0.01)
    updateErrorText()
end)

-- FUNÇÕES DE MÚSICA (OTIMIZADAS)
local VirtualInputManager = game:GetService("VirtualInputManager")

local keyMappings = {
    ["1"] = Enum.KeyCode.One, ["!"] = Enum.KeyCode.One, ["2"] = Enum.KeyCode.Two, ["@"] = Enum.KeyCode.Two,
    ["3"] = Enum.KeyCode.Three, ["#"] = Enum.KeyCode.Three, ["4"] = Enum.KeyCode.Four, ["$"] = Enum.KeyCode.Four,
    ["5"] = Enum.KeyCode.Five, ["%"] = Enum.KeyCode.Five, ["6"] = Enum.KeyCode.Six, ["^"] = Enum.KeyCode.Six,
    ["7"] = Enum.KeyCode.Seven, ["&"] = Enum.KeyCode.Seven, ["8"] = Enum.KeyCode.Eight, ["*"] = Enum.KeyCode.Eight,
    ["9"] = Enum.KeyCode.Nine, ["("] = Enum.KeyCode.Nine, ["0"] = Enum.KeyCode.Zero, [")"] = Enum.KeyCode.Zero,
    ["q"] = Enum.KeyCode.Q, ["Q"] = Enum.KeyCode.Q, ["w"] = Enum.KeyCode.W, ["W"] = Enum.KeyCode.W,
    ["e"] = Enum.KeyCode.E, ["E"] = Enum.KeyCode.E, ["r"] = Enum.KeyCode.R, ["R"] = Enum.KeyCode.R,
    ["t"] = Enum.KeyCode.T, ["T"] = Enum.KeyCode.T, ["y"] = Enum.KeyCode.Y, ["Y"] = Enum.KeyCode.Y,
    ["u"] = Enum.KeyCode.U, ["U"] = Enum.KeyCode.U, ["i"] = Enum.KeyCode.I, ["I"] = Enum.KeyCode.I,
    ["o"] = Enum.KeyCode.O, ["O"] = Enum.KeyCode.O, ["p"] = Enum.KeyCode.P, ["P"] = Enum.KeyCode.P,
    ["a"] = Enum.KeyCode.A, ["A"] = Enum.KeyCode.A, ["s"] = Enum.KeyCode.S, ["S"] = Enum.KeyCode.S,
    ["d"] = Enum.KeyCode.D, ["D"] = Enum.KeyCode.D, ["f"] = Enum.KeyCode.F, ["F"] = Enum.KeyCode.F,
    ["g"] = Enum.KeyCode.G, ["G"] = Enum.KeyCode.G, ["h"] = Enum.KeyCode.H, ["H"] = Enum.KeyCode.H,
    ["j"] = Enum.KeyCode.J, ["J"] = Enum.KeyCode.J, ["k"] = Enum.KeyCode.K, ["K"] = Enum.KeyCode.K,
    ["l"] = Enum.KeyCode.L, ["L"] = Enum.KeyCode.L, ["z"] = Enum.KeyCode.Z, ["Z"] = Enum.KeyCode.Z,
    ["x"] = Enum.KeyCode.X, ["X"] = Enum.KeyCode.X, ["c"] = Enum.KeyCode.C, ["C"] = Enum.KeyCode.C,
    ["v"] = Enum.KeyCode.V, ["V"] = Enum.KeyCode.V, ["b"] = Enum.KeyCode.B, ["B"] = Enum.KeyCode.B,
    ["n"] = Enum.KeyCode.N, ["N"] = Enum.KeyCode.N, ["m"] = Enum.KeyCode.M, ["M"] = Enum.KeyCode.M
}

local function pressKey(keys, beats, bpm)
    if _G.STOPIT then return end
    
    for i = 1, #keys do
        local key = keys:sub(i, i)
        local keyCode = keyMappings[key]
        
        if keyCode then
            coroutine.wrap(function()
                VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
                task.wait((beats / bpm) * 60 * 0.8)
                VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
            end)()
        end
    end
end

function keypress(keys, beats, bpm)
    table.insert(song, {
        type = "keypress",
        keys = keys,
        beats = beats
    })
end

function rest(beats, bpm)
    table.insert(song, {
        type = "rest",
        beats = beats
    })
end

function finishedSong()
    table.insert(song, {
        type = "finishedSong"
    })
    finishedLoading = true
end

-- INICIALIZAÇÃO
updateBpmText()
updateErrorText()
updateStatus("Ready - Lúcifer Scripts")

-- LOOP PRINCIPAL OTIMIZADO
_G.STOPIT = false

songThread = task.spawn(function()
    repeat task.wait() until finishedLoading == true
    
    -- Calcular total de beats
    totalSongBeats = 0
    for _, action in pairs(song) do
        if action.type == "rest" then
            totalSongBeats = totalSongBeats + action.beats
        end
    end
    
    currentSongPosition = 0
    updateStatus("Playing - Lúcifer Scripts")
    songisplaying = true
    
    for i = 1, #song do
        if _G.STOPIT then break end
        
        while pausing do
            task.wait(0.1)
        end
        
        local action = song[i]
        
        if action.type == "keypress" then
            pressKey(action.keys, action.beats, bpm)
        elseif action.type == "rest" then
            local waitTime = (action.beats / bpm) * 60
            task.wait(waitTime)
            currentSongPosition = currentSongPosition + action.beats
            updateProgress()
        elseif action.type == "finishedSong" then
            updateStatus("Song Finished - Lúcifer Scripts")
            playSound("18595195017", 0.5)
            NotificationLibrary:SendNotification("Success", "Song completed!", 3)
            songisplaying = false
            break
        end
    end
end)

-- WATCHER OTIMIZADO
task.spawn(function()
    while task.wait(0.1) do
        if _G.STOPIT then
            song = {}
            if songThread then
                task.cancel(songThread)
            end
            break
        end
    end
end)

-- ANIMAÇÃO DE ENTRADA
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame:TweenSize(UDim2.new(0, 400, 0, 220), "Out", "Back", 0.5, true)
