if getgenv().FoodZookaHooked then return end
getgenv().FoodZookaHooked = true

getgenv().FoodZookaSettings = {
    ReloadTime = 0.2,
    Force = 20,
    BulletSpeed = 100,
    Damage = 10
}

local mt = getrawmetatable(game)

if setreadonly then
    setreadonly(mt, false)
end

local old
old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    local cfg = getgenv().FoodZookaSettings

    if method == "FireServer"
        and typeof(self) == "Instance"
        and self.Name == "SendProjectile"
        and cfg then

        local data = args[1]

        if typeof(data) == "table" and typeof(data[4]) == "table" then
            local s = data[4]

            s.ReloadTime = cfg.ReloadTime
            s.Force = cfg.Force
            s.BulletSpeed = cfg.BulletSpeed
            s.Damage = cfg.Damage
        end
    end

    return old(self, unpack(args))
end)

if setreadonly then
    setreadonly(mt, true)
end
