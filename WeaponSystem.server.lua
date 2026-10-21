-- WeaponSystem.server.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local weapons = {
    {
        name = "Pistol",
        damage = 10,
        fireRate = 0.5,
        ammo = 12,
        maxAmmo = 12,
        range = 100
    },
    {
        name = "Rifle",
        damage = 15,
        fireRate = 0.2,
        ammo = 30,
        maxAmmo = 30,
        range = 200
    }
}

local function createWeapon(player, weaponData)
    local weapon = Instance.new("Model")
    weapon.Name = weaponData.name

    -- Create weapon parts and attach them to the player
    -- This is a simplified version; you'll need to create actual weapon models

    local weaponInfo = Instance.new("Folder", weapon)
    weaponInfo.Name = "WeaponInfo"

    local damage = Instance.new("IntValue", weaponInfo)
    damage.Name = "Damage"
    damage.Value = weaponData.damage

    local fireRate = Instance.new("NumberValue", weaponInfo)
    fireRate.Name = "FireRate"
    fireRate.Value = weaponData.fireRate

    local ammo = Instance.new("IntValue", weaponInfo)
    ammo.Name = "Ammo"
    ammo.Value = weaponData.ammo

    local maxAmmo = Instance.new("IntValue", weaponInfo)
    maxAmmo.Name = "MaxAmmo"
    maxAmmo.Value = weaponData.maxAmmo

    local range = Instance.new("NumberValue", weaponInfo)
    range.Name = "Range"
    range.Value = weaponData.range

    -- Attach weapon to player
    weapon.Parent = player.Character

    return weapon
end

local function giveDefaultWeapon(player)
    local defaultWeapon = weapons[1] -- Pistol
    createWeapon(player, defaultWeapon)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        giveDefaultWeapon(player)
    end)
end)
