-- Create ScreenGui and UI Elements
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local UICornerFrame = Instance.new("UICorner")
local UICornerButton = Instance.new("UICorner")

-- Parent UI to PlayerGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Frame Properties (Main UI)
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Dark modern background
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.35, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 220, 0, 170)

-- Add Rounded Corners to Frame
UICornerFrame.CornerRadius = UDim.new(0, 12)
UICornerFrame.Parent = Frame

-- Title Text Label
TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
TextLabel.Size = UDim2.new(0, 180, 0, 40)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "Touch Fling By hmdaannn"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 18
TextLabel.TextWrapped = true

-- Button Properties
TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60) -- Red (OFF)
TextButton.Position = UDim2.new(0.15, 0, 0.55, 0)
TextButton.Size = UDim2.new(0, 140, 0, 45)
TextButton.Font = Enum.Font.GothamBold
TextButton.Text = "OFF"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 22
TextButton.BorderSizePixel = 0

-- Add Rounded Corners to Button
UICornerButton.CornerRadius = UDim.new(0, 10)
UICornerButton.Parent = TextButton

-- UI Draggable
Frame.Active = true
Frame.Draggable = true

-- Touch Fling Script
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local hiddenFling = false
local debounce = false -- Prevents spam clicks
local lp = Players.LocalPlayer

-- Ensure Decal for Detection
if not ReplicatedStorage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
    local detection = Instance.new("Decal")
    detection.Name = "juisdfj0i32i0eidsuf0iok"
    detection.Parent = ReplicatedStorage
end

-- Smooth Button Toggle Animation
local function animateButtonColor(button, targetColor)
    local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = targetColor})
    tween:Play()
end

-- Fling Function
local function fling()
    local character, hrp, velocity, moveAmount = nil, nil, nil, 0.1

    while true do
        RunService.Heartbeat:Wait()

        if hiddenFling then
            while hiddenFling and not (character and character.Parent and hrp and hrp.Parent) do
                RunService.Heartbeat:Wait()
                character = lp.Character
                hrp = character and character:FindFirstChild("HumanoidRootPart")
            end

            if hiddenFling then
                velocity = hrp.Velocity
                hrp.Velocity = velocity * 10000 + Vector3.new(0, 10000, 0)
                RunService.RenderStepped:Wait()

                if character and character.Parent and hrp and hrp.Parent then
                    hrp.Velocity = velocity
                end

                RunService.Stepped:Wait()

                if character and character.Parent and hrp and hrp.Parent then
                    hrp.Velocity = velocity + Vector3.new(0, moveAmount, 0)
                    moveAmount = moveAmount * -1
                end
            end
        end
    end
end

-- Button Click to Toggle Fling
TextButton.MouseButton1Click:Connect(function()
    if debounce then return end
    debounce = true

    hiddenFling = not hiddenFling

    if hiddenFling then
        TextButton.Text = "ON"
        animateButtonColor(TextButton, Color3.fromRGB(50, 205, 50)) -- Green when ON
    else
        TextButton.Text = "OFF"
        animateButtonColor(TextButton, Color3.fromRGB(220, 20, 60)) -- Red when OFF
    end

    task.wait(0.3)
    debounce = false
end)

-- Run the fling function
fling()
