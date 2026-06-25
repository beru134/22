if not getgenv().httpHook then
    getgenv().httpHook = true
    local oldHook;
    oldHook = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if key == "HttpGet" then
            error("Http requests are not enabled", 2)
        end

        return oldHook(self, key)
    end))
end

local old
    old = hookfunction(getrenv().getfenv, newcclosure(function(level)
        return {}
    end))

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KeyHandler = require(ReplicatedStorage.Assets.Modules.KeyHandler)()

if isfunctionhooked(getrenv().getfenv) then
    restorefunction(getrenv().getfenv)
end

local remotes = {
    Gaia = {
        ["PostDialogue"] = 404.5041892976703,
        ["SetManaChargeState"] = 27.81839265298673,
        ["ApplyFallDamage"] = 90.32503962905011,
        ["Tango"] = 30195.341357415226,
        ["Dodges"] = 398.00010021400533,
        ["SetCurrentArea"] = "SetCurrentArea",
        ["PlaceTool"] = "PlaceTool",
        ["PlaceMoney"] = "PlaceMoney",
        ["Theodora"] = "Theodora",
        ["InvisIngredient"] = "InvisIngredient",
        ["HideOre"] = "HideOre",
    },
    Khei = {
        ["SendDialogue"] = "SendDialogue",
        ["Dolorosa"] = "Dolorosa",
        ["HideIngredient"] = "HideIngredient",
        ["HideOre"] = "HideOre",
        ["AddClimbing"] = "AddClimbing",
        ["ClientFall"] = "ClientFall",
        ["ClientSprint"] = "ClientSprint",
        ["MoneyBag"] = "MoneyBag",
        ["ToolBag"] = "ToolBag",
        ["UpdateArea"] = "UpdateArea",
        ["Drop"] = "Drop"
    }  
}

local function getRemote(remoteName: string): RemoteEvent? | RemoteFunction?
    local universe = (game.PlaceId == 3541987450 and "Khei") or "Gaia"
    local remotePassword = remotes[universe][remoteName]
    if not remotePassword then
        return warn(`{remoteName} is not a valid remote`)
    end

    if not isfunctionhooked(getrenv().getfenv) then
        local old
        old = hookfunction(getrenv().getfenv, newcclosure(function(level)
            return {}
        end))
    end

    local remote
    if universe == "Khei" then
        remote = KeyHandler.getKey(remotePassword, "apricot")
    elseif universe == "Gaia" then
        remote = KeyHandler[1](remotePassword, "plum")
    end

    if isfunctionhooked(getrenv().getfenv) then
        restorefunction(getrenv().getfenv)
    end

    return remote
end

print(getRemote("SendDialogue"))
