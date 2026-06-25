getgenv().oth.hook = oth.hook or hookfunction
getgenv().oth.unhook =  oth.unhook or function(x) if isfunctionhooked(x) then restorefunction(x) end 

local KeyHandler = require(game:GetService("ReplicatedStorage").Assets.Modules.KeyHandler)()
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
        ["Charge"] = "Charge",
        ["FallDamage"] = "FallDamage",
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

local function GetRemote(remoteName: string)
    local CurrentWorld = require(game:GetService("ReplicatedStorage").Info.RealmInfo).CurrentWorld
    local password = remotes[CurrentWorld][remoteName]
    assert(password, `{remoteName} is not valid`)

    local key = (CurrentWorld == "Gaia" and "plum") or (CurrentWorld == "Khei" and "apricot")
    assert(key, `Invalid Key, check PlaceId/Realm`)

    if CurrentWorld == "Khei" then
        oth.unhook(getrenv().getfenv)
        oth.hook(getrenv().getfenv, function(level)
            return getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.ClientManage)
        end)
    end
    local remote = (CurrentWorld == "Gaia" and KeyHandler[1](password, key)) or (CurrentWorld == "Khei" and KeyHandler.getKey(password, key))
    oth.unhook(getrenv().getfenv)
    assert(remote, `Failed to grab {remoteName}`)
    return remote
end
    
return {
    GetRemote = GetRemote
}
