local Camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function GetPartCorners(Part)
    local Size = Part.Size * Vector3.new(1, 1.5)
    return {
        TR = (Part.CFrame * CFrame.new(-Size.X, -Size.Y, 0)).Position,
        BR = (Part.CFrame * CFrame.new(-Size.X, Size.Y, 0)).Position,
        TL = (Part.CFrame * CFrame.new(Size.X, -Size.Y, 0)).Position,
        BL = (Part.CFrame * CFrame.new(Size.X, Size.Y, 0)).Position
    }
end

local function ApplyModel(Model)
    local box = Drawing.new('Quad')
    local currentParent = Model.Parent

    spawn(function()
        while Model.Parent == currentParent do
            local PartCorners = GetPartCorners(Model.Torso)
            local Distance = (Camera.CFrame.Position - Model.Torso.Position).Magnitude
            local VectorTR, OnScreenTR = Camera:WorldToScreenPoint(PartCorners.TR)
            local VectorBR, OnScreenBR = Camera:WorldToScreenPoint(PartCorners.BR)
            local VectorTL, OnScreenTL = Camera:WorldToScreenPoint(PartCorners.TL)
            local VectorBL, OnScreenBL = Camera:WorldToScreenPoint(PartCorners.BL)

            if (OnScreenBL or OnScreenTL or OnScreenBR or OnScreenTR) and Model.Parent.Name ~=
                game:GetService("Players").LocalPlayer.Team.Name then
                box.Visible = true
                box.PointA = Vector2.new(VectorTR.x, VectorTR.y + 36)
                box.PointB = Vector2.new(VectorTL.x, VectorTL.y + 36)
                box.PointC = Vector2.new(VectorBL.x, VectorBL.y + 36)
                box.PointD = Vector2.new(VectorBR.x, VectorBR.y + 36)
                box.Color = Color3.fromRGB(255, 255, 255)
                box.Thickness = math.clamp(3 - (Distance / 100), 0, 3)
                box.Transparency = 1
            else
                box.Visible = false
            end
            RunService.RenderStepped:Wait()
        end
        box:Remove()
    end)
end

for _, Player in next, game:GetService("Workspace").Players["Bright orange"]:GetChildren() do
    if tostring(Player.Parent) ~= tostring(game:GetService("Players").LocalPlayer.TeamColor) then
        ApplyModel(Player)
    end
end

for _, Player in next, game:GetService("Workspace").Players["Bright blue"]:GetChildren() do
    if tostring(Player.Parent) ~= tostring(game:GetService("Players").LocalPlayer.TeamColor) then
        ApplyModel(Player)
    end
end

game:GetService("Workspace").Players["Bright orange"].ChildAdded:Connect(function(Player)
    if tostring(Player.Parent) ~= tostring(game:GetService("Players").LocalPlayer.TeamColor) then
        delay(0.5, function()
            ApplyModel(Player)
        end)
    end
end)

game:GetService("Workspace").Players["Bright blue"].ChildAdded:Connect(function(Player)
    if tostring(Player.Parent) ~= tostring(game:GetService("Players").LocalPlayer.TeamColor) then
        delay(0.5, function()
            ApplyModel(Player)
        end)
    end
end)

