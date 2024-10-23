local opt = {
	prefix = ';',
	tupleSeparator = ',',
	ui = {
		
	},
	keybinds = {
		
	},
}
wait()
for _, descendant in pairs(workspace:GetDescendants()) do
    if descendant:IsA("Script") and descendant.Name == "Kill" then
        local parent = descendant.Parent
        local touchInterest = parent:FindFirstChild("TouchInterest")
        if touchInterest then
            touchInterest:Destroy()
        end
        descendant:Destroy()
    end
end
wait()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character
local mouse = localPlayer:GetMouse()
local camera = workspace.CurrentCamera
local camtype = camera.CameraType
local Commands, Aliases = {}, {}
player, plr, lp = localPlayer, localPlayer, localPlayer, localPlayer

localPlayer.CharacterAdded:Connect(function(c)
	character = c
end)

cmd = {}
cmd.add = function(...)
	local vars = {...}
	local aliases, info, func = vars[1], vars[2], vars[3]
	for i, cmdName in pairs(aliases) do
		if i == 1 then
			Commands[cmdName:lower()] = {func, info}
		else
			Aliases[cmdName:lower()] = {func, info}
		end
	end
end

cmd.run = function(args)
	local caller, arguments = args[1], args; table.remove(args, 1);
	local success, msg = pcall(function()
		if Commands[caller:lower()] then
			Commands[caller:lower()][1](unpack(arguments))
		elseif Aliases[caller:lower()] then
			Aliases[caller:lower()][1](unpack(arguments))
		end
	end)
	if not success then
		lib.messageOut("Admin error", msg)
	end
end

--[[ LIBRARY FUNCTIONS ]]--
lib = {}
lib.wrap = function(f)
	return coroutine.wrap(f)()
end
wrap = lib.wrap

lib.messageOut = function(title, msg)
	StarterGui:SetCore("SendNotification", 
		{
			Title = title,
			Text = msg
		}
	)
end

local wait = function(int)
	if not int then int = 0 end
	local t = tick()
	repeat
		RunService.Heartbeat:Wait(0)
	until (tick() - t) >= int
	return (tick() - t), t
end
spawn(function()
	lib.messageOut("Zacks Easy Admin Loaded!", "Prefix: "..tostring(opt.prefix))
end)

local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
-- Functions --
local cmdp = Players
local cmdlp = cmdp.LocalPlayer

