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

x = "hi"

loadstring(game:HttpGet("https://raw.githubusercontent.com/5365370665926114/lucigui/refs/heads/main/load.lua", true))()

-- Gui to Lua
-- Version: 3.2

-- Instances:

local luciferGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local titleBar = Instance.new("Frame")
local UICorner_Title = Instance.new("UICorner")
local titleLabel = Instance.new("TextLabel")
local pauseButton = Instance.new("ImageButton")
local stopButton = Instance.new("ImageButton")
local bpmText = Instance.new("TextLabel")
local upBpm = Instance.new("TextButton")
local downBpm = Instance.new("TextButton")
local errorBox = Instance.new("TextLabel")
local less = Instance.new("TextButton")
local more = Instance.new("TextButton")
local info = Instance.new("TextLabel")
local progressBar = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local progressFill = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local playhead = Instance.new("ImageButton")
local UICorner_4 = Instance.new("UICorner")
local glowEffect = Instance.new("Frame")

--Properties:

luciferGui.Name = "luciferGui"
luciferGui.Parent = game:GetService("CoreGui")
luciferGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

mainFrame.Name = "mainFrame"
mainFrame.Parent = luciferGui
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderColor3 = Color3.fromRGB(75, 0, 130)
mainFrame.BorderSizePixel = 2
mainFrame.Position = UDim2.new(0.5, 0, 0.513671875, 0)
mainFrame.Size = UDim2.new(0, 350, 0, 180)

UICorner.Parent = mainFrame
UICorner.CornerRadius = UDim.new(0, 15)

titleBar.Name = "titleBar"
titleBar.Parent = mainFrame
titleBar.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
titleBar.BorderSizePixel = 0
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.Size = UDim2.new(1, 0, 0, 35)

UICorner_Title.Parent = titleBar
UICorner_Title.CornerRadius = UDim.new(0, 15)

titleLabel.Name = "titleLabel"
titleLabel.Parent = titleBar
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1.000
titleLabel.BorderSizePixel = 0
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Lúcifer Scripts"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.TextSize = 14.000
titleLabel.TextWrapped = true
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

pauseButton.Name = "pauseButton"
pauseButton.Parent = mainFrame
pauseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
pauseButton.BackgroundTransparency = 0.200
pauseButton.BorderColor3 = Color3.fromRGB(128, 0, 255)
pauseButton.BorderSizePixel = 1
pauseButton.Position = UDim2.new(0.05, 0, 0.22, 0)
pauseButton.Size = UDim2.new(0, 50, 0, 50)
pauseButton.Image = "http://www.roblox.com/asset/?id=86903979265676"

stopButton.Name = "stopButton"
stopButton.Parent = mainFrame
stopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
stopButton.BackgroundTransparency = 0.200
stopButton.BorderColor3 = Color3.fromRGB(128, 0, 255)
stopButton.BorderSizePixel = 1
stopButton.Position = UDim2.new(0.22, 0, 0.22, 0)
stopButton.Size = UDim2.new(0, 50, 0, 50)
stopButton.Image = "http://www.roblox.com/asset/?id=99665585363395"

bpmText.Name = "bpmText"
bpmText.Parent = mainFrame
bpmText.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
bpmText.BorderColor3 = Color3.fromRGB(128, 0, 255)
bpmText.BorderSizePixel = 1
bpmText.Position = UDim2.new(0.45, 0, 0.22, 8)
bpmText.Size = UDim2.new(0, 120, 0, 34)
bpmText.Font = Enum.Font.GothamBold
bpmText.Text = "BPM: nil"
bpmText.TextColor3 = Color3.fromRGB(255, 255, 255)
bpmText.TextScaled = true
bpmText.TextSize = 14.000
bpmText.TextWrapped = true

upBpm.Name = "upBpm"
upBpm.Parent = mainFrame
upBpm.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
upBpm.BackgroundTransparency = 0.200
upBpm.BorderColor3 = Color3.fromRGB(128, 0, 255)
upBpm.BorderSizePixel = 1
upBpm.Position = UDim2.new(0.37, 0, 0.22, 8)
upBpm.Size = UDim2.new(0, 34, 0, 34)
upBpm.Font = Enum.Font.GothamBold
upBpm.Text = "▲"
upBpm.TextColor3 = Color3.fromRGB(255, 255, 255)
upBpm.TextScaled = true
upBpm.TextSize = 14.000
upBpm.TextWrapped = true

