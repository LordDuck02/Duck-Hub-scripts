-- findfirstchildofclass é mais rapido que getservice
local game = game -- otimização de 0.1ms
local ws = game:FindFirstChildOfClass("Workspace")
local plrs = game:FindFirstChildOfClass("Players")
local cplrs = plrs:GetPlayers()
local runService = game:FindFirstChildOfClass("RunService")
local replicatedStorage = game:FindFirstChildOfClass("ReplicatedStorage")
local strtGui = game:FindFirstChildOfClass("StarterGui")


local assetsF = replicatedStorage.Assets
local deviceR = assetsF.Remotes.Device
local robR = assetsF.Remotes.Robbery
local afkR = assetsF.Remotes.AFK
local buyR =  assetsF.Remotes:WaitForChild("ToolsShop")
local buyRR = assetsF.Remotes:WaitForChild("BuyShop")

local cc = ws.CurrentCamera
local lp = plrs.LocalPlayer

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local mainW = OrionLib:MakeWindow({Name = "Duck Hub - EB do Tevez", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local function notify(title, text, duration)
    strtGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end

notify("Duck Hub", "Carregando EB", 3)

local HitboxExpander = {
    settings = {
        Transparency = 0.7,
        HeadSize = 2,
        RenderConnection = nil
    }
}

local function onHitboxSizeChange(value)
    HitboxExpander.settings.HeadSize = value
    
    if HitboxExpander.settings.RenderConnection then
        HitboxExpander.settings.RenderConnection:Disconnect()
    end
    
    HitboxExpander.settings.RenderConnection = runService.Heartbeat:Connect(function()
        for _, player in ipairs(cplrs) do
            if player ~= lp then
                local character = player.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        humanoidRootPart.Size = Vector3.new(HitboxExpander.settings.HeadSize, HitboxExpander.settings.HeadSize, HitboxExpander.settings.HeadSize)
                        humanoidRootPart.Transparency = HitboxExpander.settings.Transparency
                        humanoidRootPart.BrickColor = BrickColor.new("Really blue")
                        humanoidRootPart.Material = Enum.Material.Neon
                        humanoidRootPart.CanCollide = false
                    else
                        print("HRP não encontrado: " .. player.Name)
                    end
                end
            end
        end
    end)
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

local pvpTab = mainW:MakeTab({
    Name = "PvP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

pvpTab:AddSection({ Name = "Geral" })

createSlider(pvpTab, "FOV", 0, 120, 70, Color3.fromRGB(255, 255, 255), 1, "Valor", function(value)
    cc.FieldOfView = value
end)

createSlider(pvpTab, "Tamanho da hitbox", 2, 150, HitboxExpander.settings.HeadSize, Color3.fromRGB(255, 255, 255), 1, "Tamanho", onHitboxSizeChange)

createSlider(pvpTab, "Transparência da hitbox", 0, 1, HitboxExpander.settings.Transparency, Color3.fromRGB(255, 255, 255), 0.1, "Transparência", function(value)
    HitboxExpander.settings.Transparency = value
end)

local trollTab = mainW:MakeTab({
    Name = "Troll",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

trollTab:AddButton({
    Name = "Icone mobile (ilimitado)",
    Callback = function()
        deviceR:FireServer("Mobile")
    end    
})

trollTab:AddButton({
    Name = "Icone PC (ilimitado)",
    Callback = function()
        deviceR:FireServer("Computer")
    end    
})

trollTab:AddButton({
    Name = "Fake AFK",
    Callback = function()
        afkR:FireServer(true)
    end
})

local lojaTab = mainW:MakeTab({
    Name = "Loja",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

lojaTab:AddSection({
    Name = "Armas"
})

lojaTab:AddButton({
    Name = "Colete",
    Callback = function()
        buyR:FireServer("Buy", "Colete")
    end
})

lojaTab:AddButton({
    Name = "AK-47 (15000)",
    Callback = function()
        buyR:FireServer("Buy", "AK-47")
    end
})

lojaTab:AddButton({
    Name = "MPT-76 (8500)",
    Callback = function()
        buyR:FireServer("Buy", "MPT-76")
    end
})

lojaTab:AddButton({
    Name = "Uzi (8200)",
    Callback = function()
        buyR:FireServer("Buy", "UZI")
    end
})

lojaTab:AddButton({
    Name = "Glock 18 (4300)",
    Callback = function()
        buyR:FireServer("Buy", "GLOCK 18")
    end
})

lojaTab:AddButton({
    Name = "M4A1 (13000)",
    Callback = function()
        buyR:FireServer("Buy", "M4A1")
    end
})

lojaTab:AddSection({
    Name = "Outros"
})

lojaTab:AddButton({
    Name = "Keycard (300)",
    Callback = function()
        buyRR:FireServer("Keycard")
    end
})

lojaTab:AddButton({
    Name = "C4 (13000)",
    Callback = function()
        buyRR:FireServer("C4")
    end
})

local farmTab = mainW:MakeTab({
    Name = "Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

farmTab:AddSection({
    Name = "Auto-Farm"
})

farmTab:AddButton({
    Name = "Vender dinheiro roubado",
    Callback = function()
        robR:FireServer("Payment")
    end
})

OrionLib:Init()
