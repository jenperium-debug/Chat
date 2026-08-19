-- ============================================================
-- RYZEN X v1.3 - ПОСТОЯННОЕ МЕНЮ (НЕ ЗАКРЫВАЕТСЯ)
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

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
    SilentAim = false
}

-- ==================== ЦВЕТА ====================
local Colors = {
    Green = Color3.fromRGB(0, 255, 0),
    Red = Color3.fromRGB(255, 0, 0),
    Blue = Color3.fromRGB(0, 150, 255),
    White = Color3.fromRGB(255, 255, 255),
    Black = Color3.fromRGB(0, 0, 0),
    Dark = Color3.fromRGB(20, 20, 25),
    Darker = Color3.fromRGB(15, 15, 20)
}

-- ==================== СОЗДАНИЕ ПОСТОЯННОГО МЕНЮ ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RyzenMenu"
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ResetOnSpawn = false

-- Главная рамка
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 480)
MainFrame.Position = UDim2.new(0.01, 10, 0.5, -240)
MainFrame.BackgroundColor3 = Colors.Dark
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Colors.Green
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Colors.Green
Title.BackgroundTransparency = 0.2
Title.BorderSizePixel = 0
Title.Text = "RYZEN X v1.3"
Title.TextColor3 = Colors.White
Title.TextSize = 24
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Разделитель
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.9, 0, 0, 2)
Divider.Position = UDim2.new(0.05, 0, 0, 42)
Divider.BackgroundColor3 = Colors.Green
Divider.BackgroundTransparency = 0.5
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- ==================== ФУНКЦИЯ СОЗДАНИЯ ПЕРЕКЛЮЧАТЕЛЯ ====================
local function CreateToggle(name, desc, yPos, settingKey, color)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.95, 0, 0, 45)
    Frame.Position = UDim2.new(0.025, 0, 0, yPos)
    Frame.BackgroundColor3 = Colors.Darker
    Frame.BackgroundTransparency = 0.3
    Frame.BorderSizePixel = 1
    Frame.BorderColor3 = Color3.fromRGB(40, 40, 45)
    Frame.Parent = MainFrame
    
    -- Название
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 0.6, 0)
    Label.Position = UDim2.new(0, 10, 0, 2)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Colors.White
    Label.TextSize = 15
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamBold
    Label.Parent = Frame
    
    -- Описание
    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(0.8, 0, 0.4, 0)
    Desc.Position = UDim2.new(0, 10, 0.5, 0)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.Font = Enum.Font.Gotham
    Desc.Parent = Frame
    
    -- Кнопка переключения
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 60, 0, 30)
    Toggle.Position = UDim2.new(1, -70, 0, 7)
    Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    Toggle.BorderSizePixel = 0
    Toggle.Text = "OFF"
    Toggle.TextColor3 = Colors.White
    Toggle.TextSize = 14
    Toggle.Font = Enum.Font.GothamBold
    Toggle.Parent = Frame
    
    local state = false
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        if state then
            Toggle.BackgroundColor3 = Colors.Green
            Toggle.Text = "ON"
        else
            Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
            Toggle.Text = "OFF"
        end
        Settings[settingKey] = state
    end)
    
    return Toggle
end

-- ==================== СОЗДАНИЕ ВСЕХ ПЕРЕКЛЮЧАТЕЛЕЙ ====================
local yPos = 50
CreateToggle("Aimbot", "Автоматическое наведение на цель", yPos, "AimbotEnabled")
yPos = yPos + 50
CreateToggle("Silent Aim", "Невидимое наведение (не поворачивает камеру)", yPos, "SilentAim")
yPos = yPos + 50
CreateToggle("Fly", "Режим полета (WASD + Space/Shift)", yPos, "FlyEnabled")
yPos = yPos + 50
CreateToggle("Noclip", "Проход сквозь стены и объекты", yPos, "NoclipEnabled")
yPos = yPos + 50
CreateToggle("FOV Circle", "Показать радиус поиска цели", yPos, "ShowFov")
yPos = yPos + 50
CreateToggle("Visible Check", "Проверять видимость цели", yPos, "VisibleCheck")
yPos = yPos + 50
CreateToggle("Team Check", "Не атаковать игроков своей команды", yPos, "TeamCheck")

-- ==================== ПОЛЗУНОК FOV ====================
local FovFrame = Instance.new("Frame")
FovFrame.Size = UDim2.new(0.95, 0, 0, 45)
FovFrame.Position = UDim2.new(0.025, 0, 0, yPos + 5)
FovFrame.BackgroundColor3 = Colors.Darker
FovFrame.BackgroundTransparency = 0.3
FovFrame.BorderSizePixel = 1
FovFrame.BorderColor3 = Color3.fromRGB(40, 40, 45)
FovFrame.Parent = MainFrame

local FovLabel = Instance.new("TextLabel")
FovLabel.Size = UDim2.new(0.4, 0, 0.5, 0)
FovLabel.Position = UDim2.new(0, 10, 0, 2)
FovLabel.BackgroundTransparency = 1
FovLabel.Text = "FOV: 150"
FovLabel.TextColor3 = Colors.White
FovLabel.TextSize = 15
FovLabel.TextXAlignment = Enum.TextXAlignment.Left
FovLabel.Font = Enum.Font.GothamBold
FovLabel.Parent = FovFrame

