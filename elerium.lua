
--[[
  ______ _      ______ _____  _____ _    _ __  __ 
 |  ____| |    |  ____|  __ \|_   _| |  | |  \/  | 
 | |__  | |    | |__  | |__) | | | | |  | | \  / |
 |  __| | |    |  __| |  _  /  | | | |  | | |\/| |
 | |____| |____| |____| | \ \ _| |_| |__| | |  | |
 |______|______|______|_|  \_\_____|\____/|_|  |_|     
 __          __
 \ \        / /
  \ \  /\  / / 
   \ \/  \/ /  
    \  /\  /   
     \/  \/    
           
]]


local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Elerium", 5013109572)
local Client = game.Players.LocalPlayer
local aimPage = venyx:addPage("Aimbot", 5012544693)
local silentAimSection = aimPage:addSection("Silent Aim")
local aimbotSection = aimPage:addSection("Aimbot")
local miscWeaponsSectionE = venyx:addPage("Gun Mods", 5013109572)
local miscWeaponsSection = miscWeaponsSectionE:addSection("Gun Mods")
local infosec = venyx:addPage("UI Info", 5012544693)
local infosecsec = infosec:addSection("Toggle")
local playerPage = venyx:addPage("Player Mods", 5012544693)
local playerSection = playerPage:addSection("Player Mods")
local visualsPage = venyx:addPage("Visuals", 5013109572)
local visualsSection = visualsPage:addSection("ESP")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local aimbotPart = "Head"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer
local wait = task.wait 
local spawn = task.spawn 
local tc = false

local creditsPage = venyx:addPage("Credits", 5012544693)
local creditsSection = creditsPage:addSection("Scripting by mosafe#0001")


local Name = "Arsenal.txt"

Des = {}
if makefolder then
    makefolder("Elerium Hub")
end

local Settings

if
    not pcall(
        function()
            readfile("Elerium Hub//" .. Name)
        end
    )
 then
    writefile("Elerium Hub//" .. Name, HttpService:JSONEncode(Des))
end

Settings = HttpService:JSONDecode(readfile("Elerium Hub//" .. Name))

local function Save()
    writefile("Elerium Hub//" .. Name, HttpService:JSONEncode(Settings))
end






playerSection:addSlider("Jump Power", Client.Character.Humanoid.JumpPower, 0, 500, function(value) Client.Character.Humanoid.JumpPower = value end)


playerSection:addSlider("Walkspeed", Client.Character.Humanoid.WalkSpeed, 0, 500, function(value) Client.Character.Humanoid.WalkSpeed = value end)


local Toggle1 = aimbotSection:addToggle("Team Check", nil, function(State)
    if state then
       tc = State
    end
end)

local Toggle1 = aimbotSection:addToggle("TriggerBot (broken)", nil, function(State)
    print(" broken ")
end)

local Toggle1 = aimbotSection:addToggle("WallCheck", nil, function(State)
    print("  ")
end)


local noBulletHoleButton = miscWeaponsSection:addToggle("No Bullet Holes", nil, function(value)
  noBulletHoleson = value
  pcall(function()
      local oldFunc
      if noBulletHoleson then
          oldFunc = hookfunction(Client.createbullethole, function() end)
      else
          hookfunction(Client.createbullethoes, oldFunc)
      end
  end)
end)
local noParticlesButton = miscWeaponsSection:addToggle("No Particles", nil, function(value)
  noParticleson = value
  pcall(function()
      local oldFunc
      if noParticleson then
          oldFunc = hookfunction(Client.createparticle, function() end)
      else
          hookfunction(Client.createparticle, oldFunc)
      end
  end)
end)
local noTrailsButton = miscWeaponsSection:addToggle("No Trails(For weapons like Railgun)", nil, function(value)
  noTrailson = value
  pcall(function()
      local oldFunc
      if noTrailson then
          oldFunc = hookfunction(Client.createtrail, function() end)
      else
          hookfunction(Client.createtrail, oldFunc)
      end
  end)
end)
local infJumpButton = playerSection:addButton("Inf Jump", function()
local UIS = game:GetService'UserInputService';
 
_G.JumpHeight = 50;
 
function Action(Object, Function) if Object ~= nil then Function(Object); end end
 
UIS.InputBegan:connect(function(UserInput)
    if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
        Action(Player.Character.Humanoid, function(self)
            if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                Action(self.Parent.HumanoidRootPart, function(self)
                    self.Velocity = Vector3.new(0, _G.JumpHeight, 0);
                end)
            end
        end)
    end
end)
end)

