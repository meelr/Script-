local player = game.Players.LocalPlayer
local playersService = game:GetService("Players")

-- 1. إنشاء الشاشة الرئيسية
local sg = Instance.new("ScreenGui")
sg.Name = "ControlPanelGui"
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

-- ==================== نافذة الصفحة الرئيسية (الأزرار) ====================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 220)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = sg

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, 0, 0, 35)
mainTitle.Text = "الصفحة الرئيسية"
mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainTitle.TextSize = 13
mainTitle.Parent = mainFrame

-- زر إخفاء وإظهار عام
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 70, 0, 30)
toggleBtn.Position = UDim2.new(0.02, 0, 0.25, 0)
toggleBtn.Text = "إخفاء"
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Parent = sg

toggleBtn.MouseButton1Click:Connect(function()
    local visibleState = not mainFrame.Visible
    mainFrame.Visible = visibleState
    -- إذا تحب خانة اللاعب تختفي وياها أيضاً:
    -- playerFrame.Visible = visibleState
    
    if visibleState then
        toggleBtn.Text = "إخفاء"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    else
        toggleBtn.Text = "إظهار"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
    end
end)

-- الإحداثيات
local posInsidePrison = CFrame.new(1754.04, 544.61, -367.02)
local spawnPos = Vector3.new(2042.36865234375, 2.7812340259552, 1884.031494140625)
local posOriginalSpawn = CFrame.new(spawnPos.X, spawnPos.Y, spawnPos.Z)
local targetCoord = CFrame.new(34918.96, 19915.68, 4876.06)

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

-- أزرار الصفحة الرئيسية
local btn1 = Instance.new("TextButton")
btn1.Size = UDim2.new(0.9, 0, 0, 35)
btn1.Position = UDim2.new(0.05, 0, 0.22, 0)
btn1.Text = "الانتقال إلى السجن"
btn1.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
btn1.Parent = mainFrame
btn1.MouseButton1Click:Connect(function() teleportAndLock(posInsidePrison) end)

local btn2 = Instance.new("TextButton")
btn2.Size = UDim2.new(0.9, 0, 0, 35)
btn2.Position = UDim2.new(0.05, 0, 0.47, 0)
btn2.Text = "الرجوع إلى السبون"
btn2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
btn2.Parent = mainFrame
btn2.MouseButton1Click:Connect(function() teleportAndLock(posOriginalSpawn) end)

local btn3 = Instance.new("TextButton")
btn3.Size = UDim2.new(0.9, 0, 0, 35)
btn3.Position = UDim2.new(0.05, 0, 0.72, 0)
btn3.Text = "فلنق (الإحداثيات الجديدة)"
btn3.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
btn3.Parent = mainFrame
btn3.MouseButton1Click:Connect(function() teleportAndLock(targetCoord) end)


-- ==================== نافذة خانة اللاعب (معلومات ومحتويات الإنفنتوري) ====================
local playerFrame = Instance.new("Frame")
playerFrame.Size = UDim2.new(0, 240, 0, 300)
playerFrame.Position = UDim2.new(0.55, 0, 0.3, 0)
playerFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
playerFrame.Active = true
playerFrame.Draggable = true
playerFrame.Parent = sg

local playerTitle = Instance.new("TextLabel")
playerTitle.Size = UDim2.new(1, 0, 0, 35)
playerTitle.Text = "اللاعب ومعلومات الإنفنتوري"
playerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
playerTitle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
playerTitle.TextSize = 13
playerTitle.Parent = playerFrame

-- حقل كتابة اسم اللاعب (Username)
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.9, 0, 0, 30)
textBox.Position = UDim2.new(0.05, 0, 0.15, 0)
textBox.PlaceholderText = "اكتب يوزر اللاعب هنا..."
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.TextSize = 12
textBox.Parent = playerFrame

-- صورة سكن اللاعب (Avatar Image)
local avatarImg = Instance.new("ImageLabel")
avatarImg.Size = UDim2.new(0, 70, 0, 70)
avatarImg.Position = UDim2.new(0.05, 0, 0.28, 0)
avatarImg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
avatarImg.Image = ""
avatarImg.Parent = playerFrame

-- قائمة محتويات الإنفنتوري (تظهر أسفل الصورة)
local scrollingList = Instance.new("ScrollingFrame")
scrollingList.Size = UDim2.new(0.6, 0, 0, 115)
scrollingList.Position = UDim2.new(0.35, 0, 0.28, 0)
scrollingList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
scrollingList.CanvasSize = UDim2.new(0, 0, 2, 0)
scrollingList.Parent = playerFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = scrollingList
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- زر البحث والفحص
searchBtn = Instance.new("TextButton")
searchBtn.Size = UDim2.new(0.9, 0, 0, 30)
searchBtn.Position = UDim2.new(0.05, 0, 0.82, 0)
searchBtn.Text = "فحص اللاعب"
searchBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
searchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBtn.Parent = playerFrame

searchBtn.MouseButton1Click:Connect(function()
    local targetName = textBox.Text
    local targetPlayer = nil
    
    -- البحث عن اللاعب في السيرفر بالاسم أو الـ DisplayName
    for _, p in ipairs(playersService:GetPlayers()) do
        if p.Name:lower() == targetName:lower() or p.DisplayName:lower() == targetName:lower() then
            targetPlayer = p
            break
        end
    end
    
    -- تفريغ القائمة القديمة
    for _, child in ipairs(scrollingList:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    if targetPlayer then
        -- جلب صورة السكن
        pcall(function()
            local content, isReady = playersService:GetUserThumbnailAsync(targetPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            avatarImg.Image = content
        end)
        
        -- دالة لفحص وتجميع محتويات الإنفنتوري (Backpack + Character) داخل الماب
        local itemsFound = {}
        
        if targetPlayer:FindFirstChild("Backpack") then
            for _, item in ipairs(targetPlayer.Backpack:GetChildren()) do
                table.insert(itemsFound, item.Name)
            end
        end
        
        if targetPlayer.Character then
            for _, item in ipairs(targetPlayer.Character:GetChildren()) do
                if item:IsA("Tool") then
                    table.insert(itemsFound, item.Name)
                end
            end
        end
        
        -- عرض النتائج داخل القائمة
        if #itemsFound > 0 then
            for _, itemName in ipairs(itemsFound) do
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 0, 25)
                lbl.Text = "- " .. itemName
                lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                lbl.BackgroundTransparency = 1
                lbl.TextSize = 11
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = scrollingList
            end
        else
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0, 25)
            lbl.Text = "الإنفنتوري فارغ أو مخفي"
            lbl.TextColor3 = Color3.fromRGB(200, 50, 50)
            lbl.BackgroundTransparency = 1
            lbl.TextSize = 11
            lbl.Parent = scrollingList
        end
    else
        avatarImg.Image = ""
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 25)
        lbl.Text = "اللاعب غير موجود!"
        lbl.TextColor3 = Color3.fromRGB(255, 50, 50)
        lbl.BackgroundTransparency = 1
        lbl.TextSize = 11
        lbl.Parent = scrollingList
    end
end)
