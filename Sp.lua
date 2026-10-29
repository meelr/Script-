
--// MILLER PANEL | CONTROL CENTER
--// Developer: Miller
--// Status: Script Under Testing

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- REMOVE OLD GUI
--==================================================

local oldGui = playerGui:FindFirstChild("ControlPanelGui")
if oldGui then
    oldGui:Destroy()
end

--==================================================
-- COLORS
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

--==================================================
-- UI HELPERS
--==================================================

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
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        AutoButtonColor = true,
        BorderSizePixel = 0,
    }, parent)

    round(btn, 9)
    return btn
end

--==================================================
-- MAIN GUI
--==================================================

local gui = new("ScreenGui", {
    Name = "ControlPanelGui",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

-- Compact unified window
local window = new("Frame", {
    Name = "MainWindow",
    Size = UDim2.fromOffset(520, 360),
    Position = UDim2.new(0.5, -260, 0.5, -180),
    BackgroundColor3 = COLORS.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Visible = true,
}, gui)

round(window, 14)
outline(window, COLORS.Border)

--==================================================
-- TOP BAR
--==================================================

local topbar = new("Frame", {
    Name = "TopBar",
    Size = UDim2.new(1, 0, 0, 44),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
}, window)

new("Frame", {
    Size = UDim2.new(1, 0, 0, 2),
    Position = UDim2.new(0, 0, 1, -2),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
}, topbar)

label(
    topbar, "◆",
    UDim2.fromOffset(22, 28),
    UDim2.fromOffset(12, 7),
    16, COLORS.Accent
)

label(
    topbar, "MILLER PANEL",
    UDim2.fromOffset(175, 28),
    UDim2.fromOffset(37, 7),
    14, COLORS.Text
)

label(
    topbar, "DEVELOPED BY MILLER",
    UDim2.fromOffset(160, 24),
    UDim2.new(1, -172, 0, 9),
    9, COLORS.Muted
)

--==================================================
-- WINDOW DRAGGING
--==================================================

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
    Position = UDim2.fromOffset(0, 44),
    Size = UDim2.new(0, 132, 1, -44),
    BackgroundColor3 = COLORS.Sidebar,
    BorderSizePixel = 0,
}, window)

label(
    sidebar, "WORKSPACE",
    UDim2.new(1, -20, 0, 22),
    UDim2.fromOffset(11, 10),
    9, COLORS.Muted
)

local homeTab = makeButton(
    sidebar, "⌂  الرئيسية",
    UDim2.new(1, -16, 0, 36),
    UDim2.fromOffset(8, 38),
    COLORS.Accent
)

local playerTab = makeButton(
    sidebar, "◉  صفحة اللاعب",
    UDim2.new(1, -16, 0, 36),
    UDim2.fromOffset(8, 80),
    COLORS.Card
)

new("Frame", {
    Size = UDim2.new(1, -20, 0, 1),
    Position = UDim2.fromOffset(10, 128),
    BackgroundColor3 = COLORS.Border,
    BorderSizePixel = 0,
}, sidebar)

label(
    sidebar, "DEVELOPER",
    UDim2.new(1, -20, 0, 20),
    UDim2.fromOffset(11, 139),
    9, COLORS.Muted
)

local statusDot = new("Frame", {
    Size = UDim2.fromOffset(7, 7),
    Position = UDim2.fromOffset(12, 171),
    BackgroundColor3 = COLORS.Green,
    BorderSizePixel = 0,
}, sidebar)

round(statusDot, 5)

label(
    sidebar, "المطور ميلر",
    UDim2.new(1, -30, 0, 22),
    UDim2.fromOffset(24, 163),
    10, COLORS.Text
)

label(
    sidebar, "سكربت تحت الاختبار",
    UDim2.new(1, -18, 0, 35),
    UDim2.fromOffset(10, 190),
    9, COLORS.Accent
)

--==================================================
-- PAGE CONTAINER
--==================================================