downBpm.Name = "downBpm"
downBpm.Parent = mainFrame
downBpm.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
downBpm.BackgroundTransparency = 0.200
downBpm.BorderColor3 = Color3.fromRGB(128, 0, 255)
downBpm.BorderSizePixel = 1
downBpm.Position = UDim2.new(0.82, 0, 0.22, 8)
downBpm.Size = UDim2.new(0, 34, 0, 34)
downBpm.Font = Enum.Font.GothamBold
downBpm.Text = "▼"
downBpm.TextColor3 = Color3.fromRGB(255, 255, 255)
downBpm.TextScaled = true
downBpm.TextSize = 14.000
downBpm.TextWrapped = true

errorBox.Name = "errorBox"
errorBox.Parent = mainFrame
errorBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
errorBox.BorderColor3 = Color3.fromRGB(128, 0, 255)
errorBox.BorderSizePixel = 1
errorBox.Position = UDim2.new(0.05, 0, 0.55, 0)
errorBox.Size = UDim2.new(0, 120, 0, 31)
errorBox.Font = Enum.Font.GothamBold
errorBox.Text = "error margin: 0.00"
errorBox.TextColor3 = Color3.fromRGB(255, 255, 255)
errorBox.TextScaled = true
errorBox.TextSize = 14.000
errorBox.TextWrapped = true

less.Name = "less"
less.Parent = mainFrame
less.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
less.BackgroundTransparency = 0.200
less.BorderColor3 = Color3.fromRGB(128, 0, 255)
less.BorderSizePixel = 1
less.Position = UDim2.new(0.41, 0, 0.55, 0)
less.Size = UDim2.new(0, 31, 0, 30)
less.Font = Enum.Font.GothamBold
less.Text = "▼"
less.TextColor3 = Color3.fromRGB(255, 255, 255)
less.TextScaled = true
less.TextSize = 14.000
less.TextWrapped = true

more.Name = "more"
more.Parent = mainFrame
more.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
more.BackgroundTransparency = 0.200
more.BorderColor3 = Color3.fromRGB(128, 0, 255)
more.BorderSizePixel = 1
more.Position = UDim2.new(0.47, 0, 0.55, 0)
more.Size = UDim2.new(0, 31, 0, 30)
more.Font = Enum.Font.GothamBold
more.Text = "▲"
more.TextColor3 = Color3.fromRGB(255, 255, 255)
more.TextScaled = true
more.TextSize = 14.000
more.TextWrapped = true

info.Name = "info"
info.Parent = mainFrame
info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
info.BackgroundTransparency = 1.000
info.BorderColor3 = Color3.fromRGB(0, 0, 0)
info.BorderSizePixel = 0
info.Position = UDim2.new(0.52, 0, 0.55, 0)
info.Size = UDim2.new(0, 150, 0, 30)
info.Font = Enum.Font.Gotham
info.Text = "Lúcifer Scripts"
info.TextColor3 = Color3.fromRGB(200, 200, 255)
info.TextScaled = true
info.TextSize = 14.000
info.TextWrapped = true

progressBar.Name = "progressBar"
progressBar.Parent = mainFrame
progressBar.AnchorPoint = Vector2.new(0.5, 0.5)
progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
progressBar.BorderColor3 = Color3.fromRGB(128, 0, 255)
progressBar.BorderSizePixel = 1
progressBar.Position = UDim2.new(0.5, 0, 0.85, 0)
progressBar.Size = UDim2.new(0, 300, 0, 8)

UICorner_2.CornerRadius = UDim.new(0, 5)
UICorner_2.Parent = progressBar

progressFill.Name = "progressFill"
progressFill.Parent = progressBar
progressFill.BackgroundColor3 = Color3.fromRGB(128, 0, 255)
progressFill.BorderSizePixel = 0
progressFill.Size = UDim2.new(0, 0, 1, 0)

UICorner_3.CornerRadius = UDim.new(0, 5)
UICorner_3.Parent = progressFill

playhead.Name = "playhead"
playhead.Parent = progressBar
playhead.AnchorPoint = Vector2.new(0, 0.5)
playhead.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
playhead.BorderSizePixel = 0
playhead.Position = UDim2.new(0, -10, 0.5, 0)
playhead.Size = UDim2.new(0, 12, 0, 12)

UICorner_4.CornerRadius = UDim.new(1, 0)
UICorner_4.Parent = playhead

