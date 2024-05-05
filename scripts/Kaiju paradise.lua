print("Loading kaiju paradise")
local ws = game:GetService("Workspace")
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local Orion = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local itemSpots = {"KnifeSpot", "KatanaSpot", "ScytheSpot", "TaserSpot"}
local foodSpots = {}

local checkChild = false


local function addUI(part)
    local partGui = Instance.new("BillboardGui", part)
    partGui.Size = UDim2.new(2, 0, 2, 0)
    partGui.AlwaysOnTop = true
    partGui.Name = "Item ESP"
    local frame = Instance.new("Frame", partGui)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 150)  
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1.3, 0, 1.3, 0)
    frame.BorderSizePixel = 0 

    local nameGUI = Instance.new("BillboardGui", part)
    nameGUI.Size = UDim2.new(3, 0, 1.5, 0)
    nameGUI.SizeOffset = Vector2.new(0, 1)
    nameGUI.AlwaysOnTop = true
    nameGUI.Name = "Name"

    local text = Instance.new("TextLabel", nameGUI)
    text.Font = Enum.Font.GothamSemibold
    text.Name = "Text"
    text.Text = part.Name
    text.TextColor3 = Color3.fromRGB(255, 80, 60)
    text.Transparency = 0
    text.BackgroundTransparency = 1
    text.TextScaled = true
    text.Size = UDim2.new(1, 0, 1, 0)
end

local function itemESP()
    for _, child in ipairs(ws.Scripted.ItemSpawner:GetChildren()) do
        if table.find(itemSpots, child.Name) then
            for _, item in ipairs(child:GetChildren()) do 
                addUI(item)
                Instance.new("Highlight", item)
            end
        end
    end
end

local function allESP()
    for _, player in ipairs(plrs:GetChildren()) do 
            addUI(player)
        end
end

local Window = Orion:MakeWindow({Name = "Kaiju Paradise - Duck hub", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local VisualTab = Window:MakeTab({
    Name = "Visuals",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

VisualTab:AddToggle({
    Name = "ESP",
    Default = false,
    Callback = allESP()
})

VisualTab:AddToggle({
    Name = "Item ESP",
    Default = false,
    Callback = itemESP()
})

local Section = VisualTab:AddSection({
	Name = "Event items"
})

local ItemsTab = Window:MakeTab({
    Name = "Items",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