aimbotSection:addButton("Aimbot (Mouse2)", function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/aimbot.lua"))()
end)

silentAimSection:addToggle("Silent Aim", nil, function(val)
    local CurrentCamera = workspace.CurrentCamera
    local Players = game.GetService(game, "Players")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    function ClosestPlayer()
        local MaxDist, Closest = math.huge
        for I,V in pairs(Players.GetPlayers(Players)) do
            if V == LocalPlayer then continue end
            if V.Team == LocalPlayer then continue end
            if not V.Character then continue end
            local Head = V.Character.FindFirstChild(V.Character, aimbotPart)
            if not Head then continue end
            local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
            if not Vis then continue end
            local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
            local Dist = (TheirPos - MousePos).Magnitude
            if Dist < MaxDist then
                MaxDist = Dist
                Closest = V
                print("working")
            end
        end
        return Closest
    end
    local MT = getrawmetatable(game)
    local OldNC = MT.__namecall
    local OldIDX = MT.__index
    setreadonly(MT, false)
    MT.__namecall = newcclosure(function(self, ...)
        local Args, Method = {...}, getnamecallmethod()
        if Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
            local CP = ClosestPlayer()
            if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, aimbotPart) then
                Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character.Head.Position - CurrentCamera.CFrame.Position).Unit * 1000)
                return OldNC(self, unpack(Args))
            end
        end
        return OldNC(self, ...)
    end)
    MT.__index = newcclosure(function(self, K)
        if K == "Clips" then
            return workspace.Map
        end
        return OldIDX(self, K)
    end)
    setreadonly(MT, true)
end)

infosecsec:addKeybind("Toggle UI Keybind", Enum.KeyCode.V, function() 
  venyx:toggle()
end, 
function(value) toggleUIKey = value end)