glowEffect.Name = "glowEffect"
glowEffect.Parent = mainFrame
glowEffect.BackgroundColor3 = Color3.fromRGB(128, 0, 255)
glowEffect.BorderSizePixel = 0
glowEffect.Position = UDim2.new(0, -5, 0, -5)
glowEffect.Size = UDim2.new(1, 10, 1, 10)
glowEffect.BackgroundTransparency = 0.9
glowEffect.ZIndex = -1

local UserInputService = game:GetService("UserInputService")

local gui = mainFrame

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    gui.Position =
        UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(
    function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(
                function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end
            )
        end
    end
)

gui.InputChanged:Connect(
    function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end
)

UserInputService.InputChanged:Connect(
    function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end
)

local song = {}
local songThread
local finishedLoading = false

function stopPlayingSongs()

    print("stopped.")
    _G.STOPIT = true -- indicator for playing functions that tells it to halt.

    function pressKey(keys, beats, bpm)
    end

    function pressnote(note, octave, beats, bpm)
    end

    function rest(beats, bpm)
    end

    function keypress(keys, beats, bpm)
    end

    function keysequence16(keys, beats, bpm)
    end

    function finishedSong()
    end

    function adjustVelocity(h)
    end

    songisplaying = false -- indicator for telling the user they cant play when a song is playing, etc.

    playSound("18595195017", 0.5)
    NotificationLibrary:SendNotification("Success", "stopping...", 1)
    luciferGui:Destroy()
end

function finishedSong()
    table.insert(song, {
        type = "finishedSong"
    })
    finishedLoading = true
end

local function finishedSongtrigger()
    if _G.STOPIT then return end
    playSound("18595195017", 0.5)
    NotificationLibrary:SendNotification("Success", "songfinished", 3)
    songisplaying = false
    luciferGui:Destroy()
    luciferGui = nil
    _G.STOPIT = true
end

local resumeEvent = Instance.new("BindableEvent")

pausing = false

local function pauseSong()
    pausing = not pausing

    if not pausing then
        pauseButton.Image = "http://www.roblox.com/asset/?id=86903979265676"
        resumeEvent:Fire()
    else
        pausing = true
        pauseButton.Image = "http://www.roblox.com/asset/?id/130610056660845"
    end
end

pauseButton.MouseButton1Click:Connect(pauseSong)

stopButton.MouseButton1Click:Connect(stopPlayingSongs)

local function updatebpmtext()
    bpmText.Text = "BPM: " .. tostring(bpm)
end

updatebpmtext()

upBpm.MouseButton1Click:Connect(
    function()
        bpm = bpm + 10
        updatebpmtext()
    end
)

downBpm.MouseButton1Click:Connect(
    function()
        bpm = bpm - 10
        updatebpmtext()
    end
)

if not errormargin then
    errormargin = 0
else
end

local function updateErrorMargin()
    errorBox.Text = "error margin: " .. tostring(errormargin)
end

updateErrorMargin()

local function round(num, decimalPlaces)
    local mult = 10 ^ decimalPlaces
    return math.floor(num * mult + 0.5) / mult
end

more.MouseButton1Click:Connect(
    function()
        errormargin = round(errormargin + 0.005, 3)
        updateErrorMargin()
    end
)

less.MouseButton1Click:Connect(
    function()
        if errormargin <= 0 then
            return
        end
        errormargin = round(errormargin - 0.005, 3)
        updateErrorMargin()
    end
)

VirtualInputManager = game:GetService("VirtualInputManager")

-- PLAYHEAD FUNCTIONS
-- PLAYHEAD FUNCTIONS
-- PLAYHEAD FUNCTIONS

local halted = false
local tempClear = false
local currentSongPosition = 0  -- Current position in beats
local totalSongBeats = 0       -- Total song length in beats
local isDraggingPlayhead = false

local draggingPlayhead = false
local playheadDragStart = nil

local waspaused = false
playhead.InputBegan:Connect(function(input) -- pick up the playhead, pause the song
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        draggingPlayhead = true
        isDraggingPlayhead = true
        
        if pausing == true then waspaused = true else waspaused = false end
        pausing = true
    end
end)

UserInputService.InputEnded:Connect(function(input) -- let go of the playhead, resume the song and call percentage skip func
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        if draggingPlayhead then
            draggingPlayhead = false
            isDraggingPlayhead = false
            
            -- Calculate percentage based on playhead position
            local percentage = (playhead.Position.X.Scale * 100)
            
            if waspaused == false then
                pausing = false
                resumeEvent:Fire()
            else waspaused = false end

            skipToPercentage(percentage)
        end
    end
end)