function findplr(args, tbl)
    if tbl == nil then
        local tbl = cmdp:GetPlayers()
        if args == "me" then
            return cmdlp
        elseif args == "random" then 
            return tbl[math.random(1,#tbl)]
        elseif args == "new" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.AccountAge < 30 and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "old" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.AccountAge > 30 and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "bacon" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair") and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "friend" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "notfriend" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if not v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "ally" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.Team == cmdlp.Team and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "enemy" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.Team ~= cmdlp.Team then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "near" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v ~= cmdlp then
                    local math = (v.Character:FindFirstChild("HumanoidRootPart").Position - cmdlp.Character.HumanoidRootPart.Position).magnitude
                    if math < 30 then
                        vAges[#vAges+1] = v
                    end
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "far" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v ~= cmdlp then
                    local math = (v.Character:FindFirstChild("HumanoidRootPart").Position - cmdlp.Character.HumanoidRootPart.Position).magnitude
                    if math > 30 then
                        vAges[#vAges+1] = v
                    end
                end
            end
            return vAges[math.random(1,#vAges)]
        else 
            for _,v in pairs(tbl) do
                if v.Name:lower():find(args:lower()) or v.DisplayName:lower():find(args:lower()) then
                    return v
                end
            end
        end
    else
        for _, plr in pairs(tbl) do
            if plr.UserName:lower():find(args:lower()) or plr.DisplayName:lower():find(args:lower()) then
                return plr
            end
        end
    end
end

lib.lock = function(instance, par)
	locks[instance] = true
	instance.Parent = par or instance.Parent
	instance.Name = "RightGrip"
end
lock = lib.lock
locks = {}
if hookfunction then
	local pseudo = Instance.new("Motor6D")
	_1 = hookfunction(pseudo.IsA, function(...)
		local p, ret = ({...})[1], _1(...)
		if checkcaller() then return ret end
		if locks[p] then
			return false
		end
		return ret
	end)
	_2 = hookfunction(pseudo.FindFirstChildWhichIsA, function(...)
		local p = _2(...)
		if checkcaller() then return p end
		if locks[p] then
			return nil
		end
		return p
	end)
	_3 = hookfunction(pseudo.FindFirstChildOfClass, function(...)
		local p = _3(...)
		if checkcaller() then return p end
		if locks[p] then
			return nil
		end
		return p
	end)
	_4 = hookfunction(pseudo.Destroy, function(...)
		local args = {...}
		if checkcaller() then return _4(...) end
		if locks[args[1]] then return end
		return
	end)
	
	local mt = getrawmetatable(game)
	local _ni = mt.__newindex
	local _nc = mt.__namecall
	local _i = mt.__index
	setreadonly(mt, false)
	
	mt.__index = newcclosure(function(t, i)
		if locks[t] and not checkcaller() then
			return _i(pseudo, i)
		end
		return _i(t, i)
	end)
	mt.__newindex = newcclosure(function(t, i, v)
		if locks[t] and not checkcaller() then
			return _ni(pseudo, i, v)
		end
		return _ni(t, i, v)
	end)
	mt.__namecall = newcclosure(function(t, ...)
		if locks[t] and not checkcaller() then
			return _nc(pseudo, ...)
		end
		return _nc(t, ...)
	end)
end

lib.find = function(t, v)
	for i, e in pairs(t) do
		if i == v or e == v then
			return i
		end
	end
	return nil
end

lib.parseText = function(text, watch)
	local parsed = {}
	if not text then return nil end
	for arg in text:gmatch("[^" .. watch .. "]+") do
		arg = arg:gsub("-", "%%-")
		local pos = text:find(arg)
		arg = arg:gsub("%%", "")
		if pos then
			local find = text:sub(pos - opt.prefix:len(), pos - 1)
			if (find == opt.prefix and watch == opt.prefix) or watch ~= opt.prefix then
				table.insert(parsed, arg)
			end
		else
			table.insert(parsed, nil)
		end
	end
	return parsed
end

lib.parseCommand = function(text)
	wrap(function()
		local commands = lib.parseText(text, opt.prefix)
		for _, parsed in pairs(commands) do
			local args = {}
			for arg in parsed:gmatch("[^ ]+") do
				table.insert(args, arg)
			end
			cmd.run(args)
		end
	end)
end

local connections = {}

lib.connect = function(name, connection)	-- no :(
	connections[name .. tostring(math.random(1000000, 9999999))] = connection
	return connection
end

lib.disconnect = function(name)
	for title, connection in pairs(connections) do
		if title:find(name) == 1 then
			connection:Disconnect()
		end
	end
end

m = math			-- prepare for annoying and unnecessary tool grip math
rad = m.rad
clamp = m.clamp
sin = m.sin
tan = m.tan
cos = m.cos

--[[ PLAYER FUNCTIONS ]]--
argument = {}
argument.getPlayers = function(str)
	local playerNames, players = lib.parseText(str, opt.tupleSeparator), {}
	for _, arg in pairs(playerNames or {"me"}) do
		arg = arg:lower()
		local playerList = Players:GetPlayers()
		if arg == "me" or arg == nil then
			table.insert(players, localPlayer)
			
		elseif arg == "all" then
			for _, plr in pairs(playerList) do
				table.insert(players, plr)
			end
			
		elseif arg == "others" then
			for _, plr in pairs(playerList) do
				if plr ~= localPlayer then
					table.insert(players, plr)
				end
			end
			
		elseif arg == "random" then
			table.insert(players, playerList[math.random(1, #playerList)])
			
		elseif arg:find("%%") == 1 then
			local teamName = arg:sub(2)
			for _, plr in pairs(playerList) do
				if tostring(plr.Team):lower():find(teamName) == 1 then
					table.insert(players, plr)
				end
			end
			
		else
			for _, plr in pairs(playerList) do
				if plr.Name:lower():find(arg) == 1 then
					table.insert(players, plr)
				end
			end
		end
	end
	return players
end

--[ SCRIPT ]--
cmd.add({"script", "ls", "s", "run"}, {"script <source>", "Run the code requested"}, function(source)
	loadstring(source)()
end)

cmd.add({"httpget", "hl", "get"}, {"httpget <url>", "Run the contents of a given URL"}, function(url)
	loadstring(game:HttpGet(url, true))()
end)

--[ UTILITY ]--
cmd.add({"mute"}, {"mute", "Mutes yourself in-game"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local Head = Character:WaitForChild("Head") or Character:FindFirstChild("Head")
    local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
    local Notification = ReplicatedStorage:WaitForChild("Notification") or ReplicatedStorage:FindFirstChild("Notification")
    local PlayerSelectedEvent = Notification:WaitForChild("PlayerSelectedEvent") or Notification:FindFirstChild("PlayerSelectedEvent")
    local AudioDevice = LocalPlayer:FindFirstChildWhichIsA("AudioDeviceInput") or LocalPlayer:WaitForChild("AudioDeviceInput") or LocalPlayer:FindFirstChild("AudioDeviceInput") or LocalPlayer:FindFirstChildOfClass("AudioDeviceInput")
    local Additional = ReplicatedStorage:WaitForChild("Additional") or ReplicatedStorage:FindFirstChild("Additional")
    local GetRemote = Additional:FindFirstChildWhichIsA("RemoteEvent") or Additional:FindFirstChildOfClass("RemoteEvent") or Additional:FindFirstChild("RemoteEvent") or Additional:WaitForChild("RemoteEvent")
    local AdminRemote = ReplicatedStorage:WaitForChild("Admin") or ReplicatedStorage:FindFirstChild("Admin")
    local Workspace = cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
    local AudioDeviceInput = LocalPlayer:FindFirstChildWhichIsA("AudioDeviceInput") or LocalPlayer:FindFirstChildOfClass("AudioDeviceInput") or LocalPlayer:FindFirstChild("AudioDeviceInput") or LocalPlayer:WaitForChild("AudioDeviceInput")

    AudioDeviceInput.Muted = true
end)

cmd.add({"unmute"}, {"unmute", "Unmutes yourself in-game"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local Head = Character:WaitForChild("Head") or Character:FindFirstChild("Head")
    local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
    local Notification = ReplicatedStorage:WaitForChild("Notification") or ReplicatedStorage:FindFirstChild("Notification")
    local PlayerSelectedEvent = Notification:WaitForChild("PlayerSelectedEvent") or Notification:FindFirstChild("PlayerSelectedEvent")
    local AudioDevice = LocalPlayer:FindFirstChildWhichIsA("AudioDeviceInput") or LocalPlayer:WaitForChild("AudioDeviceInput") or LocalPlayer:FindFirstChild("AudioDeviceInput") or LocalPlayer:FindFirstChildOfClass("AudioDeviceInput")
    local Additional = ReplicatedStorage:WaitForChild("Additional") or ReplicatedStorage:FindFirstChild("Additional")
    local GetRemote = Additional:FindFirstChildWhichIsA("RemoteEvent") or Additional:FindFirstChildOfClass("RemoteEvent") or Additional:FindFirstChild("RemoteEvent") or Additional:WaitForChild("RemoteEvent")
    local AdminRemote = ReplicatedStorage:WaitForChild("Admin") or ReplicatedStorage:FindFirstChild("Admin")
    local Workspace = cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
    local AudioDeviceInput = LocalPlayer:FindFirstChildWhichIsA("AudioDeviceInput") or LocalPlayer:FindFirstChildOfClass("AudioDeviceInput") or LocalPlayer:FindFirstChild("AudioDeviceInput") or LocalPlayer:WaitForChild("AudioDeviceInput")

    AudioDeviceInput.Muted = false
end)

cmd.add({"commands", "cmds"}, {"commands", "Open the command list"}, function()
	gui.commands()
end)

cmd.add({"tools", "freetools"}, {"tools / freetools", "Gives you Free FE Tools"}, function()
    local args = {
        [1] = "Fit"
    }
        
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Wand"
    }
        
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Horrible"
    }
        
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Doll"
    }
        
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Burrito"
    }
        
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Bloxy"
    }
        
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Bloxilicious"
    }
        
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Sauce"
    }
        
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Pistol"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Spray"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Torch"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Wand"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    local args = {
        [1] = "Camera"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Additional"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end)

cmd.add({"normal"}, {"normal", "Makes you normal sized"}, function()
    local args = {
        [1] = "ARegular",
        [2] = "Regular"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Admin"):FireServer(unpack(args))
    wait(0.2)
    local args = {
        [1] = tostring(game.Players.LocalPlayer.Name)
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Notification"):WaitForChild("ModifyUserEvent"):FireServer(unpack(args))
    wait(.2)
    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Health = 0
end)

cmd.add({"big", "huge", "large"}, {"big / huge / large", "Makes you big (Needs Admin GamePass)"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local Head = Character:WaitForChild("Head") or Character:FindFirstChild("Head")
    local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
    local Notification = ReplicatedStorage:WaitForChild("Notification") or ReplicatedStorage:FindFirstChild("Notification")
    local PlayerSelectedEvent = Notification:WaitForChild("PlayerSelectedEvent") or Notification:FindFirstChild("PlayerSelectedEvent")
    local AudioDevice = LocalPlayer:FindFirstChildWhichIsA("AudioDeviceInput") or LocalPlayer:WaitForChild("AudioDeviceInput") or LocalPlayer:FindFirstChild("AudioDeviceInput") or LocalPlayer:FindFirstChildOfClass("AudioDeviceInput")
    local Additional = ReplicatedStorage:WaitForChild("Additional") or ReplicatedStorage:FindFirstChild("Additional")
    local GetRemote = Additional:FindFirstChildWhichIsA("RemoteEvent") or Additional:FindFirstChildOfClass("RemoteEvent") or Additional:FindFirstChild("RemoteEvent") or Additional:WaitForChild("RemoteEvent")
    local AdminRemote = ReplicatedStorage:WaitForChild("Admin") or ReplicatedStorage:FindFirstChild("Admin")
    local Workspace = cloneref(game:GetService("Workspace")) or game:GetService("Workspace")

    local args = {
        [1] = "Huge",
        [2] = "Huge"
    }

    AdminRemote:FireServer(unpack(args))
end)

cmd.add({"rejoin", "rj"}, {"rejoin", "Rejoins the game"}, function()
	game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

cmd.add({"tiny", "small"}, {"tiny / small", "Makes you small (Needs Admin GamePass)"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local Head = Character:WaitForChild("Head") or Character:FindFirstChild("Head")
    local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
    local Notification = ReplicatedStorage:WaitForChild("Notification") or ReplicatedStorage:FindFirstChild("Notification")
    local PlayerSelectedEvent = Notification:WaitForChild("PlayerSelectedEvent") or Notification:FindFirstChild("PlayerSelectedEvent")
    local AudioDevice = LocalPlayer:FindFirstChildWhichIsA("AudioDeviceInput") or LocalPlayer:WaitForChild("AudioDeviceInput") or LocalPlayer:FindFirstChild("AudioDeviceInput") or LocalPlayer:FindFirstChildOfClass("AudioDeviceInput")
    local Additional = ReplicatedStorage:WaitForChild("Additional") or ReplicatedStorage:FindFirstChild("Additional")
    local GetRemote = Additional:FindFirstChildWhichIsA("RemoteEvent") or Additional:FindFirstChildOfClass("RemoteEvent") or Additional:FindFirstChild("RemoteEvent") or Additional:WaitForChild("RemoteEvent")
    local AdminRemote = ReplicatedStorage:WaitForChild("Admin") or ReplicatedStorage:FindFirstChild("Admin")
    local Workspace = cloneref(game:GetService("Workspace")) or game:GetService("Workspace")

    local args = {
        [1] = "Mini",
        [2] = "Mini"
    }

    AdminRemote:FireServer(unpack(args))
end)

cmd.add({"reset", "respawn"}, {"reset / respawn", "Resets your character and respawns"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local Head = Character:WaitForChild("Head") or Character:FindFirstChild("Head")
    local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
    local Notification = ReplicatedStorage:WaitForChild("Notification") or ReplicatedStorage:FindFirstChild("Notification")
    local PlayerSelectedEvent = Notification:WaitForChild("PlayerSelectedEvent") or Notification:FindFirstChild("PlayerSelectedEvent")
    local AudioDevice = LocalPlayer:FindFirstChildWhichIsA("AudioDeviceInput") or LocalPlayer:WaitForChild("AudioDeviceInput") or LocalPlayer:FindFirstChild("AudioDeviceInput") or LocalPlayer:FindFirstChildOfClass("AudioDeviceInput")
    local Additional = ReplicatedStorage:WaitForChild("Additional") or ReplicatedStorage:FindFirstChild("Additional")
    local GetRemote = Additional:FindFirstChildWhichIsA("RemoteEvent") or Additional:FindFirstChildOfClass("RemoteEvent") or Additional:FindFirstChild("RemoteEvent") or Additional:WaitForChild("RemoteEvent")
    local AdminRemote = ReplicatedStorage:WaitForChild("Admin") or ReplicatedStorage:FindFirstChild("Admin")
    local Workspace = cloneref(game:GetService("Workspace")) or game:GetService("Workspace")

    Humanoid.Health = 0
end)

cmd.add({"room", "privroom"}, {"room / privroom", "Teleports you to the private rooms (floor)"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local Head = Character:WaitForChild("Head") or Character:FindFirstChild("Head")
    local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
    local Notification = ReplicatedStorage:WaitForChild("Notification") or ReplicatedStorage:FindFirstChild("Notification")
    local PlayerSelectedEvent = Notification:WaitForChild("PlayerSelectedEvent") or Notification:FindFirstChild("PlayerSelectedEvent")
    local AudioDevice = LocalPlayer:FindFirstChildWhichIsA("AudioDeviceInput") or LocalPlayer:WaitForChild("AudioDeviceInput") or LocalPlayer:FindFirstChild("AudioDeviceInput") or LocalPlayer:FindFirstChildOfClass("AudioDeviceInput")
    local Additional = ReplicatedStorage:WaitForChild("Additional") or ReplicatedStorage:FindFirstChild("Additional")
    local GetRemote = Additional:FindFirstChildWhichIsA("RemoteEvent") or Additional:FindFirstChildOfClass("RemoteEvent") or Additional:FindFirstChild("RemoteEvent") or Additional:WaitForChild("RemoteEvent")
    local AdminRemote = ReplicatedStorage:WaitForChild("Admin") or ReplicatedStorage:FindFirstChild("Admin")
    local Workspace = cloneref(game:GetService("Workspace")) or game:GetService("Workspace")

    HumanoidRootPart.CFrame = CFrame.new(4220.82275, 2.76511836, 60.7681046)
end)

wrap(function()
	--i am so not putting an emulator as a command here
end)

--[ LOCALPLAYER ]--
local function respawn()
	character:ClearAllChildren()
	local newChar = Instance.new("Model", workspace)
	local hum = Instance.new("Humanoid", newChar)
	local torso = Instance.new("Part", newChar)
	newChar.Name = "respawn_"
	torso.Name = "Torso"
	torso.Transparency = 1
	player.Character = newChar
	newChar:MoveTo(Vector3.new(999999, 999999, 999999))
	torso.Name = ""
	torso.CanCollide = false
end

local function refresh()
	local cf, p = CFrame.new(), character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
	if p then
		cf = p.CFrame
	end
	respawn()
	player.CharacterAdded:Wait(); wait(0.2);
	character:WaitForChild("HumanoidRootPart").CFrame = cf
end

local abort = 0
local function getTools(amt)
	if not amt then amt = 1 end
	local toolAmount, grabbed = 0, {}
	local lastCF = character.PrimaryPart.CFrame
	local ab = abort
	
	for i, v in pairs(localPlayer:FindFirstChildWhichIsA("Backpack"):GetChildren()) do
		if v:IsA("BackpackItem") then
			toolAmount = toolAmount + 1
		end
	end
	if toolAmount >= amt then return localPlayer:FindFirstChildWhichIsA("Backpack"):GetChildren() end
	if not localPlayer:FindFirstChildWhichIsA("Backpack"):FindFirstChildWhichIsA("BackpackItem") then return end
	
	repeat
		repeat wait() until localPlayer:FindFirstChildWhichIsA("Backpack") or ab ~= abort
		backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
		wrap(function()
			repeat wait() until backpack:FindFirstChildWhichIsA("BackpackItem")
			for _, tool in pairs(backpack:GetChildren()) do
				if #grabbed >= amt or ab ~= abort then break end
				if tool:IsA("BackpackItem") then
					tool.Parent = localPlayer
					table.insert(grabbed, tool)
				end
			end
		end)
		
		respawn()
		wait(.1)
	until
		#grabbed >= amt or ab ~= abort
	
	repeat wait() until localPlayer.Character and tostring(localPlayer.Character) ~= "respawn_" and localPlayer.Character == character
	wait(.2)
	
	repeat wait() until localPlayer:FindFirstChildWhichIsA("Backpack") or ab ~= abort
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	for _, tool in pairs(grabbed) do
		if tool:IsA("BackpackItem") then
			tool.Parent = backpack
		end
	end
	wrap(function()
		repeat wait() until character.PrimaryPart
		wait(.2)
		character:SetPrimaryPartCFrame(lastCF)
	end)
	wait(.2)
	return grabbed
end

cmd.add({"zombie"}, {"zombie", "Equips Zombie classic animation pack (FE)"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local Animate = Character:FindFirstChild("Animate") or Character:WaitForChild("Animate")
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = Humanoid:GetPlayingAnimationTracks()
    for i, track in pairs(animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
    wait()
    Humanoid:ChangeState(3)
    wait()
    Animate.Disabled = false
end)

cmd.add({"freeze", "anchor"}, {"freeze / anchor", "Freezes your character"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")

    humanoidRootPart.Anchored = true
end)

cmd.add({"unfreeze", "unanchor"}, {"freeze / unanchor", "Unfreezes your character"}, function()
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")
    
    humanoidRootPart.Anchored = false
end)

cmd.add({"warn"}, {"warn <player>", "Warns a specific player"}, function(getPlayer)
    local FindThePlayer = findplr(getPlayer)
    if FindThePlayer then
        local args = {
            [1] = tostring(FindThePlayer.Name)
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Notification"):WaitForChild("PlayerSelectedEvent"):FireServer(unpack(args))
    else
        lib.messageOut("[Admin Error]:", "Player was not found!")
    end
end)

cmd.add({"loopwarn"}, {"loopwarn <player>", "Loop warns a specific player"}, function(loopWarnPlr)
    local LoopFindThePlayer = findplr(loopWarnPlr)
    if LoopFindThePlayer then
        getgenv().feedWarnings = true
        while getgenv().feedWarnings == true do
        wait()
            local args = {
                [1] = tostring(LoopFindThePlayer.Name)
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Notification"):WaitForChild("PlayerSelectedEvent"):FireServer(unpack(args))
        end
    else
        getgenv().feedWarnings = false
        return lib.messageOut("[Admin Error]:", "Player was not found!")
    end
end)

cmd.add({"stopwarning"}, {"stopwarning", "Stops sending loop warnings to the player"}, function()
    getgenv().feedWarnings = false
    wait(1)
    for i = 1, 50 do
        getgenv().feedWarnings = false
    end
end)

cmd.add({"loopwarnall"}, {"loopwarnall", "Loop sends warnings to the entire server"}, function()
    getgenv().DoLoopWarn = true
    while getgenv().DoLoopWarn == true do
    wait(0.7)
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                local args = {
                    [1] = tostring(v.Name)
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Notification"):WaitForChild("PlayerSelectedEvent"):FireServer(unpack(args))
            end
        end
    end
end)

cmd.add({"unloopwarnall"}, {"unloopwarnall", "Stops all loop warnings"}, function()
    getgenv().DoLoopWarn = false
    wait(1)
    for i = 1, 50 do
        getgenv().DoLoopWarn = false
    end
end)

cmd.add({"goto", "tp"}, {"goto / tp", "Teleports to the player specified"}, function(FindTPPlayer)
    local bruhTP = findplr(FindTPPlayer)
    local Players = cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart")

    if bruhTP then
        local OtherChar = bruhTP.Character or bruhTP.CharacterAdded:Wait()
        local OtherHRP = OtherChar:FindFirstChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(OtherHRP.Position)
    else
        return lib.messageOut("[Admin Error]:", "Player was not found!")
    end
end)

local flyPart
cmd.add({"fly"}, {"fly [speed]", "Enable flight"}, function(speed)
	if not speed then speed = 5 end
	if connections["fly"] then lib.disconnect("fly") character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false end
	local dir = {w = false, a = false, s = false, d = false}
	local cf = Instance.new("CFrameValue")
	
	flyPart = flyPart or Instance.new("Part")
	flyPart.Anchored = true
	pcall(function()
		flyPart.CFrame = character.HumanoidRootPart.CFrame
	end)
	
	lib.connect("fly", RunService.RenderStepped:Connect(function()
		if not character:FindFirstChild("HumanoidRootPart") then return end
		local primaryPart = character.HumanoidRootPart
		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		
		local x, y, z = 0, 0, 0
		if dir.w then z = -1 * speed end
		if dir.a then x = -1 * speed end
		if dir.s then z = 1 * speed end
		if dir.d then x = 1 * speed end
		if dir.q then y = 1 * speed end
		if dir.e then y = -1 * speed end
		
		for i, v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Velocity = Vector3.new(0, 0, 0)
				v.RotVelocity = Vector3.new(0, 0, 0)
			end
		end
		flyPart.CFrame = CFrame.new(
			flyPart.CFrame.p,
			(camera.CFrame * CFrame.new(0, 0, -100)).p
		)
		
		local moveDir = CFrame.new(x,y,z)
		cf.Value = cf.Value:lerp(moveDir, 0.2)
		flyPart.CFrame = flyPart.CFrame:lerp(flyPart.CFrame * cf.Value, 0.2)
		primaryPart.CFrame = flyPart.CFrame
		humanoid.PlatformStand = true
	end))
	lib.connect("fly", UserInputService.InputBegan:Connect(function(input, event)
		if event then return end
		local code, codes = input.KeyCode, Enum.KeyCode
		if code == codes.W then
			dir.w = true
		elseif code == codes.A then
			dir.a = true
		elseif code == codes.S then
			dir.s = true
		elseif code == codes.D then
			dir.d = true
		elseif code == codes.Q then
			dir.q = true
		elseif code == codes.E then
			dir.e = true
		elseif code == codes.Space then
			dir.q = true
		end
	end))
	lib.connect("fly", UserInputService.InputEnded:Connect(function(input, event)
		if event then return end
		local code, codes = input.KeyCode, Enum.KeyCode
		if code == codes.W then
			dir.w = false
		elseif code == codes.A then
			dir.a = false
		elseif code == codes.S then
			dir.s = false
		elseif code == codes.D then
			dir.d = false
		elseif code == codes.Q then
			dir.q = false
		elseif code == codes.E then
			dir.e = false
		elseif code == codes.Space then
			dir.q = false
		end
	end))
end)
cmd.add({"unfly"}, {"unfly", "Disable flight"}, function()
	lib.disconnect("fly")
	flyPart:Destroy()
	character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
end)

cmd.add({"noclip", "nclip", "nc"}, {"noclip", "Disable your player's collision"}, function()
	if connections["noclip"] then lib.disconnect("noclip") return end
	lib.connect("noclip", RunService.Stepped:Connect(function()
		if not character then return end
		for i, v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end))
end)

cmd.add({"clip", "c"}, {"clip", "Enable your player's collision"}, function()
	lib.disconnect("noclip")
end)

cmd.add({"freecam", "fc", "fcam"}, {"freecam [speed]", "Enable free camera"}, function(speed)
	if not speed then speed = 5 end
	if connections["freecam"] then lib.disconnect("freecam") camera.CameraSubject = character 	wrap(function() character.PrimaryPart.Anchored = false end) end
	local dir = {w = false, a = false, s = false, d = false}
	local cf = Instance.new("CFrameValue")
	local camPart = Instance.new("Part")
	camPart.Transparency = 1
	camPart.Anchored = true
	camPart.CFrame = camera.CFrame
	wrap(function()
		character.PrimaryPart.Anchored = true
	end)
	
	lib.connect("freecam", RunService.RenderStepped:Connect(function()
		local primaryPart = camPart
		camera.CameraSubject = primaryPart
		
		local x, y, z = 0, 0, 0
		if dir.w then z = -1 * speed end
		if dir.a then x = -1 * speed end
		if dir.s then z = 1 * speed end
		if dir.d then x = 1 * speed end
		if dir.q then y = 1 * speed end
		if dir.e then y = -1 * speed end
		
		primaryPart.CFrame = CFrame.new(
			primaryPart.CFrame.p,
			(camera.CFrame * CFrame.new(0, 0, -100)).p
		)
		
		local moveDir = CFrame.new(x,y,z)
		cf.Value = cf.Value:lerp(moveDir, 0.2)
		primaryPart.CFrame = primaryPart.CFrame:lerp(primaryPart.CFrame * cf.Value, 0.2)
	end))
	lib.connect("freecam", UserInputService.InputBegan:Connect(function(input, event)
		if event then return end
		local code, codes = input.KeyCode, Enum.KeyCode
		if code == codes.W then
			dir.w = true
		elseif code == codes.A then
			dir.a = true
		elseif code == codes.S then
			dir.s = true
		elseif code == codes.D then
			dir.d = true
		elseif code == codes.Q then
			dir.q = true
		elseif code == codes.E then
			dir.e = true
		elseif code == codes.Space then
			dir.q = true
		end
	end))
	lib.connect("freecam", UserInputService.InputEnded:Connect(function(input, event)
		if event then return end
		local code, codes = input.KeyCode, Enum.KeyCode
		if code == codes.W then
			dir.w = false
		elseif code == codes.A then
			dir.a = false
		elseif code == codes.S then
			dir.s = false
		elseif code == codes.D then
			dir.d = false
		elseif code == codes.Q then
			dir.q = false
		elseif code == codes.E then
			dir.e = false
		elseif code == codes.Space then
			dir.q = false
		end
	end))
end)
cmd.add({"unfreecam", "unfc", "unfcam"}, {"unfreecam", "Disable free camera"}, function()
	lib.disconnect("freecam")
	camera.CameraSubject = character
	wrap(function()
		character.PrimaryPart.Anchored = false
	end)
end)

cmd.add({"fixcam", "fix"}, {"fixcam", "Fix your camera"}, function()
	camera.CameraSubject = character:FindFirstChildWhichIsA("Humanoid")
	camera.CameraType = camtype
end)

cmd.add({"watch", "view"}, {"watch <player>", "Watch the given player"}, function(p)
	local getViewingPlayer = findplr(p)
	if getViewingPlayer then
		camera.CameraSubject = getViewingPlayer.Character:FindFirstChildWhichIsA("Humanoid")
	end
end)

cmd.add({"unwatch", "unview"}, {"unwatch", "Stop watching a player"}, function()
	if character and character:FindFirstChildWhichIsA("Humanoid") then
		camera.CameraSubject = character:FindFirstChildWhichIsA("Humanoid")
	end
end)

--[[ FUNCTIONALITY ]]--
localPlayer.Chatted:Connect(function(str)
	lib.parseCommand(str)
end)


--[[ GUI VARIABLES ]]--
local ScreenGui
if not RunService:IsStudio() then
	ScreenGui = game:GetObjects("rbxassetid://4281507772")[1]
else
	repeat wait() until player:FindFirstChild("AdminUI", true)
	ScreenGui = player:FindFirstChild("AdminUI", true)
end

local description = ScreenGui.Description
local cmdBar = ScreenGui.CmdBar
	local centerBar = cmdBar.CenterBar
		local cmdInput = centerBar.Input
	local cmdAutofill = cmdBar.Autofill
		local cmdExample = cmdAutofill.Cmd
	local leftFill = cmdBar.LeftFill
	local rightFill = cmdBar.RightFill
local chatLogsFrame = ScreenGui.ChatLogs
	local chatLogs = chatLogsFrame.Container.Logs
		local chatExample = chatLogs.TextLabel
local commandsFrame = ScreenGui.Commands
	local commandsFilter = commandsFrame.Container.Filter
	local commandsList = commandsFrame.Container.List
		local commandExample = commandsList.TextLabel
local resizeFrame = ScreenGui.Resizeable
local resizeXY = {
	Top		= {Vector2.new(0, -1),	Vector2.new(0, -1),	"rbxassetid://2911850935"},
	Bottom	= {Vector2.new(0, 1),	Vector2.new(0, 0),	"rbxassetid://2911850935"},
	Left	= {Vector2.new(-1, 0),	Vector2.new(1, 0),	"rbxassetid://2911851464"},
	Right	= {Vector2.new(1, 0),	Vector2.new(0, 0),	"rbxassetid://2911851464"},
	
	TopLeft		= {Vector2.new(-1, -1),	Vector2.new(1, -1),	"rbxassetid://2911852219"},
	TopRight	= {Vector2.new(1, -1),	Vector2.new(0, -1),	"rbxassetid://2911851859"},
	BottomLeft	= {Vector2.new(-1, 1),	Vector2.new(1, 0),	"rbxassetid://2911851859"},
	BottomRight	= {Vector2.new(1, 1),	Vector2.new(0, 0),	"rbxassetid://2911852219"},
}

cmdExample.Parent = nil
chatExample.Parent = nil
commandExample.Parent = nil
resizeFrame.Parent = nil

local rPlayer = Players:FindFirstChildWhichIsA("Player")
local coreGuiProtection = {}

pcall(function()
	for i, v in pairs(ScreenGui:GetDescendants()) do
		coreGuiProtection[v] = rPlayer.Name
	end
	ScreenGui.DescendantAdded:Connect(function(v)
		coreGuiProtection[v] = rPlayer.Name
	end)
	coreGuiProtection[ScreenGui] = rPlayer.Name
	 
	local meta = getrawmetatable(game)
	local tostr = meta.__tostring
	setreadonly(meta, false)
	meta.__tostring = newcclosure(function(t)
		if coreGuiProtection[t] and not checkcaller() then
			return coreGuiProtection[t]
		end
		return tostr(t)
	end)
end)
if not RunService:IsStudio() then
	local newGui = game:GetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui")
	newGui.DescendantAdded:Connect(function(v)
		coreGuiProtection[v] = rPlayer.Name
	end)
	for i, v in pairs(ScreenGui:GetChildren()) do
		v.Parent = newGui
	end
	ScreenGui = newGui
end

--[[ GUI FUNCTIONS ]]--
gui = {}
gui.txtSize = function(ui, x, y)
	local textService = game:GetService("TextService")
	return textService:GetTextSize(ui.Text, ui.TextSize, ui.Font, Vector2.new(x, y))
end
gui.commands = function()
	if not commandsFrame.Visible then
		commandsFrame.Visible = true
		commandsList.CanvasSize = UDim2.new(0, 0, 0, 0)
	end
	for i, v in pairs(commandsList:GetChildren()) do
		if v:IsA("TextLabel") then
			Destroy(v)
		end
	end
	local i = 0
	for cmdName, tbl in pairs(Commands) do
		local Cmd = commandExample:Clone()
		Cmd.Parent = commandsList
		Cmd.Name = cmdName
		Cmd.Text = " " .. tbl[2][1]
		Cmd.MouseEnter:Connect(function()
			description.Visible = true
			description.Text = tbl[2][2]
		end)
		Cmd.MouseLeave:Connect(function()
			if description.Text == tbl[2][2] then
				description.Visible = false
				description.Text = ""
			end
		end)
		i = i + 1
	end
	commandsList.CanvasSize = UDim2.new(0, 0, 0, i*20+10)
	commandsFrame.Position = UDim2.new(0.5, -283/2, 0.5, -260/2)
end
gui.chatlogs = function()
	if not chatLogsFrame.Visible then
		chatLogsFrame.Visible = true
	end
	chatLogsFrame.Position = UDim2.new(0.5, -283/2+5, 0.5, -260/2+5)
end

gui.tween = function(obj, style, direction, duration, goal)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle[style], Enum.EasingDirection[direction])
	local tween = TweenService:Create(obj, tweenInfo, goal)
	tween:Play()
	return tween
end
gui.mouseIn = function(guiObject, range)
	local pos1, pos2 = guiObject.AbsolutePosition, guiObject.AbsolutePosition + guiObject.AbsoluteSize
	local mX, mY = mouse.X, mouse.Y
	if mX > pos1.X-range and mX < pos2.X+range and mY > pos1.Y-range and mY < pos2.Y+range then
		return true
	end
	return false
end
gui.resizeable = function(ui, min, max)
	local rgui = resizeFrame:Clone()
	rgui.Parent = ui
	
	local mode
	local UIPos
	local lastSize
	local lastPos = Vector2.new()
	
	local function update(delta)
		local xy = resizeXY[(mode and mode.Name) or '']
		if not mode or not xy then return end
		local delta = (delta * xy[1]) or Vector2.new()
		local newSize = Vector2.new(lastSize.X + delta.X, lastSize.Y + delta.Y)
		newSize = Vector2.new(
			math.clamp(newSize.X, min.X, max.X),
			math.clamp(newSize.Y, min.Y, max.Y)
		)
		ui.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
		ui.Position = UDim2.new(
			UIPos.X.Scale, 
			UIPos.X.Offset + (-(newSize.X - lastSize.X) * xy[2]).X, 
			UIPos.Y.Scale, 
			UIPos.Y.Offset + (delta * xy[2]).Y
		)
	end
	
	mouse.Move:Connect(function()
		update(Vector2.new(mouse.X, mouse.Y) - lastPos)
	end)
	
	for _, button in pairs(rgui:GetChildren()) do
		local isIn = false
		button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				mode = button
				lastPos = Vector2.new(mouse.X, mouse.Y)
				lastSize = ui.AbsoluteSize
				UIPos = ui.Position
			end
		end)
		button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				mode = nil
			end
		end)
		button.MouseEnter:Connect(function()
			mouse.Icon = resizeXY[button.Name][3]
		end)
		button.MouseLeave:Connect(function()
			if mouse.Icon == resizeXY[button.Name][3] then
				mouse.Icon = ""
			end
		end)
	end
end
gui.draggable = function(ui, dragui)
	if not dragui then dragui = ui end
	local UserInputService = game:GetService("UserInputService")
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		ui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	dragui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = ui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	dragui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
gui.menuify = function(menu)
	local exit = menu:FindFirstChild("Exit", true)
	local mini = menu:FindFirstChild("Minimize", true)
	local minimized = false
	local sizeX, sizeY = Instance.new("IntValue", menu), Instance.new("IntValue", menu)
	mini.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			sizeX.Value = menu.Size.X.Offset
			sizeY.Value = menu.Size.Y.Offset
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, 200, 0, 25)})
		else
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, sizeY.Value)})
		end
	end)
	exit.MouseButton1Click:Connect(function()
		menu.Visible = false
	end)
	gui.draggable(menu, menu.Topbar)
	menu.Visible = false
end
gui.barSelect = function(speed)
	centerBar.Visible = true
	gui.tween(centerBar, "Sine", "Out", speed or 0.25, {Size = UDim2.new(0, 250, 1, 15)})
	gui.tween(leftFill, "Quad", "Out", speed or 0.3, {Position = UDim2.new(0, 0, 0.5, 0)})
	gui.tween(rightFill, "Quad", "Out", speed or 0.3, {Position = UDim2.new(1, 0, 0.5, 0)})
	gui.loadCommands()
end
gui.barDeselect = function(speed)
	gui.tween(centerBar, "Sine", "Out", speed or 0.25, {Size = UDim2.new(0, 250, 0, 0)})
	gui.tween(leftFill, "Sine", "In", speed or 0.3, {Position = UDim2.new(-0.5, 100, 0.5, 0)})
	gui.tween(rightFill, "Sine", "In", speed or 0.3, {Position = UDim2.new(1.5, -100, 0.5, 0)})
	for i, v in pairs(cmdAutofill:GetChildren()) do
		if v:IsA("Frame") then
			wrap(function()
				wait(math.random(1, 200)/2000)
				gui.tween(v, "Back", "In", 0.35, {Size = UDim2.new(0, 0, 0, 25)})
			end)
		end
	end
end
gui.loadCommands = function()
	for i, v in pairs(cmdAutofill:GetChildren()) do
		if v.Name ~= "UIListLayout" then
			Destroy(v)
		end
	end
	local last = nil
	local i = 0
	for name, tbl in pairs(Commands) do
		local info = tbl[2]
		local btn = cmdExample:Clone()
		btn.Parent = cmdAutofill
		btn.Name = name
		btn.Input.Text = info[1]
		i = i + 1
		
		local size = btn.Size
		btn.Size = UDim2.new(0, 0, 0, 25)
		btn.Size = size
	end
end
gui.searchCommands = function()
	local _1, _2, _3, _0 = {}, {}, {}, {}
	local str = cmdInput.Text:gmatch("[^ ;]+")()
	if str then str = str:lower() else str = "" end
	
	for i, v in pairs(cmdAutofill:GetChildren()) do
		if v:IsA("Frame") then
			local found = Commands[v.Name]
			if Commands[v.Name] then
				if str ~= "" and v.Name:find(str) == 1 then
					v.LayoutOrder = 1
					table.insert(_1, v)
				end
				if str ~= "" and v.Name:find(str) and v.LayoutOrder ~= 1 then
					v.LayoutOrder = 2
					table.insert(_2, v)
				end
				if str == "" or v.Name:find(str) == nil then
					v.LayoutOrder = 3
					table.insert(_3, v)
				end
			end
			for CmdName, tbl in pairs(Aliases) do
				if Commands[v.Name][1] == tbl[1] then
					if str ~= "" and CmdName:find(str) == 1 then
						v.LayoutOrder = 1
						table.insert(_1, v)
					end
					if str ~= "" and CmdName:find(str) then
						v.LayoutOrder = 2
						table.insert(_2, v)
					end
					if str == "" or CmdName:find(str) == nil then
						v.LayoutOrder = 3
						table.insert(_3, v)
					end
					break
				end
			end
		end
	end
	
	for i, v in pairs(_1) do if not lib.find(_0, v) then table.insert(_0, v) end end
	for i, v in pairs(_2) do if not lib.find(_0, v) then table.insert(_0, v) end end
	for i, v in pairs(_3) do if not lib.find(_0, v) then table.insert(_0, v) end end
	
	local last
	for i, v in pairs(_0) do
		local n = (i ^ -0.5) * 125
		if last then
			local pos = last.Value.Value
			local newPos = UDim2.new(0.5, 0, 0, pos + 25 + 3)
			gui.tween(v, "Quint", "Out", 0.3, {
				Size = UDim2.new(0.5, n, 0, 25)
			})
			v.Value.Value = newPos.Y.Offset
			v.LayoutOrder = i
		else
			gui.tween(v, "Quint", "Out", 0.3, {
				Size = UDim2.new(0.5, n, 0, 25)
			})
			v.Value.Value = 0
			v.LayoutOrder = i
		end
		last = v
	end
end

--[[ GUI FUNCTIONALITY ]]--
mouse.KeyDown:Connect(function(k)
	if k:lower() == opt.prefix then
		gui.barSelect()
		cmdInput.Text = ''
		cmdInput:CaptureFocus()
	end
end)

cmdInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		wrap(function()
			lib.parseCommand(opt.prefix .. cmdInput.Text)
		end)
	end
	gui.barDeselect()
end)

cmdInput.Changed:Connect(function(p)
	if p ~= "Text" then return end
	gui.searchCommands()
end)

gui.barDeselect(0)
cmdBar.Visible = true
gui.menuify(chatLogsFrame)
gui.menuify(commandsFrame)
gui.resizeable(chatLogsFrame, Vector2.new(173,58), Vector2.new(1000,1000))
gui.resizeable(commandsFrame, Vector2.new(184,84), Vector2.new(1000,1000))

commandsFilter.Changed:Connect(function(p)
	if p ~= "Text" then return end
	for i, v in pairs(commandsList:GetChildren()) do
		if v:IsA("TextLabel") then
			if v.Name:find(commandsFilter.Text:lower()) and v.Name:find(commandsFilter.Text:lower()) <= 2 then
				v.Visible = true
			else
				v.Visible = false
			end
		end
	end
end)

local function bindToChat(plr, msg)
	local chatMsg = chatExample:Clone()
	for i, v in pairs(chatLogs:GetChildren()) do
		if v:IsA("TextLabel") then
			v.LayoutOrder = v.LayoutOrder + 1
		end
	end
	chatMsg.Parent = chatLogs
	chatMsg.Text = ("[%s]: %s"):format(plr.Name, msg)
	
	local txtSize = gui.txtSize(chatMsg, chatMsg.AbsoluteSize.X, 100)
	chatMsg.Size = UDim2.new(1, -5, 0, txtSize.Y)
end

for i, plr in pairs(Players:GetPlayers()) do
	plr.Chatted:Connect(function(msg)
		bindToChat(plr, msg)
	end)
end
Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		bindToChat(plr, msg)
	end)
end)

mouse.Move:Connect(function()
	description.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
	local size = gui.txtSize(description, 200, 100)
	description.Size = UDim2.new(0, size.X, 0, size.Y)
end)

RunService.Stepped:Connect(function()
	chatLogs.CanvasSize = UDim2.new(0, 0, 0, chatLogs.UIListLayout.AbsoluteContentSize.Y)
	commandsList.CanvasSize = UDim2.new(0, 0, 0, commandsList.UIListLayout.AbsoluteContentSize.Y)
end)

function Destroy(guiObject)
	if not pcall(function()guiObject.Parent = game:GetService("CoreGui")end) then
		guiObject.Parent = nil
	end
end
