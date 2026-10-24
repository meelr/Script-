
--// CONTROL CENTER | Unified Dark UI
--// Run as a LocalScript inside a Roblox experience you own
--// All pages share one window and one floating toggle button.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove previous copy if the script is run again
local oldGui = playerGui:FindFirstChild("ControlPanelGui")
if oldGui then
    oldGui:Destroy()
end

--==================================================
-- CONFIGURATION
--==================================================

local COLORS = {
    Background = Color3.fromRGB(13, 16, 24),
    Panel      = Color3.fromRGB(20, 24, 35),
    Sidebar    = Color3.fromRGB(17, 20, 30),
    Card       = Color3.fromRGB(28, 34, 48),
    Input      = Color3.fromRGB(24, 29, 42),
    Accent     = Color3.fromRGB(111, 91, 255),
    Blue       = Color3.fromRGB(60, 140, 255),
    Green      = Color3.fromRGB(42, 190, 135),
    Red        = Color3.fromRGB(235, 80, 100),
    Text       = Color3.fromRGB(240, 243, 250),
    Muted      = Color3.fromRGB(145, 155, 175),
    Border     = Color3.fromRGB(47, 55, 75),
}

local function new(className, props, parent)
    local obj = Instance.new(className)

    for key, value in pairs(props or {}) do
        obj[key] = value
    end

    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    new("UICorner", {
        CornerRadius = UDim.new(0, radius or 10)
    }, obj)
end

local function outline(obj, color, transparency)
    new("UIStroke", {
        Color = color or COLORS.Border,
        Transparency = transparency or 0,
        Thickness = 1,
    }, obj)
end

local function label(parent, text, size, position, fontSize, color)
    return new("TextLabel", {
        Size = size,
        Position = position,
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or COLORS.Text,
        TextSize = fontSize or 14,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true,
    }, parent)
end

local function makeButton(parent, text, size, position, color)
    local btn = new("TextButton", {
        Size = size,
        Position = position,
        BackgroundColor3 = color or COLORS.Card,
        Text = text,
        TextColor3 = COLORS.Text,
        TextSize = 13,
        Font = Enum.Font.GothamSemibold,
        AutoButtonColor = true,
        BorderSizePixel = 0,
    }, parent)

    round(btn, 9)
    return btn
end

--==================================================
-- GUI ROOT
--==================================================

