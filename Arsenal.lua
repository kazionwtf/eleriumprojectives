
--[[
  ______ _      ______ _____  _____ _    _ __  __ 
 |  ____| |    |  ____|  __ \|_   _| |  | |  \/  | 
 | |__  | |    | |__  | |__) | | | | |  | | \  / |
 |  __| | |    |  __| |  _  /  | | | |  | | |\/| |
 | |____| |____| |____| | \ \ _| |_| |__| | |  | |
 |______|______|______|_|  \_\_____|\____/|_|  |_|     
]]

if game.PlaceId == 286090429 then
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Elerium Hub V4 - Arsenal", 5013109572)
local Client = game.Players.LocalPlayer
local aimPage = venyx:addPage("Aimbot", 5012544693)
local aimbotSection = aimPage:addSection("Aimbot")
local miscWeaponsSection = venyx:addPage("Gun Mods", 5013109572)
local miscWeaponsSectionE = miscWeaponsSection:addSection("Gun Mods")
local infosec = venyx:addPage("UI Info", 5012544693)
local infosecsec = infosec:addSection("Toggle")
local playerPage = venyx:addPage("Player Mods", 5012544693)
local playerSection = playerPage:addSection("Player Mods")
local visualsPage = venyx:addPage("Visuals", 5013109572)
local visualsSection = visualsPage:addSection("ESP")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local aimbotPart = "HumanoidRootPart"
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
local creditsSection = creditsPage:addSection("Scripting by zksg#8178")


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


getgenv().Circle = Drawing.new("Circle")
Circle.Color = Color3.fromRGB(22, 13, 56)
Circle.Thickness = 1
Circle.Radius = 250
Circle.Visible = false 
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1

RunService.RenderStepped:Connect(
    function()
        local Mouse = UserInputService:GetMouseLocation()
        Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
    end
)

Settings.Aimbot = {
    FreeForAll = false,
    WallCheck = false,
    Enabled = false,
    FOV = 250
}
local Shoot = false

function FreeForAll(v)
    if Settings.Aimbot.FreeForAll == false or Settings.T.FreeForAll == false then
        if Player.Team == v.Team then
            return false
        else
            return true
        end
    else
        return true
    end
end

function NotObstructing(i, v)
    if Settings.Aimbot.WallCheck then
        c = Workspace.CurrentCamera.CFrame.p
        a = Ray.new(c, i - c)
        f = Workspace:FindPartOnRayWithIgnoreList(a, v)
        return f == nil
    else
        return true
    end
end
UserInputService.InputBegan:Connect(
    function(v)
        if v.UserInputType == Enum.UserInputType.MouseButton2 then
            Shoot = true
        end
    end
)

UserInputService.InputEnded:Connect(
    function(v)
        if v.UserInputType == Enum.UserInputType.MouseButton2 then
            Shoot = false
        end
    end
)

function GetClosestToCuror()
    Closest = math.huge
    Target = nil
    for _, v in pairs(Players:GetPlayers()) do
        if FreeForAll(v) then
            if
                v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and
                    v.Character:FindFirstChild("Humanoid") and
                    v.Character.Humanoid.Health ~= 0
             then
                Point, OnScreen = Workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if
                    OnScreen and
                        NotObstructing(
                            v.Character.HumanoidRootPart.Position,
                            {Player.Character, v.Character}
                        )
                 then
                    Distance =
                        (Vector2.new(Point.X, Point.Y) -
                        Vector2.new(Player:GetMouse().X, Player:GetMouse().Y)).magnitude
                    if Distance <= Settings.Aimbot.FOV then
                        Closest = Distance
                        Target = v
                    end
                end
            end
        end
    end
    return Target
end

RunService.Stepped:connect(
    function()
        pcall(
            function()
                if Settings.Aimbot.Enabled == false or Shoot == false then
                    return
                end
                ClosestPlayer = GetClosestToCuror()
                if ClosestPlayer then
                    Workspace.CurrentCamera.CFrame =
                        CFrame.new(Workspace.CurrentCamera.CFrame.p, ClosestPlayer.Character[Settings.AimPart].CFrame.p)
                end
            end
        )
    end
)
Settings.T = {
    TeamCheck = false,
    Delay = 0.01,
    Enabled = false
}

