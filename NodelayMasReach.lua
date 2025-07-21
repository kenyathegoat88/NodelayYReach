if game.PlaceId == 1597763879 or game.PlaceId == 335760407 then
    -- 🛡️ BYPASS ANTICHEAT AVANZADO
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local spoof = {}
    local genv = getgenv()
    genv.Data = spoof

    -- Spoof básico
    spoof.WalkSpeed = 16
    spoof.JumpPower = 50
    spoof.Health = 100
    spoof.Humanoid = char:FindFirstChildOfClass("Humanoid")

    -- Neutraliza conexiones sospechosas
    for _, v in pairs(getconnections(game.DescendantAdded)) do
        pcall(function()
            if tostring(v.Function):lower():find("kick") then
                v:Disable()
            end
        end)
    end

    -- Neutraliza detecciones comunes
    if hookmetamethod then
        hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "kick" then
                return
            end
            return self(...);
        end)
    end

    -- GUI
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "KTC_NoDelayGUI"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 320, 0, 200)
    frame.Position = UDim2.new(0.35, 0, 0.3, 0)
    frame.BackgroundTransparency = 1
    frame.Active = true
    frame.Draggable = true

    local bg = Instance.new("ImageLabel", frame)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.Image = "rbxassetid://1396281723321290882" -- Fondo
    bg.BackgroundTransparency = 0
    bg.ScaleType = Enum.ScaleType.Crop

    local close = Instance.new("TextButton", frame)
    close.Text = "✖"
    close.Size = UDim2.new(0, 30, 0, 30)
    close.Position = UDim2.new(1, -35, 0, 5)
    close.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.TextScaled = true
    close.Font = Enum.Font.GothamBold
    close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    local label = Instance.new("TextLabel", frame)
    label.Text = "⚡ NO DELAY + REACH ⚡"
    label.Size = UDim2.new(1, 0, 0, 50)
    label.Position = UDim2.new(0, 0, 0.75, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0, 255, 0)
    label.Font = Enum.Font.GothamBlack
    label.TextScaled = true

    -- FUNCIÓN NO DELAY BALÓN
    local function enhanceBall()
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Name:lower():find("ball") then
                pcall(function()
                    part.Velocity = part.Velocity * 1.1
                    part.AssemblyLinearVelocity = part.AssemblyLinearVelocity * 1.1
                    part.AssemblyAngularVelocity = part.AssemblyAngularVelocity * 1.05
                    part.CustomPhysicalProperties = PhysicalProperties.new(0.1, 0, 0.9)
                    part:SetNetworkOwner(player)
                end)
            end
        end
    end

    -- FUNCIÓN REACH
    local function applyReach()
        local limbs = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }
        for _, limb in pairs(limbs) do
            local part = char:FindFirstChild(limb)
            if part and part:IsA("BasePart") then
                local selection = part:FindFirstChild("SelectionBox") or Instance.new("SelectionBox", part)
                selection.Adornee = part
                selection.Color3 = Color3.fromRGB(0, 255, 255)
                selection.LineThickness = 0.05
                part.Size = Vector3.new(6, 6, 6)
                part.Massless = true
                part.CanCollide = false
                part.Transparency = 0.5
            end
        end
    end

    -- AUTO-APLICAR CADA FRAME
    game:GetService("RunService").Heartbeat:Connect(function()
        enhanceBall()
        applyReach()
    end)
end
