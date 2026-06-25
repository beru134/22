if not isfunctionhooked(getrenv().getfenv) then
    local old
    old = hookfunction(
        getrenv().getfenv,
        newcclosure(function(level)
            return {}
    end))
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KeyHandler = require(ReplicatedStorage.Assets.Modules.KeyHandler)()

if isfunctionhooked(getrenv().getfenv) then
    restorefunction(getrenv().getfenv)
end

local remotes = {
    Gaia = {
        ["PostDialogue"] = 404.5041892976703, -- no special run conditions
        ["SetManaChargeState"] = 27.81839265298673, -- args: {math.random(1, 10), math.random()}
        ["ApplyFallDamage"] = 90.32503962905011, -- args: {math.random(), fallDamage}, {} | where fallDamage is a number 0.0 - 2
        ["Tango"] = 30195.341357415226, -- args: {1 or 2 depending on sprint state, math.random()}, {} | ban remote but also used for sprinting funny enough.
        ["Dodges"] = 398.00010021400533, -- args: {1, math.random(), dodgeType} | where dodgeType is "normal" or "dragon" or "shadow"
        ["SetCurrentArea"] = "SetCurrentArea", -- args: areaName | where areaName is the string of the area
        ["PlaceTool"] = "PlaceTool", -- args: tool | where tool is the actual tool
        ["PlaceMoney"] = "PlaceMoney", -- args: silverAmount | where silverAmount is a number 0 - 10000
        ["Theodora"] = "Theodora", -- ban remote
        ["InvisIngredient"] = "InvisIngredient", -- onclientevent remote
        ["HideOre"] = "HideOre", -- onclientevent remote
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
        ["Drop"] = "Drop",
    },
}

local function getRemoteFn(remoteName: string): (RemoteEvent?) | (RemoteFunction?)
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

getgenv().getRemote = getRemoteFn