local Aim = false
UserInputService.InputBegan:connect(
    function(v)
        if v.UserInputType == Enum.UserInputType.MouseButton2 and Settings.T.Enabled then
            Aim = true
            while Aim do
                wait()
                if
                    Player:GetMouse().Target and
                        Players:FindFirstChild(
                            Player:GetMouse().Target.Parent.Name
                        )
                 then
                    local Person =
                        Players:FindFirstChild(
                        Player:GetMouse().Target.Parent.Name
                    )
                    if Person.Team ~= Player.Team or not Settings.T.TeamCheck then
                        if Settings.T.Delay > 0 then
                            wait(0.01)
                        end
                        mouse1press()
                        wait()
                        mouse1release()
                    end
                end
                if not Settings.T.Enabled then
                    break
                end
            end
        end
    end
)

UserInputService.InputEnded:connect(
    function(v)
        if v.KeyCode == Enum.UserInputType.MouseButton2 and Settings.T.Enabled then
            Aim = false
        end
    end
)


playerSection:addButton("Anti Lag", function()
for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then 
        v.Material = Enum.Material.SmoothPlastic
        if v:IsA("Texture") then
            v:Destroy()
        end
    end
end

end)
  
miscWeaponsSectionE:addToggle("FastFire Rate", nil, function(State)
for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
    if v.Name == "FireRate" then
        if State then
            v.Value = 0.02 -- Fast Firerate
        else
            v.Value = 0.8
        end
    end
end
end)

miscWeaponsSectionE:addToggle("Always Auto", nil, function(State)
for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
    if v.Name == "Auto" then
        if State then
            v.Value = true -- always auto
        else
            v.Value = false
        end
    end
end
end)


local Toggle1 = aimbotSection:addToggle("Team Check", nil, function(State)
    if State then
       tc = true
        Settings.T.TeamCheck = true
      else
        tc = false
        Settings.T.TeamCheck = false
    end
end)
  
