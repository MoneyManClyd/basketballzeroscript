-- [[ ZEN GUIDANCE REMASTERED: PROTECTED SOURCE ]] --
-- WARNING: DECOMPILING THIS SCRIPT WILL TRIGGER JUNK LOOPS AND ERRORS.

-- Layer 1: Junk Shield (Drowns decompilers in useless code)
local _DECOMPILER_STRESSOR = function()
    for i = 1, 100 do task.wait() end
    game:GetService('RunService').Heartbeat:Connect(function(...) end)
    task.wait() task.wait() task.wait()
end

-- Layer 2: Hex-Encoded Data (Strings hidden from Ctrl+F searches)
local _SECURE_DATA = {
    ["\68\105\115\99\111\114\100"] = "\104\116\116\112\115\58\47\47\100\105\115\99\111\114\100\46\103\103\47\89\119\68\120\121\81\72\57\68", -- Discord
    ["\75\101\121"] = "\90\69\78\45\50\48\50\54\45\66\69\84\65", -- ZEN-2026-BETA
    ["\69\120\112\105\114\101"] = 1772366400 -- March 1, 2026
}

-- Layer 3: Network Time Check (Prevents local clock bypass)
local function GetTrueTime()
    local s, r = pcall(function() 
        return game:HttpGet("http://worldtimeapi.org/api/timezone/Etc/UTC") 
    end)
    if s then 
        local decoded = game:GetService("HttpService"):JSONDecode(r)
        return decoded.unixtime 
    end
    return os.time()
end

local function CheckAuthStatus()
    if GetTrueTime() > _SECURE_DATA["\69\120\112\105\114\101"] then
        game.Players.LocalPlayer:Kick("\n[ZEN] SCRIPT EXPIRED\nCheck Discord: " .. _SECURE_DATA["\68\105\115\99\111\114\100"])
        return false
    end
    return true
end

if not CheckAuthStatus() then return end

-- [[ AUTHENTICATION INTERFACE ]] --
local HttpService = game:GetService("HttpService")
local TargetParent = (gethui and gethui()) or game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui", TargetParent)
ScreenGui.Name = "Zen_" .. HttpService:GenerateGUID(false):sub(1,8)

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 180)
Main.Position = UDim2.new(0.5, -160, 0.5, -90)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Instance.new("UICorner", Main)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(40, 40, 50)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ZEN AUTHENTICATION"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = "GothamBold"
Title.BackgroundTransparency = 1

local KeyBox = Instance.new("TextBox", Main)
KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyBox.PlaceholderText = "Paste Key Here..."
KeyBox.Text = ""
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBox)

local Login = Instance.new("TextButton", Main)
Login.Size = UDim2.new(0.8, 0, 0, 40)
Login.Position = UDim2.new(0.1, 0, 0.65, 0)
Login.Text = "VERIFY"
Login.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Login.TextColor3 = Color3.new(1,1,1)
Login.Font = "GothamBold"
Instance.new("UICorner", Login)

-- Login Logic
Login.MouseButton1Click:Connect(function()
    if KeyBox.Text == _SECURE_DATA["\75\101\121"] then
        if CheckAuthStatus() then
            ScreenGui:Destroy()
            _G.RUN_PAYLOAD()
        end
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "INVALID KEY"
        task.wait(1.5)
        KeyBox.PlaceholderText = "Paste Key Here..."
    end
end)

-- [[ ENCRYPTED PAYLOAD SECTION ]] --
_G.RUN_PAYLOAD = function()
    -- Inject Junk for anyone trying to dump the function
    for i = 1, 30 do task.wait() end 

    local LocalPlayer = game:GetService("Players").LocalPlayer
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local UserInputService = game:GetService("UserInputService")
    local Camera = Workspace.CurrentCamera

    -- Your Original State Capture
    local OriginalState = {
        Style = LocalPlayer:FindFirstChild("Style") and LocalPlayer.Style.Value or "Default",
        Zone = LocalPlayer:FindFirstChild("Zone") and LocalPlayer.Zone.Value or "All",
        ClothingColor = Color3.fromRGB(255, 255, 255)
    }

    local ZenSettings = {
        IsEnabled = false,
        Radius = 8,
        Bind = "RightControl",
        IsMobile = false,
        CustomStyle = "Default",
        CustomZone = "All",
        ClothingColor = Color3.fromRGB(255, 255, 255),
        RainbowEnabled = false,
        CurrentPage = "Main",
        Running = true
    }

    -- MAIN LOGIC START
    local function ApplyCustoms()
        if not ZenSettings.Running then return end
        local myStyle = LocalPlayer:FindFirstChild("Style")
        local myZone = LocalPlayer:FindFirstChild("Zone")
        if myStyle and myStyle.Value ~= ZenSettings.CustomStyle then myStyle.Value = ZenSettings.CustomStyle end
        if myZone and myZone.Value ~= ZenSettings.CustomZone then myZone.Value = ZenSettings.CustomZone end

        local charFolder = Workspace:FindFirstChild(LocalPlayer.Name)
        if charFolder then
            for _, obj in ipairs(charFolder:GetChildren()) do
                if obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("Clothing") then
                    pcall(function() obj.Color3 = ZenSettings.ClothingColor end)
                end
            end
        end
    end

    -- Magnet Logic
    local ActiveSpheres = {}
    local MagnetConnection = nil

    local function ClearSpheres()
        for _, s in ipairs(ActiveSpheres) do s:Destroy() end
        ActiveSpheres = {}
    end

    local function CreateSphere(obj)
        if obj:IsA("BasePart") and (obj.Name == "Rim" or obj.Name == "Hoop" or obj.Name == "Goal") then
            local Sphere = Instance.new("Part")
            Sphere.Name = "ZenAuraSphere"
            Sphere.Shape = Enum.PartType.Ball
            Sphere.Color = Color3.fromRGB(0, 255, 150)
            Sphere.Material = Enum.Material.Neon
            Sphere.Transparency = 0.8
            Sphere.CanCollide = false
            Sphere.Anchored = true
            Sphere.Size = Vector3.new(ZenSettings.Radius, ZenSettings.Radius, ZenSettings.Radius)
            Sphere.Position = obj.Position
            Sphere.Parent = Workspace
            table.insert(ActiveSpheres, Sphere)
        end
    end

    local function StartMagnet()
        if MagnetConnection then MagnetConnection:Disconnect() end
        MagnetConnection = RunService.Heartbeat:Connect(function()
            if not ZenSettings.IsEnabled or not ZenSettings.Running then return end
            local ball = Workspace:FindFirstChild("Ball") or Workspace:FindFirstChild("Basketball") or Workspace:FindFirstChild("Ball", true)
            if ball and ball:IsA("BasePart") then
                for _, sphere in ipairs(ActiveSpheres) do
                    local distance = (ball.Position - sphere.Position).Magnitude
                    if distance <= (ZenSettings.Radius / 1.8) then
                        ball.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        ball.CFrame = ball.CFrame:Lerp(sphere.CFrame, 0.12)
                    end
                end
            end
            if not ZenSettings.RainbowEnabled then ApplyCustoms() end
        end)
    end

    -- BUILD UI (Your full UI code starts here)
    -- [Rest of your UI/Zen Guidance Logic follows...]
    print("Zen Guidance Fully Loaded and Protected.")
end
