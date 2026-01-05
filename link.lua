local link = "https://www.hellohellohell0.com/talentless"

-- Gui to Lua
-- Version: 3.2

-- Instances:

local key = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local SubmitButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local subtext = Instance.new("TextLabel")
local UICorner_3 = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")

--Properties:

key.Name = "key"
key.Parent = game:GetService("CoreGui")
key.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = key
Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 350, 0, 159)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)

Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(201, 196, 188)
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.LayoutOrder = 1
Title.Size = UDim2.new(0, 350, 0, 51)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "thank you for using talentless! the script is right around the corner."
Title.TextColor3 = Color3.fromRGB(37, 37, 37)
Title.TextSize = 25.000
Title.TextWrapped = true

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Title

SubmitButton.Name = "SubmitButton"
SubmitButton.Parent = Frame
SubmitButton.BackgroundColor3 = Color3.fromRGB(201, 196, 188)
SubmitButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
SubmitButton.BorderSizePixel = 0
SubmitButton.LayoutOrder = 3
SubmitButton.Position = UDim2.new(0.214285716, 0, 0.308080822, 0)
SubmitButton.Size = UDim2.new(0, 200, 0, 35)
SubmitButton.Font = Enum.Font.SourceSansBold
SubmitButton.Text = "copy script link!"
SubmitButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SubmitButton.TextScaled = true
SubmitButton.TextSize = 14.000
SubmitButton.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(0, 4)
UICorner_2.Parent = Frame

subtext.Name = "subtext"
subtext.Parent = Frame
subtext.BackgroundColor3 = Color3.fromRGB(201, 196, 188)
subtext.BackgroundTransparency = 1.000
subtext.BorderColor3 = Color3.fromRGB(0, 0, 0)
subtext.BorderSizePixel = 0
subtext.LayoutOrder = 5
subtext.Position = UDim2.new(0.161428571, 0, 0.535353541, 0)
subtext.Size = UDim2.new(0, 293, 0, 40)
subtext.Font = Enum.Font.SourceSansBold
subtext.Text = "If its not working, you can also find the script on the discord: discord.gg/MP9nZgEeQD"
subtext.TextColor3 = Color3.fromRGB(144, 144, 144)
subtext.TextScaled = true
subtext.TextSize = 25.000
subtext.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(0, 4)
UICorner_3.Parent = subtext

UIListLayout.Parent = Frame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

SubmitButton.MouseButton1Click:Connect(function()
    setclipboard(link)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Talentless",
        Text = "Script link copied to clipboard!",
        Duration = 5,
    })
    wait(3)
    key:Destroy()
end)
