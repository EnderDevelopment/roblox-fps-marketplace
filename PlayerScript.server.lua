-- PlayerScript.server.lua

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    local camera = workspace.CurrentCamera

    -- Basic movement controls
    local moveDirection = Vector3.new(0, 0, 0)
    local moveSpeed = 16

    local function onInputChanged(input, gameProcessed)
        if gameProcessed then return end

        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then
                moveDirection = moveDirection + Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.S then
                moveDirection = moveDirection + Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.A then
                moveDirection = moveDirection + Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then
                moveDirection = moveDirection + Vector3.new(1, 0, 0)
            end
        end
    end

    local function onInputEnded(input, gameProcessed)
        if gameProcessed then return end

        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then
                moveDirection = moveDirection - Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.S then
                moveDirection = moveDirection - Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.A then
                moveDirection = moveDirection - Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then
                moveDirection = moveDirection - Vector3.new(1, 0, 0)
            end
        end
    end

    UserInputService.InputChanged:Connect(onInputChanged)
    UserInputService.InputEnded:Connect(onInputEnded)

    -- Update player position
    game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
        if moveDirection.Magnitude > 0 then
            humanoid:Move(moveDirection * moveSpeed, false)
        end
    end)

    -- Basic shooting
    local function onMouseClick()
        local ray = camera:ScreenPointToRay(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
        local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, {character})

        if hit then
            -- Handle hit logic here
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            onMouseClick()
        end
    end)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(onCharacterAdded)
end)
