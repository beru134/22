getgenv().AutoTap = false;
getgenv().AutoBuyEgg = false;


function doTap()
  spawn(function()
    while AutoTap == true do
         workspace.Events.AddClick:FireServer()
         wait()
    end 
  end)
end


function AutoBuyegg(eggtype,egglimit)
   spawn(function()
        local iteration = 0;    
        while AutoBuyEgg == true do
        local args = { [1] = "Basic",[2] = "Single"}
           game:GetService("ReplicatedStorage").RemoteEvents.EggOpened:InvokeServer(unpack(args))
           wait()
          iteration = iteration +1
        end
   end)
end
AutoBuyegg('basic')




function teleportTO(placeCFrame)
   local plyr = game.Players.LocalPlayer;
   if plyr.Character then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame;
    end 
end
teleportTO(game:GetService("Workspace").Ulanchor.portalframe.CFrame) 
   

 












