Size = 4
Transparency = 1

game:GetService("RunService").Stepped:Connect(function()
for i,v in next, workspace.Players:GetDescendants() do
if v:FindFirstChild("Torso") and not v:FindFirstChildWhichIsA("MeshPart") then
sethiddenproperty(v["Torso"], "Massless", true)
v["Torso"].CanCollide = false
v["Torso"].Transparency = Transparency
if v["Torso"].Size ~= Vector3.new(Size, Size, Size) and v["Torso"].Mesh.Scale ~= Vector3.new(Size, Size, Size) then
v["Torso"].Size = Vector3.new(Size, Size, Size)
end
if v["Torso"].Parent.Parent.Name == "Bright blue" then
v["Torso"].BrickColor = BrickColor.new("Bright blue")
end
if v["Torso"].Parent.Parent.Name == "Bright orange" then
v["Left Arm"].BrickColor = BrickColor.new("Bright orange")
end
end
end
end)

while wait() do
for i,v in next, workspace.Ignore.DeadBody:GetChildren() do
v:Destroy()
end
end