-- Shop System for FPS Game

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Remote Events
local ShopEvent = Instance.new("RemoteEvent")
ShopEvent.Name = "ShopEvent"
ShopEvent.Parent = ReplicatedStorage

-- Shop Items
local shopItems = {
    {
        Name = "Pistol",
        Price = 100,
        Model = "rbxassetid://123456789",
        Type = "Weapon"
    },
    {
        Name = "Health Pack",
        Price = 50,
        Model = "rbxassetid://987654321",
        Type = "Consumable"
    }
}

-- Function to handle item purchase
local function purchaseItem(player, itemIndex)
    local item = shopItems[itemIndex]
    if not item then return false, "Item not found" end

    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return false, "Leaderstats not found" end

    local rbxBalance = leaderstats:FindFirstChild("RBX")
    if not rbxBalance then return false, "RBX balance not found" end

    if rbxBalance.Value < item.Price then
        return false, "Not enough RBX"
    end

    -- Deduct RBX
    rbxBalance.Value = rbxBalance.Value - item.Price

    -- Grant item to player
    if item.Type == "Weapon" then
        -- Weapon granting logic
    elseif item.Type == "Consumable" then
        -- Consumable granting logic
    end

    return true, "Purchase successful"
end

-- Event handler for shop purchases
ShopEvent.OnServerEvent:Connect(function(player, action, itemIndex)
    if action == "Purchase" then
        local success, message = purchaseItem(player, itemIndex)
        ShopEvent:FireClient(player, "PurchaseResult", success, message)
    end
end)

-- Function to initialize player's shop data
local function onPlayerAdded(player)
    -- Initialize player's RBX balance if not already present
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local rbxBalance = Instance.new("IntValue")
    rbxBalance.Name = "RBX"
    rbxBalance.Value = 1000 -- Starting RBX amount
    rbxBalance.Parent = leaderstats
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Function to send shop items to client
local function sendShopItems(player)
    ShopEvent:FireClient(player, "UpdateShop", shopItems)
end

-- Connect to player added event to send shop items
Players.PlayerAdded:Connect(sendShopItems)