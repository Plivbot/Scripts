Size = 6 -- Setting higher than 8 or so will screw with the server hit detection and prevent your guns from damaging people. 8 is still easy to "rage" with. I recommend 2-5 if you want to look legit.
Transparency = 1 -- Leave it at 0.5 if you want the torsos/left legs to be visible. Set to 1 to make them invisible.

game:GetService("RunService").Stepped:Connect(function()
for i,v in next, workspace.Players:GetDescendants() do
if v:FindFirstChild("Left Arm") and not v:FindFirstChildWhichIsA("MeshPart") then
sethiddenproperty(v["Left Arm"], "Massless", true)
v["Left Arm"].CanCollide = false
v["Left Arm"].Transparency = Transparency
if v["Left Arm"].Size ~= Vector3.new(Size, Size, Size) and v["Left Arm"].Mesh.Scale ~= Vector3.new(Size, Size, Size) then
v["Left Arm"].Size = Vector3.new(Size, Size, Size)
v["Left Arm"].Mesh.Scale = Vector3.new(Size, Size, Size)
end
if v["Left Arm"].Parent.Parent.Name == "Bright blue" then
v["Left Arm"].BrickColor = BrickColor.new("Bright blue")
end
if v["Left Arm"].Parent.Parent.Name == "Bright orange" then
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
