
    local players = game:GetService("Players")
    local run_service = game:GetService("RunService")

    local local_player = players.LocalPlayer
    local get_children = game.GetChildren
    local find_first_child = game.FindFirstChild
    local new_drawing = Drawing.new

    local camera = workspace.CurrentCamera or game:GetService("Workspace").CurrentCamera
    local rootPart = "Head"
    local objects_folder: Folder = game:GetService("Workspace").Players
    local coreGui = game:GetService("CoreGui")

    local object_ID = {}
    local eps = {}

    local function Setup()
        for _, team in pairs(objects_folder:GetChildren()) do
            for _, object in pairs(get_children(team)) do
                local id = object:GetDebugId()
                if not table.find(object_ID, id) then
                    table.insert(object_ID, id)
                    eps[id] = {
                        esp_object = object,
                        highlight = Instance.new("Highlight", coreGui),
                    }
                    eps[id].highlight.Adornee = eps[id].esp_object
                    eps[id].highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    eps[id].highlight.Enabled = true
                    eps[id].highlight.FillTransparency = true
                end
            end
        end
    end

    Setup()
    shared.max_distance = math.huge
    run_service.RenderStepped:Connect(function()
        Setup()
        for _, value in pairs(eps) do
            if
                find_first_child(value.esp_object, rootPart)
                and value.esp_object.Parent.Name ~= local_player.TeamColor.Name
            then
                local vec3_position = find_first_child(value.esp_object, rootPart).Position
                local screen_position, on_screen = camera:WorldToScreenPoint(vec3_position)
                local distant_from_character = local_player:DistanceFromCharacter(vec3_position)
                if on_screen and math.round(distant_from_character) <= shared.max_distance then
                    value.highlight.FillColor =
                        Color3.fromHSV(math.clamp(distant_from_character / 5, 0, 125) / 255, 0.75, 1)
                    value.highlight.FillTransparency = math.clamp((500 - distant_from_character) / 200, 0.2, 1)

                    value.highlight.Enabled = true
                else
                    value.highlight.Enabled = false
                end
            else
                value.highlight.Enabled = false
            end
        end
    end)

    objects_folder.DescendantAdded:Connect(function()
        Setup()
    end)
    objects_folder.DescendantRemoving:Connect(function(child)
        local id = child:GetDebugId()
        if table.find(object_ID, id) then
            eps[id].highlight:Destroy()
            eps[id].esp_object = nil
            eps[id] = nil
        end
    end)