UserInputService.InputChanged:Connect(function(input) -- dragging the playhead
    if draggingPlayhead and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        
        local mousePos = input.Position
        local barPos = progressBar.AbsolutePosition
        local barSize = progressBar.AbsoluteSize
        
        local relativeX = mousePos.X - barPos.X
        local percentage = math.clamp(relativeX / barSize.X, 0, 1)
        
        playhead.Position = UDim2.new(percentage, -10, 0.5, 0)
        progressFill.Size = UDim2.new(percentage, 0, 1, 0)
    end
end)

local function calculateTotalBeats()
    local totalBeats = 0
    for _, action in pairs(song) do
        if action.type == "rest" then
            totalBeats = totalBeats + action.beats
        end
    end
    return totalBeats
end

function getSkipIndex(percentage) -- function to return the part of the song to skip to based on percentage
    if percentage < 0 or percentage > 100 then
        print("Invalid percentage. Must be 0-100")
        return
    end

    local totalBeats = calculateTotalBeats()
    local targetBeats = (percentage / 100) * totalBeats
    local currentBeats = 0
    local targetIndex = 1
    
    for i, action in pairs(song) do
        if action.type == "rest" then
            currentBeats = currentBeats + action.beats
            if currentBeats >= targetBeats then
                targetIndex = i
                break
            end
        end
    end
    
    return targetIndex
end

local function updatePlayheadVisual()
    if totalSongBeats == 0 then return end
    
    local percentage = currentSongPosition / totalSongBeats
    percentage = math.clamp(percentage, 0, 1)

    playhead.Position = UDim2.new(percentage, -10, 0.5, 0)

    progressFill.Size = UDim2.new(percentage, 0, 1, 0)
end

function skipToPercentage(percentage)
    tempClear = true
    halted = false
    repeat wait() until halted == true
    tempClear = false

    local targetIndex = getSkipIndex(percentage)

    local targetBeats = (percentage / 100) * totalSongBeats
    currentSongPosition = 0

    for i = 1, targetIndex - 1 do
        if song[i].type == "rest" then
            currentSongPosition = currentSongPosition + song[i].beats
        end
    end

    updatePlayheadVisual()

    songThread = task.spawn(function()
        for i = targetIndex, #song do
            if _G.STOPIT or tempClear then halted = true break end
            
            local action = song[i]
            
            if action.type == "keypress" then
                keypresstrigger(action.keys, action.beats, bpm)
            elseif action.type == "rest" then
                resttrigger(action.beats, bpm)
            elseif action.type == "adjustVelocity" then
                adjustVelocitytrigger(action.vel)
            elseif action.type == "pedalDown" then
                pedalDowntrigger()
            elseif action.type == "pedalUp" then
                pedalUptrigger()
            elseif action.type == "finishedSong" then
                finishedSongtrigger()
            elseif action.type == "pressnote" then
                pressnotetrigger(action.note, action.octave, action.beats, bpm)
            end
        end
    end)
end

-- PRESSKEY FUNCTION
-- PRESSKEY FUNCTION
-- PRESSKEY FUNCTION

