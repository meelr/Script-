-- إنشاء الشاشة الرئيسية
local sg = Instance.new("ScreenGui")
sg.Name = "TeleportGui"
sg.ResetOnSpawn = false
sg.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- إنشاء الإطار (النافذة)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 150)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.Parent = sg

-- عنوان النافذة
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "أزرار الانتقال السريع"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextSize = 14
title.Parent = frame

-- الزر الأول (للمكان الأول)
local btn1 = Instance.new("TextButton")
btn1.Size = UDim2.new(0.9, 0, 0, 40)
btn1.Position = UDim2.new(0.05, 0, 0.3, 0)
btn1.Text = "الانتقال إلى المكان الأول"
btn1.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
btn1.Parent = frame

btn1.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(1704.20, 1.72, -759.90)
    end
end)

-- الزر الثاني (للعودة للمكان الثاني)
local btn2 = Instance.new("TextButton")
btn2.Size = UDim2.new(0.9, 0, 0, 40)
btn2.Position = UDim2.new(0.05, 0, 0.65, 0)
btn2.Text = "الرجوع للمكان الثاني"
btn2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
btn2.Parent = frame

btn2.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(2042.37, 2.78, 1884.03)
    end
end)