visualsSection:addToggle("ESP", nil, function(v)
    local function API_Check()
        if Drawing == nil then
            return "No"
        else
            return "Yes"
        end
    end
    
    local Find_Required = API_Check()
    
    if Find_Required == "No" then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Loaded ESP!";
            Text = "ESP script may not be loaded because your exploit is unsupported.";
            Duration = math.huge;
            Button1 = "continue"
        })
    
        return
    end
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Camera = workspace.CurrentCamera
    
    local Typing = false
    
    _G.SendNotifications = true   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
    _G.DefaultSettings = false   -- If set to true then the ESP script would run with default settings regardless of any changes you made.
    
    _G.TeamCheck = tc   -- If set to true then the script would create ESP only for the enemy team members.
    
    _G.ESPVisible = true   -- If set to true then the ESP will be visible and vice versa.
    _G.TextColor = Color3.fromRGB(255, 80, 10)   -- The color that the boxes would appear as.
    _G.TextSize = 14   -- The size of the text.
    _G.Center = true   -- If set to true then the script would be located at the center of the label.
    _G.Outline = true   -- If set to true then the text would have an outline.
    _G.OutlineColor = Color3.fromRGB(0, 0, 0)   -- The outline color of the text.
    _G.TextTransparency = 0.7   -- The transparency of the text.
    _G.TextFont = Drawing.Fonts.UI   -- The font of the text. (UI, System, Plex, Monospace) 
    
    _G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the ESP.
    
    local function CreateESP()
        for _, v in next, Players:GetPlayers() do
            if v.Name ~= Players.LocalPlayer.Name then
                local ESP = Drawing.new("Text")
    
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                        local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
    
                        ESP.Size = _G.TextSize
                        ESP.Center = _G.Center
                        ESP.Outline = _G.Outline
                        ESP.OutlineColor = _G.OutlineColor
                        ESP.Color = _G.TextColor
                        ESP.Transparency = _G.TextTransparency
                        ESP.Font = _G.TextFont
    
                        if OnScreen == true then
                            local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                            local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                            local Dist = (Part1 - Part2).Magnitude
                            ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                            ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= v.Team then
                                    ESP.Visible = _G.ESPVisible
                                else
                                    ESP.Visible = false
                                end
                            else
                                ESP.Visible = _G.ESPVisible
                            end
                        else
                            ESP.Visible = false
                        end
                    else
                        ESP.Visible = false
                    end
                end)
    
                Players.PlayerRemoving:Connect(function()
                    ESP.Visible = false
                end)
            end
        end
    
        Players.PlayerAdded:Connect(function(Player)
            Player.CharacterAdded:Connect(function(v)
                if v.Name ~= Players.LocalPlayer.Name then 
                    local ESP = Drawing.new("Text")
        
                    RunService.RenderStepped:Connect(function()
                        if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                            local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
        
                            ESP.Size = _G.TextSize
                            ESP.Center = _G.Center
                            ESP.Outline = _G.Outline
                            ESP.OutlineColor = _G.OutlineColor
                            ESP.Color = _G.TextColor
                            ESP.Transparency = _G.TextTransparency
        
                            if OnScreen == true then
                                local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                            local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                                local Dist = (Part1 - Part2).Magnitude
                                ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                                ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                                if _G.TeamCheck == true then 
                                    if Players.LocalPlayer.Team ~= Player.Team then
                                        ESP.Visible = _G.ESPVisible
                                    else
                                        ESP.Visible = false
                                    end
                                else
                                    ESP.Visible = _G.ESPVisible
                                end
                            else
                                ESP.Visible = false
                            end
                        else
                            ESP.Visible = false
                        end
                    end)
        
                    Players.PlayerRemoving:Connect(function()
                        ESP.Visible = false
                    end)
                end
            end)
        end)
    end
    
    if _G.DefaultSettings == true then
        _G.TeamCheck = false
        _G.ESPVisible = true
        _G.TextColor = Color3.fromRGB(40, 90, 255)
        _G.TextSize = 14
        _G.Center = true
        _G.Outline = false
        _G.OutlineColor = Color3.fromRGB(0, 0, 0)
        _G.DisableKey = Enum.KeyCode.Q
        _G.TextTransparency = 0.75
    end
    
    UserInputService.TextBoxFocused:Connect(function()
        Typing = true
    end)
    
    UserInputService.TextBoxFocusReleased:Connect(function()
        Typing = false
    end)
    
    UserInputService.InputBegan:Connect(function(Input)
        if Input.KeyCode == _G.DisableKey and Typing == false then
            _G.ESPVisible = not _G.ESPVisible
            
            if _G.SendNotifications == true then
                game:GetService("StarterGui"):SetCore("SendNotification",{
                    Title = "ESP";
                    Text = "The ESP's visibility is now set to "..tostring(_G.ESPVisible)..".";
                    Duration = 5;
                })
            end
        end
    end)
    
    local Success, Errored = pcall(function()
        CreateESP()
    end)
    
    if Success and not Errored then
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "ESP";
                Text = "ESP script has successfully loaded.";
                Duration = 5;
            })
        end
    elseif Errored and not Success then
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "ESP";
                Text = "ESP script has errored while loading, please check the developer console! (F9)";
                Duration = 5;
            })
        end
        TestService:Message("The ESP script has errored, please notify Exunys with the following information :")
        warn(Errored)
        print("!! IF THE ERROR IS A FALSE POSITIVE (says that a player cannot be found) THEN DO NOT BOTHER !!")
    end
end)