local shiftKeys = {
    "!","@","#","$","%","^","&","*","(",")",
    "Q","W","E","R","T","Y","U","I","O","P",
    "A","S","D","F","G","H","J","K","L","Z",
    "X","C","V","B","N","M"
}

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

    local shiftApplied = false
    local unshiftApplied = false
    local shorts

    if type(beats) == "number" then
        shorts = false
    else
        shorts = true
    end

    local shiftRequired, nonShift = {}, {}
    local ctrlRequired = false

    if keys:sub(1, 5) == "Ctrl+" then
        ctrlRequired = true
        keys = keys:sub(6) -- remove ctrl+
    end

    -- seperate shift and no shift
    for i = 1, #keys do
        local key = keys:sub(i, i)
        table.insert(table.find(shiftKeys, key) and shiftRequired or nonShift, key)
    end

    -- Press non-shift keys first
    for _, key in ipairs(nonShift) do

        local agf = errormargin * 100 -- so 0.01 is 1
        if math.random(1, 500) <= agf then -- 0.01 is 1/175 chance, 0.04 is 4/175 which is a 2.3%
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game) -- shift if it applies
            shiftApplied = true
            print("shift applied")
        end

        coroutine.wrap(
            function()
                
                if ctrlRequired then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                end

                VirtualInputManager:SendKeyEvent(true, keyMappings[key], false, game)

                if ctrlRequired then
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                end

                if shiftApplied == true then
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game) -- turn shift off if shift was applied
                    shiftApplied = false
                end

                local waittime
                local randomOff

                if shorts == false then
                    local maxRan = (beats / bpm) * 60 / 2 -- half of note hold time
                    randomOff = math.random() * maxRan -- num from 0 to maxRan (half of note hold time)
                    waittime = (beats / bpm) * 60 - randomOff
                else -- beats to time, or if short notes...
                    waittime = math.random(3, 8) / 100 -- random number from 0.03 to 0.08
                end
                
                task.wait(waittime)
                
                VirtualInputManager:SendKeyEvent(false, keyMappings[key], false, game)
            end
        )()

        if errormargin ~= 0 then
            if math.random() < 0.5 then -- 50% chance to apply delay
                task.wait(math.random() * errormargin / 3) -- make the delay 0-half of the error margin
            end
        else end
    end

    -- Press shift-required keys
    if #shiftRequired > 0 then
        for _, key in ipairs(shiftRequired) do
            
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
            
            local agf = errormargin * 100 -- so 0.01 is 1
            if math.random(1, 500) <= agf then -- 0.01 is 1/200 chance, 0.04 is 4/200
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game) -- unshift if it applies
                unshiftApplied = true
                print("unshift applied")
            end

            coroutine.wrap(
                function()
                    
                    if ctrlRequired then
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                    end
    
                    VirtualInputManager:SendKeyEvent(true, keyMappings[key], false, game)
    
                    if ctrlRequired then
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                    end

                    if unshiftApplied == false then
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                    end

                    local waittime
                    local randomOff

                    if shorts == false then
                        local maxRan = (beats / bpm) * 60 / 2 -- half of note hold time
                        randomOff = math.random() * maxRan -- num from 0 to maxRan (half of note hold time)
                        waittime = (beats / bpm) * 60 - randomOff
                    else

                        waittime = math.random(4, 12) / 100 -- beats to secs, OR random number from 0.044 to 0.12
                    end
                    task.wait(waittime)

                    VirtualInputManager:SendKeyEvent(false, keyMappings[key], false, game)
                end
            )()

            if errormargin ~= 0 then
                if math.random() < 0.5 then -- 50% chance to apply delay
                    task.wait(math.random() * errormargin / 3)
                end
            else
            end
        end
    end

    if ctrlRequired then
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
    end

    if errormargin ~= 0 then
        task.wait(math.random() * (errormargin * 2)) -- make the delay 0-half of the error margin
    else end
end

-- PRESSNOTE FUNCTION
-- PRESSNOTE FUNCTION
-- PRESSNOTE FUNCTION

-- note mappings to vp keys

local noteMappings = {
    ["C"] = {[1] = "1", [2] = "8", [3] = "t", [4] = "s", [5] = "l", [6] = "m"},
    ["C#"] = {[1] = "!", [2] = "*", [3] = "T", [4] = "S", [5] = "L"},
    ["D"] = {[1] = "2", [2] = "9", [3] = "y", [4] = "d", [5] = "z"},
    ["D#"] = {[1] = "@", [2] = "(", [3] = "Y", [4] = "D", [5] = "Z"},
    ["E"] = {[1] = "3", [2] = "0", [3] = "u", [4] = "f", [5] = "x"},
    ["F"] = {[1] = "4", [2] = "q", [3] = "i", [4] = "g", [5] = "c"},
    ["F#"] = {[1] = "$", [2] = "Q", [3] = "I", [4] = "G", [5] = "C"},
    ["G"] = {[1] = "5", [2] = "w", [3] = "o", [4] = "h", [5] = "v"},
    ["G#"] = {[1] = "%", [2] = "W", [3] = "O", [4] = "H", [5] = "V"},
    ["A"] = {[1] = "6", [2] = "e", [3] = "p", [4] = "j", [5] = "b"},
    ["A#"] = {[1] = "^", [2] = "E", [3] = "P", [4] = "J", [5] = "B"},
    ["B"] = {[1] = "7", [2] = "r", [3] = "a", [4] = "k", [5] = "n"}
}

-- press function
function pressnote(note, octave, beats, bpm)
    table.insert(song, {
        type = "pressnote",
        note = note,
        octave = octave,
        beats = beats
    })
end