local gui = new("ScreenGui", {
    Name = "ControlPanelGui",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

-- One unified window
local window = new("Frame", {
    Name = "MainWindow",
    Size = UDim2.fromOffset(570, 390),
    Position = UDim2.new(0.5, -285, 0.5, -195),
    BackgroundColor3 = COLORS.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Visible = true,
}, gui)

round(window, 15)
outline(window, COLORS.Border)

--==================================================
-- TOP BAR
--==================================================

local topbar = new("Frame", {
    Name = "TopBar",
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
}, window)

local accentLine = new("Frame", {
    Size = UDim2.new(1, 0, 0, 2),
    Position = UDim2.new(0, 0, 1, -2),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
}, topbar)

label(topbar, "◆", UDim2.fromOffset(25, 30),
    UDim2.fromOffset(15, 8), 18, COLORS.Accent)

label(topbar, "CONTROL CENTER",
    UDim2.fromOffset(210, 30),
    UDim2.fromOffset(43, 8), 15, COLORS.Text)

label(topbar, "UNIFIED INTERFACE",
    UDim2.fromOffset(150, 25),
    UDim2.new(1, -180, 0, 11), 10, COLORS.Muted)

-- Drag the entire window by its top bar
local dragging = false
local dragStart
local startPosition

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = window.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        window.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

--==================================================
-- SIDEBAR
--==================================================

local sidebar = new("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(0, 48),
    Size = UDim2.new(0, 145, 1, -48),
    BackgroundColor3 = COLORS.Sidebar,
    BorderSizePixel = 0,
}, window)

label(sidebar, "WORKSPACE",
    UDim2.new(1, -24, 0, 25),
    UDim2.fromOffset(13, 12), 10, COLORS.Muted)

local homeTab = makeButton(
    sidebar, "⌂   الرئيسية",
    UDim2.new(1, -18, 0, 39),
    UDim2.fromOffset(9, 43), COLORS.Accent
)

local playerTab = makeButton(
    sidebar, "◉   صفحة اللاعب",
    UDim2.new(1, -18, 0, 39),
    UDim2.fromOffset(9, 89), COLORS.Card
)

local separator = new("Frame", {
    Size = UDim2.new(1, -24, 0, 1),
    Position = UDim2.fromOffset(12, 142),
    BackgroundColor3 = COLORS.Border,
    BorderSizePixel = 0,
}, sidebar)

label(sidebar, "CONTROL PANEL",
    UDim2.new(1, -24, 0, 24),
    UDim2.fromOffset(13, 155), 9, COLORS.Muted)

local statusDot = new("Frame", {
    Size = UDim2.fromOffset(7, 7),
    Position = UDim2.fromOffset(14, 190),
    BackgroundColor3 = COLORS.Green,
    BorderSizePixel = 0,
}, sidebar)
round(statusDot, 5)

label(sidebar, "واجهة جاهزة",
    UDim2.new(1, -35, 0, 22),
    UDim2.fromOffset(28, 182), 10, COLORS.Muted)

--==================================================
-- PAGE CONTAINER
--==================================================

local content = new("Frame", {
    Name = "PageContainer",
    Position = UDim2.fromOffset(145, 48),
    Size = UDim2.new(1, -145, 1, -48),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
}, window)

local homePage = new("Frame", {
    Name = "HomePage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = true,
}, content)

local playerPage = new("Frame", {
    Name = "PlayerPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
}, content)

local function switchPage(pageName)
    local isHome = pageName == "Home"

    homePage.Visible = isHome
    playerPage.Visible = not isHome

    homeTab.BackgroundColor3 = isHome and COLORS.Accent or COLORS.Card
    playerTab.BackgroundColor3 = isHome and COLORS.Card or COLORS.Accent
end

homeTab.Activated:Connect(function()
    switchPage("Home")
end)

playerTab.Activated:Connect(function()
    switchPage("Player")
end)

--==================================================
-- HOME PAGE
--==================================================

label(homePage, "الصفحة الرئيسية",
    UDim2.new(1, -30, 0, 34),
    UDim2.fromOffset(16, 12), 20, COLORS.Text)

label(homePage, "اختَر العملية التي تريد تنفيذها",
    UDim2.new(1, -30, 0, 23),
    UDim2.fromOffset(16, 44), 11, COLORS.Muted)

local function makeActionCard(y, title, description, buttonText, accent)
    local card = new("Frame", {
        Size = UDim2.new(1, -32, 0, 76),
        Position = UDim2.fromOffset(16, y),
        BackgroundColor3 = COLORS.Panel,
        BorderSizePixel = 0,
    }, homePage)

    round(card, 11)
    outline(card, COLORS.Border)

    new("Frame", {
        Size = UDim2.fromOffset(3, 42),
        Position = UDim2.fromOffset(0, 17),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
    }, card)

    label(card, title,
        UDim2.new(1, -145, 0, 25),
        UDim2.fromOffset(13, 10), 13, COLORS.Text)

    label(card, description,
        UDim2.new(1, -145, 0, 24),
        UDim2.fromOffset(13, 37), 10, COLORS.Muted)

    local btn = makeButton(
        card, buttonText,
        UDim2.fromOffset(108, 36),
        UDim2.new(1, -120, 0.5, -18), accent
    )

    return btn
end

-- Original coordinates
local posInsidePrison = CFrame.new(1754.04, 544.61, -367.02)

local spawnPos = Vector3.new(
    2042.36865234375,
    2.7812340259552,
    1884.031494140625
)

local posOriginalSpawn = CFrame.new(
    spawnPos.X, spawnPos.Y, spawnPos.Z
)

local targetCoord = CFrame.new(34918.96, 19915.68, 4876.06)

local function teleportAndLock(cf)
    local character = player.Character
    if not character then
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if not root or not humanoid then
        return
    end

    humanoid.PlatformStand = true
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero

    for _ = 1, 5 do
        root.CFrame = cf
        task.wait(0.01)
    end

    humanoid.PlatformStand = false
end

local prisonBtn = makeActionCard(
    78, "الانتقال إلى السجن",
    "انتقال إلى الإحداثيات المحددة",
    "انتقال", COLORS.Blue
)

local spawnBtn = makeActionCard(
    164, "الرجوع إلى السبون",
    "العودة إلى نقطة السبون المحفوظة",
    "رجوع", COLORS.Red
)

local targetBtn = makeActionCard(
    250, "الإحداثيات الجديدة",
    "الانتقال إلى الموقع المحدد",
    "انتقال", COLORS.Green
)

prisonBtn.Activated:Connect(function()
    teleportAndLock(posInsidePrison)
end)

spawnBtn.Activated:Connect(function()
    teleportAndLock(posOriginalSpawn)
end)

targetBtn.Activated:Connect(function()
    teleportAndLock(targetCoord)
end)

--==================================================
-- PLAYER PAGE
--==================================================

label(playerPage, "صفحة اللاعب",
    UDim2.new(1, -30, 0, 34),
    UDim2.fromOffset(16, 12), 20, COLORS.Text)

label(playerPage, "ابحث عن لاعب موجود في السيرفر الحالي",
    UDim2.new(1, -30, 0, 23),
    UDim2.fromOffset(16, 44), 11, COLORS.Muted)

local searchBox = new("TextBox", {
    Name = "PlayerSearch",
    Size = UDim2.new(1, -120, 0, 38),
    Position = UDim2.fromOffset(16, 76),
    BackgroundColor3 = COLORS.Input,
    TextColor3 = COLORS.Text,
    PlaceholderColor3 = COLORS.Muted,
    PlaceholderText = "اكتب Username أو Display Name...",
    Text = "",
    TextSize = 12,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    BorderSizePixel = 0,
}, playerPage)

round(searchBox, 9)
outline(searchBox, COLORS.Border)

local searchBtn = makeButton(
    playerPage, "بحث",
    UDim2.fromOffset(80, 38),
    UDim2.new(1, -96, 0, 76), COLORS.Accent
)

-- Profile card
local profileCard = new("Frame", {
    Size = UDim2.new(1, -32, 0, 105),
    Position = UDim2.fromOffset(16, 124),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
}, playerPage)

round(profileCard, 11)
outline(profileCard, COLORS.Border)

local avatar = new("ImageLabel", {
    Name = "Avatar",
    Size = UDim2.fromOffset(76, 76),
    Position = UDim2.fromOffset(12, 14),
    BackgroundColor3 = COLORS.Card,
    Image = "",
    ScaleType = Enum.ScaleType.Crop,
    BorderSizePixel = 0,
}, profileCard)

round(avatar, 12)

local nameLabel = label(profileCard, "لم يتم تحديد لاعب",
    UDim2.new(1, -115, 0, 28),
    UDim2.fromOffset(101, 20), 14, COLORS.Text)

local usernameLabel = label(profileCard, "Username: —",
    UDim2.new(1, -115, 0, 22),
    UDim2.fromOffset(101, 49), 11, COLORS.Muted)

local inventoryCountLabel = label(profileCard, "الأدوات: —",
    UDim2.new(1, -115, 0, 20),
    UDim2.fromOffset(101, 72), 10, COLORS.Green)

label(playerPage, "INVENTORY",
    UDim2.new(1, -32, 0, 20),
    UDim2.fromOffset(16, 237), 10, COLORS.Muted)

local inventoryList = new("ScrollingFrame", {
    Name = "InventoryList",
    Size = UDim2.new(1, -32, 0, 78),
    Position = UDim2.fromOffset(16, 259),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = COLORS.Accent,
    CanvasSize = UDim2.fromOffset(0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, playerPage)

round(inventoryList, 9)
outline(inventoryList, COLORS.Border)

new("UIPadding", {
    PaddingTop = UDim.new(0, 6),
    PaddingBottom = UDim.new(0, 6),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
}, inventoryList)

local inventoryLayout = new("UIListLayout", {
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, inventoryList)

local function clearInventory()
    for _, child in ipairs(inventoryList:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end

local function addInventoryItem(text, color)
    local itemLabel = new("TextLabel", {
        Size = UDim2.new(1, -4, 0, 25),
        BackgroundColor3 = COLORS.Card,
        BackgroundTransparency = 0.15,
        Text = "   " .. text,
        TextColor3 = color or COLORS.Text,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        BorderSizePixel = 0,
    }, inventoryList)

    round(itemLabel, 6)
end

local function findPlayer(name)
    name = name:match("^%s*(.-)%s*$")

    if name == "" then
        return nil
    end

    -- Exact username or display name first
    for _, target in ipairs(Players:GetPlayers()) do
        if target.Name:lower() == name:lower()
            or target.DisplayName:lower() == name:lower() then
            return target
        end
    end

    -- Allow partial matches if there is only one result
    local match = nil

    for _, target in ipairs(Players:GetPlayers()) do
        if target.Name:lower():find(name:lower(), 1, true)
            or target.DisplayName:lower():find(name:lower(), 1, true) then

            if match then
                return nil -- Ambiguous result
            end

            match = target
        end
    end

    return match
end

local function inspectPlayer()
    clearInventory()

    local target = findPlayer(searchBox.Text)

    if not target then
        avatar.Image = ""
        nameLabel.Text = "اللاعب غير موجود أو الاسم غير واضح"
        usernameLabel.Text = "تأكد من الاسم وحاول مجدداً"
        inventoryCountLabel.Text = "الأدوات: —"
        addInventoryItem("لم يتم العثور على لاعب", COLORS.Red)
        return
    end

    nameLabel.Text = target.DisplayName
    usernameLabel.Text = "@" .. target.Name
    inventoryCountLabel.Text = "جارٍ تحميل البيانات..."

    -- Get the avatar thumbnail
    task.spawn(function()
        local success, imageUrl = pcall(function()
            local url = Players:GetUserThumbnailAsync(
                target.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size150x150
            )

            return url
        end)

        if success and target.Parent == Players then
            avatar.Image = imageUrl
        end
    end)

    local items = {}

    -- Backpack tools visible to this LocalScript
    local backpack = target:FindFirstChildOfClass("Backpack")

    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(items, item.Name)
            end
        end
    end

    -- Equipped tools
    local character = target.Character

    if character then
        for _, item in ipairs(character:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(items, item.Name)
            end
        end
    end

    inventoryCountLabel.Text = "الأدوات الظاهرة: " .. #items

    if #items == 0 then
        addInventoryItem(
            "لا توجد أدوات ظاهرة أو أن المحتويات غير متاحة",
            COLORS.Muted
        )
    else
        for _, itemName in ipairs(items) do
            addInventoryItem("◆   " .. itemName, COLORS.Text)
        end
    end
end

searchBtn.Activated:Connect(inspectPlayer)

searchBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        inspectPlayer()
    end
end)

--==================================================
-- ONE FLOATING BUTTON: HIDE / SHOW EVERYTHING
--==================================================

local toggleBtn = makeButton(
    gui, "✕",
    UDim2.fromOffset(48, 48),
    UDim2.new(0, 18, 0.5, -24),
    COLORS.Accent
)

toggleBtn.Name = "ToggleButton"
toggleBtn.TextSize = 20
toggleBtn.ZIndex = 10
toggleBtn.Active = true

round(toggleBtn, 15)
outline(toggleBtn, COLORS.Border)

-- The button stays visible when the entire window is hidden.
toggleBtn.Activated:Connect(function()
    window.Visible = not window.Visible

    if window.Visible then
        toggleBtn.Text = "✕"
        toggleBtn.BackgroundColor3 = COLORS.Accent
    else
        toggleBtn.Text = "☰"
        toggleBtn.BackgroundColor3 = COLORS.Green
    end
end)

-- Start on the home page
switchPage("Home")

print("Control Center loaded successfully")