visualsSection:addToggle("Display Health", nil, function(value)
   local UI = Instance.new("ScreenGui")
   local UIFrame = Instance.new("Frame")
   local imiecredits = Instance.new("TextLabel")
   
   UI.Name = "HEALTHBAAAR"
   UI.Parent = game.CoreGui
   UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   UI.Enabled = false

   UIFrame.Name = "HealthFrame"
   UIFrame.Parent = UI
   UIFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
   UIFrame.BorderSizePixel = 0
   UIFrame.Position = UDim2.new(0.212884605, 0, 0.190036908, 0)
   UIFrame.Size = UDim2.new(0, 605, 0, 336)
   UIFrame.BackgroundTransparency = 1

   imiecredits.Name = "health"
   imiecredits.Parent = UIFrame
   imiecredits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   imiecredits.BackgroundTransparency = 1.000
   imiecredits.BorderSizePixel = 0
   imiecredits.Position = UDim2.new(0.0507245474, 0, 0.854166687, 0)
   imiecredits.Size = UDim2.new(0, 137, 0, 48)
   imiecredits.Font = Enum.Font.GothamBold
   imiecredits.Text = Client.Character.Humanoid.Health
   imiecredits.TextColor3 = Color3.fromRGB(255, 255, 255)
   imiecredits.TextSize = 14.000
   imiecredits.TextXAlignment = Enum.TextXAlignment.Left
   imiecredits.TextYAlignment = Enum.TextYAlignment.Top

   if value then
     UI.Enabled = true
   else
     imiecredits.Text = " "
   end
end)

visualsSection:addToggle("Show UI", nil, function(state)
   if state then
      game.Players.LocalPlayer:WaitForChild("PlayerGui").GUI.Enabled = false
   else
     game.Players.LocalPlayer:WaitForChild("PlayerGui").GUI.Enabled = true
   end
end)

local InfAmmoToggle = miscWeaponsSection:addToggle("Infinite Ammo", nil, function(State)
    Settings.Infinite = State
    RunService.Stepped:connect(
        function()
            pcall(
                function()
                    if Settings.Infinite then
                        Player.PlayerGui.GUI.Client.Variables.ammocount.Value = 999
                        Player.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
                    end
                end
            )
        end
    )
    end)

playerSection:addToggle("X To Fly", nil, function(val)
    local Max = 0
    local Players = Players
    local LP = Player
    local Mouse = LP:GetMouse()
    Mouse.KeyDown:connect(
        function(k)
            if k:lower() == "x" then
                Max = Max + 1
                getgenv().Fly = false
                if val then
                    local T = LP.Character.UpperTorso
                    local S = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0
                    }
                    local S2 = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0
                    }
                    local SPEED = 5
                    local function FLY()
                        getgenv().Fly = true
                        local BodyGyro = Instance.new("BodyGyro", T)
                        local BodyVelocity = Instance.new("BodyVelocity", T)
                        BodyGyro.P = 9e4
                        BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                        BodyGyro.cframe = T.CFrame
                        BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                        BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
                        spawn(
                            function()
                                repeat
                                    wait()
                                    LP.Character.Humanoid.PlatformStand = false
                                    if S.L + S.R ~= 0 or S.F + S.B ~= 0 then
                                        SPEED = 200
                                    elseif not (S.L + S.R ~= 0 or S.F + S.B ~= 0) and SPEED ~= 0 then
                                        SPEED = 0
                                    end
                                    if (S.L + S.R) ~= 0 or (S.F + S.B) ~= 0 then
                                        BodyVelocity.velocity =
                                            ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (S.F + S.B)) +
                                            ((Workspace.CurrentCamera.CoordinateFrame *
                                                CFrame.new(S.L + S.R, (S.F + S.B) * 0.2, 0).p) -
                                                Workspace.CurrentCamera.CoordinateFrame.p)) *
                                            SPEED
                                        S2 = {
                                            F = S.F,
                                            B = S.B,
                                            L = S.L,
                                            R = S.R
                                        }
                                    elseif (S.L + S.R) == 0 and (S.F + S.B) == 0 and SPEED ~= 0 then
                                        BodyVelocity.velocity =
                                            ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (S2.F + S2.B)) +
                                            ((Workspace.CurrentCamera.CoordinateFrame *
                                                CFrame.new(S2.L + S2.R, (S2.F + S2.B) * 0.2, 0).p) -
                                                Workspace.CurrentCamera.CoordinateFrame.p)) *
                                            SPEED
                                    else
                                        BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                                    end
                                    BodyGyro.cframe = Workspace.CurrentCamera.CoordinateFrame
                                until not getgenv().Fly
                                S = {
                                    F = 0,
                                    B = 0,
                                    L = 0,
                                    R = 0
                                }
                                S2 = {
                                    F = 0,
                                    B = 0,
                                    L = 0,
                                    R = 0
                                }
                                SPEED = 0
                                BodyGyro:destroy()
                                BodyVelocity:destroy()
                                LP.Character.Humanoid.PlatformStand = false
                            end
                        )
                    end
                    Mouse.KeyDown:connect(
                        function(k)
                            if k:lower() == "w" then
                                S.F = 1
                            elseif k:lower() == "s" then
                                S.B = -1
                            elseif k:lower() == "a" then
                                S.L = -1
                            elseif k:lower() == "d" then
                                S.R = 1
                            end
                        end
                    )
                    Mouse.KeyUp:connect(
                        function(k)
                            if k:lower() == "w" then
                                S.F = 0
                            elseif k:lower() == "s" then
                                S.B = 0
                            elseif k:lower() == "a" then
                                S.L = 0
                            elseif k:lower() == "d" then
                                S.R = 0
                            end
                        end
                    )
                    FLY()
                    if Max == 2 then
                        getgenv().Fly = false
                        Max = 0
                    end
                end
            end
        end
    )
