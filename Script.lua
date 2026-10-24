local player = game.Players.LocalPlayer

-- 1. إنشاء الشاشة الرئيسية
local sg = Instance.new("ScreenGui")
sg.Name = "TeleportGui"
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

-- الإطار الرئيسي
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 195)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.Parent = sg

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "نظام الانتقال والتحكم"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextSize = 13
title.Parent = frame

-- 2. زر التصغير والإظهار
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 70, 0, 30)
toggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
toggleBtn.Text = "إخفاء"
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Parent = sg

toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    if frame.Visible then
        toggleBtn.Text = "إخفاء"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    else
        toggleBtn.Text = "إظهار"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
    end
end)

-- 3. الإحداثيات
local posInsidePrison = CFrame.new(1754.04, 544.61, -367.02)
local spawnPos = Vector3.new(2042.36865234375, 2.7812340259552, 1884.031494140625)
local posOriginalSpawn = CFrame.new(spawnPos.X, spawnPos.Y, spawnPos.Z)
local targetCoord = CFrame.new(34918.96, 19915.68, 4876.06)

-- دالة الانتقال والتثبيت
local function teleportAndLock(cf)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
        local rootPart = char.HumanoidRootPart
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        
        humanoid.PlatformStand = true
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        
        for i = 1, 5 do
            rootPart.CFrame = cf
            task.wait(0.01)
        end
        
        humanoid.PlatformStand = false
    end
end

-- 4. الأزرار

-- الزر الأول: الانتقال إلى السجن
local btn1 = Instance.new("TextButton")
btn1.Size = UDim2.new(0.9, 0, 0, 35)
btn1.Position = UDim2.new(0.05, 0, 0.22, 0)
btn1.Text = "الانتقال إلى السجن"
btn1.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
btn1.Parent = frame

btn1.MouseButton1Click:Connect(function()
    teleportAndLock(posInsidePrison)
end)

-- الزر الثاني: الرجوع إلى السبون
local btn2 = Instance.new("TextButton")
btn2.Size = UDim2.new(0.9, 0, 0, 35)
btn2.Position = UDim2.new(0.05, 0, 0.47, 0)
btn2.Text = "الرجوع إلى السبون"
btn2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
btn2.Parent = frame

btn2.MouseButton1Click:Connect(function()
    teleportAndLock(posOriginalSpawn)
end)

-- الزر الثالث: فلنق (الانتقال للإحداثيات الجديدة)
local btn3 = Instance.new("TextButton")
btn3.Size = UDim2.new(0.9, 0, 0, 35)
btn3.Position = UDim2.new(0.05, 0, 0.72, 0)
btn3.Text = "فلنق"
btn3.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
btn3.Parent = frame

btn3.MouseButton1Click:Connect(function()
    teleportAndLock(targetCoord)
end)