local content = new("Frame", {
    Name = "PageContainer",
    Position = UDim2.fromOffset(132, 44),
    Size = UDim2.new(1, -132, 1, -44),
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

    homeTab.BackgroundColor3 =
        isHome and COLORS.Accent or COLORS.Card

    playerTab.BackgroundColor3 =
        isHome and COLORS.Card or COLORS.Accent
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

label(
    homePage, "الصفحة الرئيسية",
    UDim2.new(1, -24, 0, 30),
    UDim2.fromOffset(12, 9),
    18, COLORS.Text
)

label(
    homePage, "اختَر العملية التي تريد تنفيذها",
    UDim2.new(1, -24, 0, 20),
    UDim2.fromOffset(12, 37),
    10, COLORS.Muted
)

local function makeActionCard(
    y, title, description, buttonText, accent
)
    local card = new("Frame", {
        Size = UDim2.new(1, -24, 0, 67),
        Position = UDim2.fromOffset(12, y),
        BackgroundColor3 = COLORS.Panel,
        BorderSizePixel = 0,
    }, homePage)

    round(card, 10)
    outline(card, COLORS.Border)

    new("Frame", {
        Size = UDim2.fromOffset(3, 38),
        Position = UDim2.fromOffset(0, 14),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
    }, card)

    label(
        card, title,
        UDim2.new(1, -125, 0, 23),
        UDim2.fromOffset(10, 8),
        12, COLORS.Text
    )

    label(
        card, description,
        UDim2.new(1, -125, 0, 22),
        UDim2.fromOffset(10, 32),
        9, COLORS.Muted
    )

    return makeButton(
        card, buttonText,
        UDim2.fromOffset(88, 32),
        UDim2.new(1, -100, 0.5, -16),
        accent
    )
end

-- Original coordinates preserved

local posInsidePrison = CFrame.new(2103.50 ,4.77, -151.28)

local spawnPos = Vector3.new(
    2042.36865234375,
    2.7812340259552,
    1884.031494140625
)

local posOriginalSpawn = CFrame.new(
    spawnPos.X, spawnPos.Y, spawnPos.Z
)

local targetCoord =
    CFrame.new(34918.96, 19915.68, 4876.06)

local function teleportAndLock(cf)
    local character = player.Character

    if not character then
        return
    end

    local root =
        character:FindFirstChild("HumanoidRootPart")

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

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
    65,
    "الانتقال إلى السجن",
    "الإحداثيات المحددة للسجن",
    "انتقال",
    COLORS.Blue
)

local spawnBtn = makeActionCard(
    140,
    "الرجوع إلى السبون",
    "العودة إلى نقطة السبون",
    "رجوع",
    COLORS.Red
)

local targetBtn = makeActionCard(
    215,
    "الإحداثيات الجديدة",
    "الانتقال إلى الموقع المحدد",
    "انتقال",
    COLORS.Green
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

label(
    playerPage, "صفحة اللاعب",
    UDim2.new(1, -24, 0, 30),
    UDim2.fromOffset(12, 9),
    18, COLORS.Text
)

label(
    playerPage, "ابحث عن لاعب في السيرفر الحالي",
    UDim2.new(1, -24, 0, 20),
    UDim2.fromOffset(12, 37),
    10, COLORS.Muted
)

local searchBox = new("TextBox", {
    Name = "PlayerSearch",
    Size = UDim2.new(1, -106, 0, 34),
    Position = UDim2.fromOffset(12, 65),
    BackgroundColor3 = COLORS.Input,
    TextColor3 = COLORS.Text,
    PlaceholderColor3 = COLORS.Muted,
    PlaceholderText = "Username أو Display Name...",
    Text = "",
    TextSize = 11,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    BorderSizePixel = 0,
}, playerPage)

round(searchBox, 8)
outline(searchBox, COLORS.Border)

local searchBtn = makeButton(
    playerPage, "بحث",
    UDim2.fromOffset(76, 34),
    UDim2.new(1, -88, 0, 65),
    COLORS.Accent
)

-- Player profile

local profileCard = new("Frame", {
    Size = UDim2.new(1, -24, 0, 91),
    Position = UDim2.fromOffset(12, 108),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
}, playerPage)

round(profileCard, 10)
outline(profileCard, COLORS.Border)

local avatar = new("ImageLabel", {
    Name = "Avatar",
    Size = UDim2.fromOffset(65, 65),
    Position = UDim2.fromOffset(10, 13),
    BackgroundColor3 = COLORS.Card,
    Image = "",
    ScaleType = Enum.ScaleType.Crop,
    BorderSizePixel = 0,
}, profileCard)

round(avatar, 10)

local nameLabel = label(
    profileCard, "لم يتم تحديد لاعب",
    UDim2.new(1, -98, 0, 24),
    UDim2.fromOffset(86, 12),
    12, COLORS.Text
)

local usernameLabel = label(
    profileCard, "Username: —",
    UDim2.new(1, -98, 0, 20),
    UDim2.fromOffset(86, 36),
    10, COLORS.Muted
)

local inventoryCountLabel = label(
    profileCard, "الأدوات: —",
    UDim2.new(1, -98, 0, 20),
    UDim2.fromOffset(86, 57),
    9, COLORS.Green
)

label(
    playerPage, "INVENTORY",
    UDim2.new(1, -24, 0, 18),
    UDim2.fromOffset(12, 207),
    9, COLORS.Muted
)

local inventoryList = new("ScrollingFrame", {
    Name = "InventoryList",
    Size = UDim2.new(1, -24, 0, 91),
    Position = UDim2.fromOffset(12, 228),
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
    PaddingTop = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 5),
    PaddingLeft = UDim.new(0, 7),
    PaddingRight = UDim.new(0, 7),
}, inventoryList)

new("UIListLayout", {
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, inventoryList)

--==================================================
-- PLAYER SEARCH
--==================================================

local function clearInventory()
    for _, child in ipairs(inventoryList:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end

local function addInventoryItem(text, color)
    local itemLabel = new("TextLabel", {
        Size = UDim2.new(1, -4, 0, 24),
        BackgroundColor3 = COLORS.Card,
        BackgroundTransparency = 0.15,
        Text = "   " .. text,
        TextColor3 = color or COLORS.Text,
        TextSize = 10,
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

    for _, target in ipairs(Players:GetPlayers()) do
        if target.Name:lower() == name:lower()
            or target.DisplayName:lower() == name:lower() then
            return target
        end
    end

    local match = nil

    for _, target in ipairs(Players:GetPlayers()) do
        if target.Name:lower():find(name:lower(), 1, true)
            or target.DisplayName:lower():find(name:lower(), 1, true) then

            if match then
                return nil
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
        nameLabel.Text = "اللاعب غير موجود"
        usernameLabel.Text = "تحقق من الاسم وحاول مجدداً"
        inventoryCountLabel.Text = "الأدوات: —"

        addInventoryItem(
            "لم يتم العثور على لاعب مطابق",
            COLORS.Red
        )

        return
    end

    nameLabel.Text = target.DisplayName
    usernameLabel.Text = "@" .. target.Name
    inventoryCountLabel.Text = "جارٍ تحميل البيانات..."

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
    local backpack = target:FindFirstChildOfClass("Backpack")

    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(items, item.Name)
            end
        end
    end

    local character = target.Character

    if character then
        for _, item in ipairs(character:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(items, item.Name)
            end
        end
    end

    inventoryCountLabel.Text =
        "الأدوات الظاهرة: " .. #items

    if #items == 0 then
        addInventoryItem(
            "لا توجد أدوات ظاهرة أو المحتويات غير متاحة",
            COLORS.Muted
        )
    else
        for _, itemName in ipairs(items) do
            addInventoryItem(
                "◆   " .. itemName,
                COLORS.Text
            )
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
-- SINGLE HIDE / SHOW BUTTON
--==================================================

local toggleBtn = makeButton(
    gui, "✕",
    UDim2.fromOffset(42, 42),
    UDim2.new(0, 14, 0.5, -21),
    COLORS.Accent
)

toggleBtn.Name = "ToggleButton"
toggleBtn.TextSize = 18
toggleBtn.ZIndex = 10

round(toggleBtn, 13)
outline(toggleBtn, COLORS.Border)

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

-- Initial page
switchPage("Home")

print("MILLER PANEL loaded | Script under testing")


-- MILLER PANEL | Target Selector
-- Add this code to your existing LocalScript.
-- It uses the existing: player, Players, playerPage,
-- searchBox, and searchBtn variables.

local UserInputService = game:GetService("UserInputService")
local mouse = player:GetMouse()

local selectingTarget = false
local selectedTarget = nil

-- Target selector button
local targetButton = Instance.new("TextButton")
targetButton.Name = "TargetSelectorButton"
targetButton.Size = UDim2.new(1, -32, 0, 34)
targetButton.Position = UDim2.fromOffset(16, 345)
targetButton.BackgroundColor3 = Color3.fromRGB(111, 91, 255)
targetButton.TextColor3 = Color3.new(1, 1, 1)
targetButton.TextSize = 12
targetButton.Font = Enum.Font.GothamSemibold
targetButton.Text = "تحديد لاعب بالنقر"
targetButton.Parent = playerPage

Instance.new("UICorner", targetButton).CornerRadius =
    UDim.new(0, 8)

local targetStatus = Instance.new("TextLabel")
targetStatus.Name = "TargetStatus"
targetStatus.Size = UDim2.new(1, -32, 0, 24)
targetStatus.Position = UDim2.fromOffset(16, 319)
targetStatus.BackgroundTransparency = 1
targetStatus.TextColor3 = Color3.fromRGB(145, 155, 175)
targetStatus.TextSize = 11
targetStatus.Font = Enum.Font.Gotham
targetStatus.Text = "الهدف الحالي: لا يوجد"
targetStatus.TextXAlignment = Enum.TextXAlignment.Left
targetStatus.Parent = playerPage

local function getPlayerFromTarget(part)
    if not part then
        return nil
    end

    local model = part:FindFirstAncestorOfClass("Model")
    if not model then
        return nil
    end

    return Players:GetPlayerFromCharacter(model)
end

targetButton.Activated:Connect(function()
    selectingTarget = not selectingTarget

    if selectingTarget then
        targetButton.Text = "وضع التحديد مفعّل — انقر على لاعب"
        targetButton.BackgroundColor3 =
            Color3.fromRGB(42, 190, 135)
    else
        targetButton.Text = "تحديد لاعب بالنقر"
        targetButton.BackgroundColor3 =
            Color3.fromRGB(111, 91, 255)
    end
end)

mouse.Button1Down:Connect(function()
    if not selectingTarget then
        return
    end

    local target = getPlayerFromTarget(mouse.Target)

    if not target or target == player then
        return
    end

    selectedTarget = target
    selectingTarget = false

    -- Update the existing player search field
    searchBox.Text = target.Name

    targetStatus.Text = "الهدف الحالي: " .. target.DisplayName
    targetButton.Text = "تحديد لاعب بالنقر"
    targetButton.BackgroundColor3 =
        Color3.fromRGB(111, 91, 255)

    -- Open the player page and run its existing search
    playerPage.Visible = true

    if homePage then
        homePage.Visible = false
    end

    if homeTab then
        homeTab.BackgroundColor3 =
            Color3.fromRGB(28, 34, 48)
    end

    if playerTab then
        playerTab.BackgroundColor3 =
            Color3.fromRGB(111, 91, 255)
    end

    searchBtn:Activate()
end)

-- Clear the selected target if they leave the server
Players.PlayerRemoving:Connect(function(leavingPlayer)
    if selectedTarget == leavingPlayer then
        selectedTarget = nil
        targetStatus.Text = "الهدف الحالي: لا يوجد"
    end
end)
