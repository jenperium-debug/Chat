-- ============================================================
-- RYZEN X v1.1 - ROBLOX SCRIPT (ЛИЧНОЕ ИСПОЛЬЗОВАНИЕ)
-- ============================================================
-- ИЗМЕНЕНИЯ: КЛАВИША INSERT ЗАМЕНЕНА НА END
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ==================== НАСТРОЙКИ ====================
local Settings = {
    AimFov = 150,
    AimSmoothness = 0.3,
    AimPart = "Head",
    FlySpeed = 50,
    NoclipEnabled = false,
    FlyEnabled = false,
    AimbotEnabled = false,
    VisibleCheck = true,
    TeamCheck = false,
    ShowFov = true,
    MenuOpen = false,
    SilentAim = false
}

-- ==================== ЦВЕТА ====================
local Colors = {
    Green = Color3.fromRGB(0, 255, 0),
    Red = Color3.fromRGB(255, 0, 0),
    Blue = Color3.fromRGB(0, 150, 255),
    White = Color3.fromRGB(255, 255, 255),
    Black = Color3.fromRGB(0, 0, 0),
    Dark = Color3.fromRGB(30, 30, 30)
}

-- ==================== UI ЭЛЕМЕНТЫ ====================
local function CreateMenu()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RyzenMenu"
    ScreenGui.Parent = LocalPlayer.PlayerGui
    ScreenGui.ResetOnSpawn = false
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui
    
    -- Заголовок
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.fromRGB(0, 200, 50)
    Title.BackgroundTransparency = 0.3
    Title.BorderSizePixel = 0
    Title.Text = "RYZEN X v1.1"
    Title.TextColor3 = Colors.White
    Title.TextSize = 22
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame
    
    -- Заголовок закрытия
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.BackgroundTransparency = 0.2
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Colors.White
    CloseBtn.TextSize = 18
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = MainFrame
    CloseBtn.MouseButton1Click:Connect(function()
        Settings.MenuOpen = false
        MainFrame.Visible = false
    end)
    
    -- Список функций
    local function CreateToggle(name, desc, yPos, settingKey)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -20, 0, 35)
        Frame.Position = UDim2.new(0, 10, 0, yPos)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        Frame.BackgroundTransparency = 0.3
        Frame.BorderSizePixel = 0
        Frame.Parent = MainFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.6, 0, 1, 0)
        Label.Position = UDim2.new(0, 5, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Colors.White
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Font = Enum.Font.Gotham
        Label.Parent = Frame
        
        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(1, 0, 0, 14)
        Desc.Position = UDim2.new(0, 5, 0, 20)
        Desc.BackgroundTransparency = 1
        Desc.Text = desc
        Desc.TextColor3 = Color3.fromRGB(150, 150, 150)
        Desc.TextSize = 10
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.Font = Enum.Font.Gotham
        Desc.Parent = Frame
        
        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(0, 50, 0, 25)
        Toggle.Position = UDim2.new(1, -55, 0, 5)
        Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        Toggle.BorderSizePixel = 0
        Toggle.Text = "OFF"
        Toggle.TextColor3 = Colors.White
        Toggle.TextSize = 12
        Toggle.Font = Enum.Font.GothamBold
        Toggle.Parent = Frame
        
        local state = false
        Toggle.MouseButton1Click:Connect(function()
            state = not state
            if state then
                Toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 50)
                Toggle.Text = "ON"
            else
                Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
                Toggle.Text = "OFF"
            end
            Settings[settingKey] = state
        end)
        
        return Toggle
    end
    
    local yPos = 45
    CreateToggle("Aimbot", "Автоматическое наведение", yPos, "AimbotEnabled")
    yPos = yPos + 40
    CreateToggle("Silent Aim", "Невидимое наведение", yPos, "SilentAim")
    yPos = yPos + 40
    CreateToggle("Fly", "Режим полета", yPos, "FlyEnabled")
    yPos = yPos + 40
    CreateToggle("Noclip", "Проход сквозь стены", yPos, "NoclipEnabled")
    yPos = yPos + 40
    CreateToggle("FOV Circle", "Показать область FOV", yPos, "ShowFov")
    yPos = yPos + 40
    CreateToggle("Visible Check", "Проверка видимости", yPos, "VisibleCheck")
    yPos = yPos + 40
    CreateToggle("Team Check", "Проверка команды", yPos, "TeamCheck")
    
    -- Ползунок FOV
    local FovFrame = Instance.new("Frame")
    FovFrame.Size = UDim2.new(1, -20, 0, 40)
    FovFrame.Position = UDim2.new(0, 10, 0, yPos + 5)
    FovFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    FovFrame.BackgroundTransparency = 0.3
    FovFrame.BorderSizePixel = 0
    FovFrame.Parent = MainFrame
    
    local FovLabel = Instance.new("TextLabel")
    FovLabel.Size = UDim2.new(0.5, 0, 1, 0)
    FovLabel.Position = UDim2.new(0, 5, 0, 0)
    FovLabel.BackgroundTransparency = 1
    FovLabel.Text = "FOV: 150"
    FovLabel.TextColor3 = Colors.White
    FovLabel.TextSize = 14
    FovLabel.TextXAlignment = Enum.TextXAlignment.Left
    FovLabel.Font = Enum.Font.Gotham
    FovLabel.Parent = FovFrame
    
    local FovSlider = Instance.new("TextButton")
    FovSlider.Size = UDim2.new(0.4, 0, 0, 20)
    FovSlider.Position = UDim2.new(0.5, 10, 0, 10)
    FovSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    FovSlider.BorderSizePixel = 0
    FovSlider.Text = ""
    FovSlider.Parent = FovFrame
    
    local FovFill = Instance.new("Frame")
    FovFill.Size = UDim2.new(0.5, 0, 1, 0)
    FovFill.BackgroundColor3 = Color3.fromRGB(0, 200, 50)
    FovFill.BorderSizePixel = 0
    FovFill.Parent = FovSlider
    
    local dragging = false
    FovSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    FovSlider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local absPos = FovSlider.AbsolutePosition
            local size = FovSlider.AbsoluteSize
            local percent = math.clamp((mousePos.X - absPos.X) / size.X, 0, 1)
            Settings.AimFov = math.floor(50 + percent * 250)
            FovFill.Size = UDim2.new(percent, 0, 1, 0)
            FovLabel.Text = "FOV: " .. Settings.AimFov
        end
    end)
    
    -- Привязка клавиш
    local KeyBindFrame = Instance.new("Frame")
    KeyBindFrame.Size = UDim2.new(1, -20, 0, 30)
    KeyBindFrame.Position = UDim2.new(0, 10, 0, yPos + 50)
    KeyBindFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    KeyBindFrame.BackgroundTransparency = 0.3
    KeyBindFrame.BorderSizePixel = 0
    KeyBindFrame.Parent = MainFrame
    
    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Size = UDim2.new(0.6, 0, 1, 0)
    KeyLabel.Position = UDim2.new(0, 5, 0, 0)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.Text = "Toggle Menu: [END]"
    KeyLabel.TextColor3 = Colors.White
    KeyLabel.TextSize = 14
    KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeyLabel.Font = Enum.Font.Gotham
    KeyLabel.Parent = KeyBindFrame
    
    return MainFrame, ScreenGui
