local ws = game:FindFirstChildOfClass("Workspace")
local plrs = game:FindFirstChildOfClass("Players")
local Orion = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local lp = plrs.LocalPlayer
local char = lp.Character
local hum = char.Humanoid
local cc = ws.CurrentCamera

local itemSpots = {"KnifeSpot", "KatanaSpot", "ScytheSpot", "TaserSpot"}
local foodSpots = {}

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

local function monitorNewItems()
    local itemSpotsFolder = ws:FindFirstChild("Scripted"):FindFirstChild("ItemSpawner")
    
    if itemSpotsFolder then
        for _, spotName in ipairs(itemSpots) do
            local spotFolder = itemSpotsFolder:FindFirstChild(spotName)
            
            if spotFolder then
                spotFolder.ChildAdded:Connect(function(newItem)
                    addUI(newItem)
                    Instance.new("Highlight", newItem)
                end)
            end
        end
    end
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

plrs.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        addUI(character.Head or character.PrimaryPart)
    end)
end)


local function addLineESP(target)
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(255, 0, 0)
    line.Thickness = 2
    line.Transparency = 1
    line.Visible = true

    local function updateLine()
        if target and target:FindFirstChild("HumanoidRootPart") then
            line.From = cc:WorldToViewportPoint(lp.Character.HumanoidRootPart.Position)
            line.To = cc:WorldToViewportPoint(target.HumanoidRootPart.Position)
        else
            line:Remove()
        end
    end

    local conn = game:GetService("RunService").RenderStepped:Connect(updateLine)

    target.AncestryChanged:Connect(function(_, parent)
        if not parent then
            line:Remove()
            conn:Disconnect()
        end
    end)
end


local function allLineESP()
    for _, player in ipairs(plrs:GetPlayers()) do
        if player ~= lp and player.Character then
            addLineESP(player.Character)
        end
    end
end

local function createSlider(tab, name, min, max, default, color, increment, valueName, callback)
    tab:AddSlider({
        Name = name,
        Min = min,
        Max = max,
        Default = default,
        Color = color,
        Increment = increment,
        ValueName = valueName,
        Callback = callback
    })
end

local Window = Orion:MakeWindow({Name = "Kaiju Paradise - Duck hub", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local genTab = Window:MakeTab({
    Name = "Items",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

createSlider(genTab, "FOV", 0, 120, 70, Color3.fromRGB(255, 255, 255), 1, "Valor", function(value)
    cc.FieldOfView = value
end)

local VisualTab = Window:MakeTab({
    Name = "Visuals",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

VisualTab:AddButton({
    Name = "ESP",
    Callback = function()
        allLineESP()
    end
})

VisualTab:AddButton({
    Name = "Item ESP",
    Callback = function()
        itemESP()
        monitorNewItems()
    end
})