local FovDesc = Instance.new("TextLabel")
FovDesc.Size = UDim2.new(0.8, 0, 0.4, 0)
FovDesc.Position = UDim2.new(0, 10, 0.5, 0)
FovDesc.BackgroundTransparency = 1
FovDesc.Text = "Радиус поиска цели"
FovDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
FovDesc.TextSize = 11
FovDesc.TextXAlignment = Enum.TextXAlignment.Left
FovDesc.Font = Enum.Font.Gotham
FovDesc.Parent = FovFrame

local FovSlider = Instance.new("TextButton")
FovSlider.Size = UDim2.new(0.35, 0, 0, 20)
FovSlider.Position = UDim2.new(0.55, 0, 0, 12)
FovSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
FovSlider.BorderSizePixel = 0
FovSlider.Text = ""
FovSlider.Parent = FovFrame

local FovFill = Instance.new("Frame")
FovFill.Size = UDim2.new(0.5, 0, 1, 0)
FovFill.BackgroundColor3 = Colors.Green
FovFill.BorderSizePixel = 0
FovFill.Parent = FovSlider

local FovValue = Instance.new("TextLabel")
FovValue.Size = UDim2.new(0.2, 0, 1, 0)
FovValue.Position = UDim2.new(0.92, 0, 0, 0)
FovValue.BackgroundTransparency = 1
FovValue.Text = "150"
FovValue.TextColor3 = Colors.Green
FovValue.TextSize = 14
FovValue.Font = Enum.Font.GothamBold
FovValue.Parent = FovFrame

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
        FovValue.Text = tostring(Settings.AimFov)
    end
end)

-- ==================== ГОРЯЧИЕ КЛАВИШИ ====================
local HotkeyFrame = Instance.new("Frame")
HotkeyFrame.Size = UDim2.new(0.95, 0, 0, 40)
HotkeyFrame.Position = UDim2.new(0.025, 0, 0, yPos + 55)
HotkeyFrame.BackgroundColor3 = Colors.Darker
HotkeyFrame.BackgroundTransparency = 0.3
HotkeyFrame.BorderSizePixel = 1
HotkeyFrame.BorderColor3 = Color3.fromRGB(40, 40, 45)
HotkeyFrame.Parent = MainFrame

local HotkeyLabel = Instance.new("TextLabel")
HotkeyLabel.Size = UDim2.new(1, 0, 1, 0)
HotkeyLabel.Position = UDim2.new(0, 10, 0, 0)
HotkeyLabel.BackgroundTransparency = 1
HotkeyLabel.Text = "Горячие клавиши: [F1] Aimbot | [F2] Fly | [F3] Noclip"
HotkeyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
HotkeyLabel.TextSize = 13
HotkeyLabel.TextXAlignment = Enum.TextXAlignment.Left
HotkeyLabel.Font = Enum.Font.Gotham
HotkeyLabel.Parent = HotkeyFrame

-- ==================== FOV КРУГ ====================
local FovCircle = Instance.new("Frame")
FovCircle.Size = UDim2.new(0, 300, 0, 300)
FovCircle.Position = UDim2.new(0.5, -150, 0.5, -150)
FovCircle.BackgroundColor3 = Colors.Green
FovCircle.BackgroundTransparency = 0.85
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
local FlyActive = false
local BodyVelocity = nil
local BodyGyro = nil

local function StartFly()
    if FlyActive then return end
    FlyActive = true
    
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
        if not FlyActive or not BodyVelocity then
            return
        end
        
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
    FlyActive = false
    
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
local NoclipActive = false
local NoclipConnections = {}

local function StartNoclip()
    if NoclipActive then return end
    NoclipActive = true
    
    local function noclipLoop()
        if not NoclipActive then return end
        
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
    NoclipActive = false
    
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
RunService.Heartbeat:Connect(function()
    -- Aimbot
    if Settings.AimbotEnabled then
        local target = GetClosestPlayer()
        if target then
            local character = target.Character
            if character then
                local head = character:FindFirstChild(Settings.AimPart) or character:FindFirstChild("Head")
                if head then
                    if not Settings.SilentAim then
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
    
    -- Fly
    if Settings.FlyEnabled ~= FlyActive then
        if Settings.FlyEnabled then
            StartFly()
        else
            StopFly()
        end
    end
    
    -- Noclip
    if Settings.NoclipEnabled ~= NoclipActive then
        if Settings.NoclipEnabled then
            StartNoclip()
        else
            StopNoclip()
        end
    end
end)

-- ==================== ГОРЯЧИЕ КЛАВИШИ ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F1 then
        Settings.AimbotEnabled = not Settings.AimbotEnabled
        -- Обновляем кнопку в меню (придется найти)
    end
    if input.KeyCode == Enum.KeyCode.F2 then
        Settings.FlyEnabled = not Settings.FlyEnabled
    end
    if input.KeyCode == Enum.KeyCode.F3 then
        Settings.NoclipEnabled = not Settings.NoclipEnabled
    end
end)

-- ==================== ЗАПУСК ====================
print("RYZEN X v1.3 Загружен!")
print("[F1] - Aimbot")
print("[F2] - Fly")
print("[F3] - Noclip")
