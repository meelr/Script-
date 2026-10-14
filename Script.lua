local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "سكربت الانتقال السريع", HidePremium = false, SaveConfig = false, ConfigFolder = "TeleportConfig"})

local Tab = Window:MakeTab({
    Name = "الانتقال",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddButton({
    Name = "انتقال إلى المكان المحدد",
    Callback = function()
        -- إحداثياتك اللي طلعتها من اللعبة
        local targetCFrame = CFrame.new(1704.20, 1.72, -759.90) 
        
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = targetCFrame
        end
    end    
})

OrionLib:Init()
