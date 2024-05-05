print("Loading") -- Useless
local plrs = game:GetService("Players")
local cc = workspace.CurrentCamera
local lp = plrs.LocalPlayer
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local mainW = OrionLib:MakeWindow({Name = "Duck Hub - EB do Tevez", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local mainTab  = mainW:MakeTab({
    Name = "Geral",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
    
mainTab:AddSection({
    Name = "Geral"
})

mainTab:AddSlider({
	Name = "FOV",
	Min = 0,
	Max = 120,
	Default = 70,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Valor",
	Callback = function(Value)
		cc.FieldOfView = Value
	end    
})

mainTab:AddSlider({
    Name = "Tamanho da hitbox",
    Min = 2,
    Max = 150,
    Default = 2,
    Increment = 1,
    ValueName = "Tamanho",
    Color = Color3.fromRGB(255, 255, 255),
    Callback = function(value)
        _G.HeadSize = value
        _G.Disabled = true
        
        if _G.RenderConnection then
            _G.RenderConnection:Disconnect()
        end
        
        _G.RenderConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if _G.Disabled then
                for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v.Name ~= game:GetService("Players").LocalPlayer.Name then
                        pcall(function()
                            local humanoidRootPart = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                humanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                                humanoidRootPart.Transparency = 0.7
                                humanoidRootPart.BrickColor = BrickColor.new("Really blue")
                                humanoidRootPart.Material = "Neon"
                                humanoidRootPart.CanCollide = false
                            end
                        end)
                    end
                end
            end
        end)
    end
})

local trollTab = mainW:MakeTab({
    Name = "Troll",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = trollTab:AddSection({
	Name = "Troll"
})

trollTab:AddButton({
	Name = "Icone mobile (ilimitado)",
	Callback = function()
      		game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Remotes"):WaitForChild("Device"):FireServer("Mobile")
  	end    
})

trollTab:AddButton({
	Name = "Icone PC (ilimitado)",
	Callback = function()
      		game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Remotes"):WaitForChild("Device"):FireServer("Computer")
  	end    
})

trollTab:AddButton({
    Name = "Fake AFK",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Remotes"):WaitForChild("AFK"):FireServer(true)
    end
})

local lojaTab  = mainW:MakeTab({
    Name = "Loja",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

lojaTab:AddSection({
    Name = "Armas"
})

local farmTab  = mainW:MakeTab({
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
        game:GetService("ReplicatedStorage").Assets.Remotes.Robbery:FireServer("Payment")
    end
})


OrionLib:Init()