end

-- ==================== FOV КРУГ ====================
local FovCircle = Instance.new("Frame")
FovCircle.Size = UDim2.new(0, 300, 0, 300)
FovCircle.Position = UDim2.new(0.5, -150, 0.5, -150)
FovCircle.BackgroundColor3 = Colors.Green
FovCircle.BackgroundTransparency = 0.8
FovCircle.BorderSizePixel = 2
FovCircle.BorderColor3 = Colors.Green
FovCircle.Visible = false
FovCircle.ZIndex = 0
FovCircle.Parent = LocalPlayer.PlayerGui

-- ==================== AIMBOT ====================
local function GetClosestPlayer()
    local closest = nil
    local shortestDist = Settings.AimFov
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if Settings.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                local head = character:FindFirstChild(Settings.AimPart) or character:FindFirstChild("Head")
                if head then
                    local screenPos, onScreen = Camera:WorldToScreenPoint(head.Position)
                    if onScreen then
                        local distance = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                        if distance < shortestDist then
                            if Settings.VisibleCheck then
                                local ray = Ray.new(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit * 1000)
                                local hit = workspace:FindPartOnRay(ray, LocalPlayer.Character)
                                if hit and hit:IsDescendantOf(character) then
                                    closest = player
                                    shortestDist = distance
                                end
                            else
                                closest = player
                                shortestDist = distance
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closest
end

-- ==================== FLY ====================
local FlyEnabled = false
local FlySpeed = 50
local BodyVelocity = nil
local BodyGyro = nil