function pressnotetrigger(note, octave, beats, bpm)
    if _G.STOPIT then return end
    if pausing then
        resumeEvent.Event:Wait()
    end

    local key = noteMappings[note] and noteMappings[note][octave]
    if key then
        -- press it asynchronously
        coroutine.wrap(
            function()
                pressKey(key, beats, bpm) -- pass args to presskey
            end
        )()
    else
        warn("Invalid note or octave: " .. tostring(note) .. " octave " .. tostring(octave))
    end
end

-- KEYPRESS FUNCTION
-- KEYPRESS FUNCTION
-- KEYPRESS FUNCTION

-- the one used in most talentless songs
function keypress(keys, beats, bpm) -- bpm will not be added to the table, because it can be changed.
    table.insert(song, {
        type = "keypress",
        keys = keys,
        beats = beats
    })
end

function keypresstrigger(keys, beats, bpm)
    if _G.STOPIT then return end
    if pausing then
        resumeEvent.Event:Wait()
    else
    end
    coroutine.wrap(
        function()
            pressKey(keys, beats, bpm)
        end
    )()
end

-- VELOCITY FUNCTION
-- VELOCITY FUNCTION
-- VELOCITY FUNCTION

function adjustVelocity(vel)
    table.insert(song, {
        type = "adjustVelocity",
        vel = vel
    })
end

function adjustVelocitytrigger(vel)
    if _G.STOPIT then return end
    local velocityMap = "58qrupdhl"

    vel = math.clamp(vel, 0, 1)

    if vel < 0.27 then
        topress = "2"
    elseif vel >= 0.88 then
        topress = "c"
    else
        local index = math.floor((vel - 0.27) / 0.61 * (#velocityMap - 2)) + 2
        topress = velocityMap:sub(index, index)
    end

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftAlt, false, game)
    VirtualInputManager:SendKeyEvent(true, keyMappings[topress], false, game)
    VirtualInputManager:SendKeyEvent(false, keyMappings[topress], false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftAlt, false, game)
end

-- REST FUNCTION
-- REST FUNCTION
-- REST FUNCTION

function rest(beats, bpm) -- bpm will not be added to the table, because it may be changed.
    table.insert(song, {
        type = "rest",
        beats = beats
    })
end

function resttrigger(beats, bpm)
    if _G.STOPIT then return end
    
    local waitTime = (beats / bpm) * 60
    if errormargin == 0 then
        task.wait(waitTime)
    else
        local randomOffset = (math.random() * 2 - 1) * (errormargin / 2)
        wait(waitTime + randomOffset)
    end
    
    -- update playhead stuffs
    currentSongPosition = currentSongPosition + beats
    updatePlayheadVisual()
end

-- PEDAL FUNCTIONS
-- PEDAL FUNCTIONS
-- PEDAL FUNCTIONS

function pedalDown()
    table.insert(song, {
        type = "pedalDown"
    })
end

function pedalDowntrigger()
    if _G.STOPIT then return end
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
end

function pedalUp()
    table.insert(song, {
        type = "pedalUp"
    })
end

function pedalUptrigger()
    if _G.STOPIT then return end
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

-- MAIN SONG LOOP
-- MAIN SONG LOOP
-- MAIN SONG LOOP

_G.STOPIT = false

songThread = task.spawn(function()
    repeat wait() until finishedLoading == true
    
    totalSongBeats = calculateTotalBeats()
    totalSongBeats = calculateTotalBeats()
    currentSongPosition = 0  -- cause we js started
    updatePlayheadVisual()

    for i = 1, #song do
        if _G.STOPIT or tempClear then halted = true break end
        
        local action = song[i]
        
        if action.type == "keypress" then
            keypresstrigger(action.keys, action.beats, bpm)
        elseif action.type == "rest" then
            resttrigger(action.beats, bpm)
        elseif action.type == "adjustVelocity" then
            adjustVelocitytrigger(action.vel)
        elseif action.type == "pedalDown" then
            pedalDowntrigger()
        elseif action.type == "pedalUp" then
            pedalUptrigger()
        elseif action.type == "finishedSong" then
            finishedSongtrigger()
        elseif action.type == "pressnote" then
            pressnotetrigger(action.note, action.octave, action.beats, bpm)
        end
    end
end)

watcher = task.spawn(function()
    while task.wait(0.1) do
        if _G.STOPIT then
            song = {}
            task.cancel(songThread)
            task.cancel(watcher)
            return
        end
    end
end)
