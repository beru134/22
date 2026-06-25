 
        local getKey;
        local isGaia = game.PlaceId == 5208655184;
        getgenv().remotes = {};
        local disableenvprotection = disableenvprotection or function() end;
        local enableenvprotection = enableenvprotection or function() end;
        local requests = game:GetService('ReplicatedStorage'):WaitForChild('Requests');
        local myRemotes;
        local FindFirstChild = game.FindFirstChild
        local LocalPlayer = game:GetService'Players'.LocalPlayer
        local function onCharacterAdded(character)
            if(not character) then return end;
            local myNewRemotes = character:WaitForChild('CharacterHandler') and character.CharacterHandler:WaitForChild('Remotes');
            if(not myNewRemotes) then return end;
            myRemotes = myNewRemotes;
        end;
      
        onCharacterAdded(LocalPlayer.Character);
        LocalPlayer.CharacterAdded:Connect(onCharacterAdded);
        local TANGO_PASSWORD = 30195.341357415226
        local POST_DIALOGUE_PASSWORD = 404.5041892976703
        local DODGE_PASSWORD = 398.00010021400533
        local APPLY_FALL_DAMAGE_PASSWORD = 90.32503962905011
        local SET_MANA_CHARGE_STATE_PASSWORD = 27.81839265298673
        local cachedRemotes = {};
        getgenv().tango;
	    getgenv().fallDamage;
	    getgenv().dodge;
	    getgenv().manaCharge;
	    getgenv().dialog;
	    getgenv().dolorosa;
	    getgenv().changeArea;
        local function grabKeyHandler()
            if(isGaia) then
                for i, v in next, getgc() do
                    if(typeof(v) == 'function' and islclosure(v) and table.find(getconstants(v), 'plum')) then
                        local keyHandler = getupvalue(v, 1);
                        if(typeof(keyHandler) == 'table' and typeof(rawget(keyHandler, 1)) == 'function') then
                            getKey = rawget(keyHandler, 1);
                            break
                        end;
                    end;
                end;
            else
                for i, v in next, getgc(true) do
                    if(typeof(v) == 'table' and rawget(v, 'getKey')) then
                        getKey = rawget(v, 'getKey');
                        break;
                    end;
                end;
            end;
        end;

            local function setRemote(name, remote, isPcall)
				if (isPcall) then remote = isPcall; end;
				getgenv().remotes[name] = remote;

				if(name == 'tango') then
					tango = remote;
				elseif(name == 'fallDamage') then
					fallDamage = remote;
				elseif(name == 'dodge') then
					dodge = remote;
				elseif(name == 'manaCharge') then
					manaCharge = remote;
				elseif(name == 'dialog') then
					dialog = remote;
				elseif(name == 'dolorosa') then
					dolorosa = remote;
				elseif(name == 'changeArea') then
					changeArea = remote;
				end;
			end;

			grabKeyHandler();
			if(not getKey) then
				warn('Didn\'t got keyhandler retrying with loop...');
				repeat
					grabKeyHandler();
					task.wait(2);
				until getKey;
			end;
         local oldNameCall;
         oldNameCall = hookmetamethod(game, '__namecall', function(self, ...)
                    SX_VM_CNONE();
                    if(not remotes.loadKeys or checkcaller() or not string.find(debug.traceback(), 'ControlModule')) then
                        return oldNameCall(self, ...);
                    end;
        
                    -- local args = {...};
        
                    -- if(string.find(debug.traceback(), 'KeyHandler')) then
                        -- warn('kay handler call __namecall', method);
                    -- end;
        
                    if(isGaia) then
                        local oldGetKey = getKey;
        
                        local function getKey(name, pwd)
                            local cachedRemote = cachedRemotes[name];
        
                            if(cachedRemote and cachedRemote.Parent and (cachedRemote.Parent == requests or cachedRemote.Parent == myRemotes)) then
                                return cachedRemote;
                            end;
        
                            cachedRemotes[name] = coroutine.wrap(oldGetKey)(name, pwd);
                            return cachedRemotes[name];
                        end;
        
                        --print(debug.traceback());
                        if(debugMode) then
                            local getRemotes = (function()
                                tango = getKey(TANGO_PASSWORD, 'plum');
        
                                setRemote('tango', tango);
                                setRemote('fallDamage',getKey(APPLY_FALL_DAMAGE_PASSWORD, 'plum'));
                                setRemote('dodge', getKey(DODGE_PASSWORD, 'plum'));
                                setRemote('manaCharge', getKey(SET_MANA_CHARGE_STATE_PASSWORD, 'plum'));
                                setRemote('dialog', getKey(POST_DIALOGUE_PASSWORD, 'plum'));
                                setRemote('changeArea', getKey('SetCurrentArea', 'plum'));
                            end);
        
                            coroutine.wrap(getRemotes)();
                        else
                            tango = getKey(TANGO_PASSWORD, 'plum');
        
                            setRemote('tango', tango);
                            setRemote('fallDamage',getKey(APPLY_FALL_DAMAGE_PASSWORD, 'plum'));
                            setRemote('dodge', getKey(DODGE_PASSWORD, 'plum'));
                            setRemote('manaCharge', getKey(SET_MANA_CHARGE_STATE_PASSWORD, 'plum'));
                            setRemote('dialog', getKey(POST_DIALOGUE_PASSWORD, 'plum'));
                            setRemote('changeArea', getKey('SetCurrentArea', 'plum'));
                        end;
                    else
                        local character = LocalPlayer.Character
                        local characterHandler = character and FindFirstChild(character, 'CharacterHandler');
                        local remotes = characterHandler and FindFirstChild(characterHandler, 'Remotes');
        
                        disableenvprotection();
        
                        setrawmetatable(false, {__index = function(_, p)
                            if (p == 'Parent') then
                                return true;
                            elseif (p == 'IsDescendantOf') then
                                return true;
                            end;
                        end});
        
                        setRemote('tango', pcall(getKey, 'Drop', 'apricot'));
                        setRemote('fallDamage', pcall(getKey, 'FallDamage', 'apricot'));
                        setRemote('dodge', remotes and FindFirstChild(remotes, 'Dash'));
                        setRemote('manaCharge', pcall(getKey, 'Charge', 'apricot'));
                        setRemote('dialog', pcall(getKey, 'SendDialogue', 'apricot'));
                        setRemote('dolorosa', pcall(getKey, 'Dolorosa', 'apricot'));
        
                        setrawmetatable(false, nil);
        
                        enableenvprotection();
                    end;
        
                    remotes.loadKeys = false;
        
                    task.delay(2, function()
                        remotes.loadKeys = true;
                    end);
        
                    return oldNameCall(self, ...);
                end);
        