local function StartFly()
    if FlyEnabled then return end
    FlyEnabled = true
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
    
    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    BodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart")
    
    BodyGyro = Instance.new("BodyGyro")
    BodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
    BodyGyro.Parent = character:FindFirstChild("HumanoidRootPart")
    
    local function updateFly()
        if not FlyEnabled or not BodyVelocity then
            return
        end
        
        local direction = Vector3.new()
        local moveVector = Vector3.new()
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveVector = moveVector + Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveVector = moveVector - Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveVector = moveVector - Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveVector = moveVector + Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveVector = moveVector + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveVector = moveVector - Vector3.new(0, 1, 0)
        end
        
        if moveVector.Magnitude > 0 then
            moveVector = moveVector.Unit * Settings.FlySpeed
            BodyVelocity.Velocity = moveVector
        else
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        
        BodyGyro.CFrame = Camera.CFrame
    end
    
    RunService.Heartbeat:Connect(updateFly)
end

local function StopFly()
    FlyEnabled = false
    
    if BodyVelocity then
        BodyVelocity:Destroy()
        BodyVelocity = nil
    end
    if BodyGyro then
        BodyGyro:Destroy()
        BodyGyro = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

-- ==================== NOCLIP ====================
local NoclipEnabled = false
local NoclipConnections = {}

local function StartNoclip()
    if NoclipEnabled then return end
    NoclipEnabled = true
    
    local function noclipLoop()
        if not NoclipEnabled then return end
        
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
    
    local connection = RunService.Heartbeat:Connect(noclipLoop)
    table.insert(NoclipConnections, connection)
end

local function StopNoclip()
    NoclipEnabled = false
    
    for _, conn in pairs(NoclipConnections) do
        conn:Disconnect()
    end
    NoclipConnections = {}
    
    local character = LocalPlayer.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- ==================== ОСНОВНОЙ ЦИКЛ ====================
local MainFrame, ScreenGui = CreateMenu()
local aimTarget = nil

RunService.Heartbeat:Connect(function()
    -- Aimbot
    if Settings.AimbotEnabled then
        local target = GetClosestPlayer()
        if target then
            local character = target.Character
            if character then
                local head = character:FindFirstChild(Settings.AimPart) or character:FindFirstChild("Head")
                if head then
                    if Settings.SilentAim then
                        -- Silent aim - наведение без поворота камеры
                        local direction = (head.Position - Camera.CFrame.Position).Unit
                        -- Реализация через CFrame
                    else
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
                    end
                end
            end
        end
    end
    
    -- FOV обновление
    if Settings.ShowFov then
        FovCircle.Visible = true
        FovCircle.Size = UDim2.new(0, Settings.AimFov * 2, 0, Settings.AimFov * 2)
        FovCircle.Position = UDim2.new(0.5, -Settings.AimFov, 0.5, -Settings.AimFov)
    else
        FovCircle.Visible = false
    end
    
    -- Fly toggle
    if Settings.FlyEnabled ~= FlyEnabled then
        if Settings.FlyEnabled then
            StartFly()
        else
            StopFly()
        end
    end
    
    -- Noclip toggle
    if Settings.NoclipEnabled ~= NoclipEnabled then
        if Settings.NoclipEnabled then
            StartNoclip()
        else
            StopNoclip()
        end
    end
end)

-- ==================== УПРАВЛЕНИЕ ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Открытие меню по END (вместо INSERT)
    if input.KeyCode == Enum.KeyCode.End then
        Settings.MenuOpen = not Settings.MenuOpen
        MainFrame.Visible = Settings.MenuOpen
        return
    end
    
    -- Горячие клавиши
    if input.KeyCode == Enum.KeyCode.F1 then
        Settings.AimbotEnabled = not Settings.AimbotEnabled
    end
    if input.KeyCode == Enum.KeyCode.F2 then
        Settings.FlyEnabled = not Settings.FlyEnabled
    end
    if input.KeyCode == Enum.KeyCode.F3 then
        Settings.NoclipEnabled = not Settings.NoclipEnabled
    end
end)

-- ==================== ОЧИСТКА ====================
LocalPlayer.CharacterAdded:Connect(function()
    if FlyEnabled then
        StopFly()
        if Settings.FlyEnabled then
            wait(0.1)
            StartFly()
        end
    end
    if NoclipEnabled then
        StopNoclip()
        wait(0.1)
        StartNoclip()
    end
end)

-- ==================== ЗАПУСК ====================
print("RYZEN X v1.1 Загружен!")
print("[END] - Открыть меню")
print("[F1] - Aimbot")
print("[F2] - Fly")
print("[F3] - Noclip")
