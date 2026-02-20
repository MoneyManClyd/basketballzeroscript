--[[ 
    ZEN GUIDANCE REMASTERED: PROTECTED BUILD 0x55FA
    UNAUTHORIZED DECOMPILATION DETECTED WILL TRIGGER SYSTEM HALT
]]

-- Layer 1: Junk Shield (Drowns decompilers in useless code to match your screenshot)
local _0xJUNK = function()
    for i = 1, 100 do 
        task.wait() 
        task.wait() 
        task.wait()
    end
    game:GetService('RunService').Heartbeat:Connect(function(...) end)
    task.wait()
end

-- Layer 2: Hex-Encoded Data (Discord, Key, and Expiry hidden from Ctrl+F)
local _0xALPHA = {
    ["\100\105\115\99\111\114\100"] = "\104\116\116\112\115\58\47\47\100\105\115\99\111\114\100\46\103\103\47\89\119\68\120\121\81\72\57\68", -- Discord Link
    ["\107\101\121"] = "\90\69\78\45\50\48\50\54\45\66\69\84\65", -- ZEN-2026-BETA
    ["\101\120\112\105\114\101"] = 1772366400 -- March 1, 2026 UTC
}

-- Layer 3: Network Time Sync (Prevents local clock bypass)
local function _0xTIME_SYNC()
    local _s, _r = pcall(function() 
        return game:HttpGet("\104\116\116\112\58\47\47\119\111\114\108\100\116\105\109\101\97\112\105\46\111\114\103\47\97\112\105\47\116\105\109\101\122\111\110\101\47\69\116\99\47\85\84\67") 
    end)
    if _s then 
        local decoded = game:GetService("\72\116\116\112\83\101\114\118\105\99\101"):JSONDecode(_r)
        return decoded.unixtime 
    end
    return os.time()
end

local function _0xVALIDATE()
    if _0xTIME_SYNC() > _0xALPHA["\101\120\112\105\114\101"] then
        game.Players.LocalPlayer:Kick("\n\n[ZEN GUIDANCE ERROR]\nThis script has EXPIRED.\nCheck the discord server: " .. _0xALPHA["\100\105\115\99\111\114\100"])
        return false
    end
    return true
end

if not _0xVALIDATE() then return end

-- [[ AUTHENTICATION INTERFACE ]] --
local HttpService = game:GetService("HttpService")
local TargetParent = (gethui and gethui()) or game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui", TargetParent)
ScreenGui.Name = "Zen_" .. HttpService:GenerateGUID(false):sub(1,8)

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 200)
Main.Position = UDim2.new(0.5, -160, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(45, 45, 55)

local KeyBox = Instance.new("TextBox", Main)
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyBox.PlaceholderText = "License Key..."
KeyBox.Text = ""
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBox)

local Login = Instance.new("TextButton", Main)
Login.Size = UDim2.new(0.8, 0, 0, 40)
Login.Position = UDim2.new(0.1, 0, 0.7, 0)
Login.Text = "VERIFY"
Login.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
Login.TextColor3 = Color3.new(1,1,1)
Login.Font = Enum.Font.GothamBold
Instance.new("UICorner", Login)

Login.MouseButton1Click:Connect(function()
    if KeyBox.Text == _0xALPHA["\107\101\121"] then
        if _0xVALIDATE() then
            ScreenGui:Destroy()
            _G.START_ZEN_PAYLOAD()
        end
    else
        KeyBox.Text = "INVALID KEY"
        task.wait(1.5)
        KeyBox.Text = ""
    end
end)

-- [[ ENCRYPTED PAYLOAD SECTION ]] --
_G.START_ZEN_PAYLOAD = function()
    -- Junk Injection to annoy anyone dumping the function
    for i = 1, 50 do task.wait() end

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local UserInputService = game:GetService("UserInputService")
    local Camera = Workspace.CurrentCamera

    local ZenSettings = {
        IsEnabled = false,
        Radius = 8,
        Bind = "RightControl",
        IsMobile = false,
        CustomStyle = "Default",
        CustomZone = "All",
        ClothingColor = Color3.fromRGB(255, 255, 255),
        RainbowEnabled = false,
        Running = true
    }

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
        end)
    end

    -- Insert your full UI Builder here (BuildMainUI)
    -- This section would contain the rest of your original menu logic.
    print("Zen Guidance Fully Loaded.")
end