local Toggle1 = aimbotSection:addToggle("Trigger Bot", nil, function(State)
    if State then
       Settings.T.Enabled = true
        Settings.T.TeamCheck = true
      else
        Settings.T.Enabled = false 
        Settings.T.TeamCheck = false
    end
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

aimbotSection:addButton("Aimbot", function()
      local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local GuiService = game:GetService("GuiService")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local Camera = workspace.CurrentCamera
    local sc = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    local Down = true
    local Inset = GuiService:GetGuiInset()
    
    --// Options \\--
       Options = {
        Enabled = aimbot,
        TeamCheck = true,
        Triggerbot = true,
        Smoothness = true,
        AimPart = "Head",
        FOV = 150
	}
	getgenv().Options = Options
    --// Functions \\--
    local gc = function()
        local nearest = math.huge
        local nearplr
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game:GetService("Players").LocalPlayer and v.Character and v.Character:FindFirstChild(Options.AimPart) then
                if Options.TeamCheck then
                    if game:GetService("Players").LocalPlayer.Team ~= v.Team then
                        local pos = Camera:WorldToScreenPoint(v.Character[Options.AimPart].Position)
                        local diff = math.sqrt((pos.X - sc.X) ^ 2 + (pos.Y + Inset.Y - sc.Y) ^ 2)
                        if diff < nearest and diff < Options.FOV then
                            nearest = diff
                            nearplr = v
                        end
                    end
                else
                    local pos = Camera:WorldToScreenPoint(v.Character[Options.AimPart].Position)
                    local diff = math.sqrt((pos.X - sc.X) ^ 2 + (pos.Y + Inset.Y - sc.Y) ^ 2)
                    if diff < nearest and diff < Options.FOV then
                        nearest = diff
                        nearplr = v
                    end
                end
            end
        end
        return nearplr
    end -- google chrome made this but i modified it for it to use teamcheck
    
    function Circle()
        local circ = Drawing.new('Circle')
        circ.Transparency = 1
        circ.Thickness = 1.5
        circ.Visible = false
        circ.Color = Color3.fromRGB(255,255,255)
        circ.Filled = false
        circ.NumSides = 150
        circ.Radius = Options.FOV
        return circ
    end
    curc = Circle()
    --// Main \\--
    UserInputService.InputBegan:Connect(function( input )
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            Down = true
        end
    end)
    UserInputService.InputEnded:Connect(function( input )
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            Down = false
        end
    end)
    RunService.RenderStepped:Connect(function( ... )
        if Options.Enabled then
            if Down then
                if gc() ~= nil and gc().Character:FindFirstChild(Options.AimPart) then
                    if Options.Smoothness then
                        pcall(function( ... )
                            local Info = TweenInfo.new(0.05,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
                            game:GetService("TweenService"):Create(Camera,Info,{
                                CFrame = CFrame.new(Camera.CFrame.p,gc().Character[Options.AimPart].CFrame.p)
                            }):Play()
                        end)
                    else
                        pcall(function()
                            Camera.CFrame = CFrame.new(Camera.CFrame.p,gc().Character[Options.AimPart].CFrame.p)
                        end)
                    end
                end
            end
            curc.Visible = false
            curc.Position = Vector2.new(Mouse.X, Mouse.Y+Inset.Y)
        else
            -- do nothing except remove the fov
            curc.Visible = false
        end
    end)
end)


aimbotSection:addToggle("Silent Aim", nil, function(State)
local Players = Players
local LocalPlayer = Player
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayerToCurser()
    local MaxDistance, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v ~= LocalPlayer and v.Team ~= LocalPlayer.Team and v.Character then
            local H = v.Character.FindFirstChild(v.Character, "Head")
            if H then 
                local Pos, Vis = Workspace.CurrentCamera.WorldToScreenPoint(Workspace.CurrentCamera, H.Position)
                if Vis then
                    local A1, A2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                    local Dist = (A2 - A1).Magnitude
                    if Dist < MaxDistance and Dist <= 2500 then
                        MaxDistance = Dist
                        Closest = v
                    end
                end
            end
        end
    end
    return Closest
end
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self,...)
    local Args = {...}
    if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() and State then
        local GivemeHead = ClosestPlayerToCurser()
        if GivemeHead and GivemeHead.Character and GivemeHead.Character.FindFirstChild(GivemeHead.Character, aimbotPart) then
            Args[1] = Ray.new(Workspace.CurrentCamera.CFrame.Position, (GivemeHead.Character[aimbotPart].Position - Workspace.CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNameCall(self, unpack(Args))
        end
    end
    return OldNameCall(self, ...)
end)
end)

local Toggle1 = playerSection:addToggle("Anti Aim", nil, function(State)
Settings.AntiAim = State
spawn(
    function()
        while wait(1) and State do
            getsenv(Player.PlayerGui.GUI.Client).lastlook = 10000
            if Player.Character then
                --remove legs
                for _, v in pairs(Player.Character:GetChildren()) do
                    if string.find(string.lower(v.Name), "foot") or string.find(string.lower(v.Name), "leg") then
                        if v:IsA("BasePart") then
                            v:Destroy()
                        end
                    end
                end

                if Player.Character:FindFirstChild("HeadHB") then
                    Player.Character:FindFirstChild("HeadHB"):Destroy()
                end
                if Player.Character:FindFirstChild("FakeHead") then
                    Player.Character:FindFirstChild("FakeHead"):Destroy()
                end
            end
        end

        local NewAnimation = Instance.new("Animation")
        NewAnimation.AnimationId = "rbxassetid://0"

        local OldNameCall = nil
        OldNameCall =
            hookmetamethod(
            game,
            "__namecall",
            function(A, B, C, ...)
                local Args = {...}
                local Self = Args[1]
                if getnamecallmethod() == "FireServer" and tostring(A) == "ControlTurn" then
                    B = math.rad(math.random(-360, 360))
                    C = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
                    Player.Character.HumanoidRootPart.CFrame =
                        CFrame.new(Player.Character.HumanoidRootPart.Position) *
                        CFrame.Angles(0, math.rad(math.random(-360, 360)), 0)
                elseif getnamecallmethod() == "LoadAnimation" and tostring(A) == "Humanoid" then
                    B = NewAnimation
                end
                return OldNameCall(A, B, C, ...)
            end
        )
        local OldNameCall = nil
        OldNameCall =
            hookmetamethod(
            game,
            "__namecall",
            function(A, B, C, ...)
                if tostring(A) == "Humanoid" and B == "AutoRotate" then
                    return oldnewIndex(A, B, false)
                end
                return oldnewIndex(A, B, C, ...)
            end
        )
    end
)

end)
if Settings.WalkSpeed == nil or Settings.JumpPower == nil then
Settings.WalkSpeed = 23 
Settings.JumpPower = 5
end  
playerSection:addToggle("Unlock WalkSpeed", nil, function(State)
    RunService.Stepped:connect(
    function()
        if State then
            Player.Character:WaitForChild("Humanoid").WalkSpeed = Settings.WalkSpeed
       	    if Player.Character:FindFirstChildOfClass('Humanoid').UseJumpPower then
			Player.Character:WaitForChild('Humanoid').JumpPower = Settings.JumpPower
		    else
			Player.Character:WaitForChild('Humanoid').JumpHeight  = Settings.JumpPower
			end 
            if not  UserInputService.WindowFocusReleased then
                pcall(function()
                setfpscap(240)
                end)
            end
        end
    end
)
end)
      
playerSection:addSlider("Set WalkSpeed", 23, 1, 999, function(callback)
    Settings.WalkSpeed = callback
end)
      
playerSection:addSlider("Set JumpPower", 5, 1, 999, function(callback)
    Settings.JumpPower = callback
end)

infosecsec:addKeybind("Toggle UI Keybind", Enum.KeyCode.V, function() 
  venyx:toggle()
end, 
function(value) toggleUIKey = value end)

miscWeaponsSectionE:addToggle("No Spread", nil, function(State)
for i, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
    if v.Name == "MaxSpread" or v.Name == "Spread" or v.Name == "RecoilControl" then
        if State then
            v.Value = 0 -- no spread or recoil
        else
            v.Value = 1
        end
    end
end
end)
      
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/EleriumESP.lua"))()

visualsSection:addToggle("ESP Enabled", nil, function(State)
   if State then
    ESP:Toggle(true)
     else
       ESP:Toggle(false)
   end
end)

visualsSection:addToggle("Players", nil, function(State)
    if State then
    ESP.Players = true
     else
       ESP.Players = false
   end
end)

visualsSection:addToggle("Tracers", Settings.Tracers, function(State)
    if State then
    ESP.Tracers = true
     else
       ESP.Tracers = false
   end
end)

visualsSection:addToggle("Names", nil, function(State)
   if State then
    ESP.Names = true
     else
       ESP.Names = false
   end
end)

visualsSection:addToggle("Boxes", nil, function(State)
    if State then
    ESP.Boxes = true
     else
       ESP.Boxes = false
   end
end)


local Toggle1 = playerSection:addToggle("Auto Heal", nil, function(State)
if State then
spawn(function()
while State do
    wait()
    pcall(
        function()
            for i, v in pairs(Workspace.Debris:GetChildren()) do
                if v.Name == "DeadHP" then
                    v.CFrame = Player.Character.HumanoidRootPart.CFrame
                end
            end
        end
    )
end
end)
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
					
   
for _, v in next, game:GetService("CoreGui"):GetChildren() do
    if (v.Name:match("HEALTHBAAAR")) then
        v:Destroy()
    end
end
					
   if value then
     UI.Enabled = true
   else
      UI.Enabled = false
   end
end)

visualsSection:addToggle("Show Statistics", nil, function(state)
   if state then
      game.Players.LocalPlayer:WaitForChild("PlayerGui").GUI.Enabled = false
   else
     game.Players.LocalPlayer:WaitForChild("PlayerGui").GUI.Enabled = true
   end
end)

local InfAmmoToggle = miscWeaponsSectionE:addToggle("Infinite Ammo", nil, function(State)
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
    

    aimbotSection:addDropdown("Aim Part", {"Head", "Torso"}, function(value)
        if value == "Torso" then
            getgenv().Options.AimPart = "HumanoidRootPart"
	    aimbotPart = "HumanoidRootPart"
        else
            getgenv().Options.AimPart = "Head"
	    aimbotPart = "Head"
        end
    end)
  else
   loadstring(game:HttpGet("https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/unsupportedgames.lua"))()
end