end)

local ToggleAAAOOO = playerSection:addToggle("N To Noclip", nil, function(State)
    noclips = false
    Player:GetMouse().KeyDown:connect(
        function(v)
            if v == "n" then
                if State then
                    noclips = not noclips
                    for i, v in pairs(Player.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            pcall(function()
                            v.CanCollide = false
                            end)
                        end
                    end
                end
            else
                v.CanCollide = true
            end
        end
    )
    RunService.Stepped:connect(
        function()
            if noclips then
                for i, v in pairs(Player.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        pcall(function()
                        v.CanCollide = false
                        end)
                    end
                end
            end
        end
    )
    
    end)
    
    local triggerBotButton = aimbotSection:addToggle("Trigger Bot", nil, function(value)
        triggerBoton = value
        local Mouse = LocalPlayer:GetMouse()
        pcall(function()
            RunService.RenderStepped:Connect(function()
                if triggerBoton then
                    if Mouse.target ~= nil then
                        if Mouse.target.Parent.Name == "Gun" or Mouse.target.Parent.Name == "scruc" then
                            if Mouse.target.Parent.Parent:FindFirstChild("Humanoid") and Mouse.target.Parent.Parent:FindFirstChild("Hitbox") and Players:FindFirstChild(Mouse.target.Parent.Parent.Name).Status.Alive.Value == true and not isSameTeam(LocalPlayer, Players:FindFirstChild(Mouse.target.Parent.Parent.Name)) then
                               mouse1press()
                               wait()
                               mouse1release()
                            end
                        else
                           if Mouse.target.Parent:FindFirstChild("Humanoid") and Mouse.target.Parent:FindFirstChild("Hitbox") and Players:FindFirstChild(Mouse.target.Parent.Name).Status.Alive.Value == true and not isSameTeam(LocalPlayer, Players:FindFirstChild(Mouse.target.Parent.Name)) then
                               mouse1press()
                               wait()
                               mouse1release()
                            end
                        end
                    end
                end
            end)
        end)
    end)

    aimbotSection:addDropdown("Aim Part", {"Head", "Torso"}, function()
        aimbotPart = value
        if aimbotPart == "Torso" then
            aimbotPart = "HumanoidRootPart"
        else
            aimbotPart = "Head"
        end
    end)
