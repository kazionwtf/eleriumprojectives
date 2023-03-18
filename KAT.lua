if game.PlaceId == 621129760 then
      game:GetService("Players").LocalPlayer.Idled:connect(function()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(...)
    local Args = {...}
    local Self = Args[1]
    if getnamecallmethod()=="FireServer" and tostring(Self)=="Utility" then
            return wait(math.huge)
    end
    return OldNameCall(...)
end)

local Circle = Drawing.new("Circle")
Circle.Color =  Color3.fromRGB(22, 13, 56)
Circle.Thickness = 1
Circle.Radius = 250
Circle.Visible = false
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1

game:GetService("RunService").RenderStepped:Connect(function()
    local Mouse = game:GetService("UserInputService"):GetMouseLocation()
    Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
end)
getgenv().AimBot = {
WallCheck = false,
Enabled = false,
FOV = 250,
Smoothness = 0.05
}



local Shoot = false


function NotObstructing(i, v)
    if getgenv().AimBot.WallCheck then
        c = workspace.CurrentCamera.CFrame.p
        a = Ray.new(c, i- c)
        f = workspace:FindPartOnRayWithIgnoreList(a, v)
        return f == nil
    else
        return true
    end
end
game:GetService("UserInputService").InputBegan:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        Shoot = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        Shoot = false
    end
end)

function GetMouse()
    return Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y)
end
function GetClosestToCuror()
    MousePos = GetMouse()
    Closest = math.huge
    Target = nil
    for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0  then
                Point,OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen and NotObstructing(v.Character.HumanoidRootPart.Position,{game.Players.LocalPlayer.Character,v.Character}) then
                    Distance = (Vector2.new(Point.X,Point.Y) - MousePos).magnitude
                      if Distance <= getgenv().AimBot.FOV then
                          Closest = Distance
                       Target = v
                     end
               end
            end
         end
    return Target
end 

game:GetService("RunService").RenderStepped:Connect(
    function()
        if getgenv().AimBot.Enabled == false or Shoot == false then
            return
        end
        ClosestPlayer = GetClosestToCuror()
        if ClosestPlayer and getgenv().Method == "FirstPerson" then
           workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p,ClosestPlayer.Character.HumanoidRootPart.CFrame.p)
        end
        if ClosestPlayer and getgenv().Method == "ThirdPerson" then
            local Mouse = game.Players.LocalPlayer:GetMouse()
            local TargetPos = game.workspace.Camera:WorldToViewportPoint(ClosestPlayer.Character.HumanoidRootPart.Position)
            mousemoverel(
                (TargetPos.X - Mouse.X) * getgenv().AimBot.Smoothness,
                (TargetPos.Y - Mouse.Y) * getgenv().AimBot.Smoothness
            )
        end
    end
)

   local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Elerium Hub V4 - KAT", 5013109572)
local HttpService = game:GetService("HttpService")
local aimPage = venyx:addPage("Botting", 5012544693)
local silentAimSection = aimPage:addSection("LegitBot")
local aimpart = "Head"
local worldPage = venyx:addPage("World", 5012544693)
local World = worldPage:addSection("World")
game.CoreGui["Elerium Hub V4 - KAT"]:Destroy()
silentAimSection:addDropdown("Aim Part", {"Head", "Torso"}, function(v)
    if v == "Torso" then
       aimpart = "HumanoidRootPart"
      else
         aimpart = "Head"  
    end
end)

  local Name = "KAT.txt"

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


silentAimSection:addButton("Silent aim", function()
    getgenv().silentaim_settings = {
   fov = 150,
   hitbox = aimpart,
   fovcircle = true,
}
-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Player
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local CurrentCamera = workspace.CurrentCamera

local function GetClosest(Fov)
   local Target, Closest = nil, Fov or math.huge

   for i,v in pairs(Players:GetPlayers()) do
       if (v.Character and v ~= Player and v.Character:FindFirstChild(getgenv().silentaim_settings.hitbox)) then
           local Position, OnScreen = CurrentCamera:WorldToScreenPoint(v.Character[getgenv().silentaim_settings.hitbox].Position)
           local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude

           if (Distance < Closest and OnScreen) then
               Closest = Distance
               Target = v
           end
       end
   end
   
   return Target
end

local Target
local CircleInline = Drawing.new("Circle")
local CircleOutline = Drawing.new("Circle")
RunService.Stepped:Connect(function()
   CircleInline.Radius = getgenv().silentaim_settings.fov
   CircleInline.Thickness = 2
   CircleInline.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
   CircleInline.Transparency = 1
   CircleInline.Color = Color3.fromRGB(255, 255, 255)
   CircleInline.Visible = getgenv().silentaim_settings.fovcircle
   CircleInline.ZIndex = 2

   CircleOutline.Radius = getgenv().silentaim_settings.fov
   CircleOutline.Thickness = 4
   CircleOutline.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
   CircleOutline.Transparency = 1
   CircleOutline.Color = Color3.new()
   CircleOutline.Visible = getgenv().silentaim_settings.fovcircle
   CircleOutline.ZIndex = 1

   Target = GetClosest(getgenv().silentaim_settings.fov)
end)

local Old; Old = hookmetamethod(game, "__namecall", function(Self, ...)
   local Args = {...}

   if (not checkcaller() and getnamecallmethod() == "FindPartOnRayWithIgnoreList") then
       if (table.find(Args[2], workspace.WorldIgnore.Ignore) and Target and Target.Character) then
           local Origin = Args[1].Origin

           Args[1] = Ray.new(Origin, Target.Character[getgenv().silentaim_settings.hitbox].Position - Origin)
       end
   end

   return Old(Self, unpack(Args))
end)

end)

silentAimSection:addToggle("Show FOV", nil, function(v)
    v = true
   getgenv().silentaim_settings.fovcircle = v
end)

silentAimSection:addToggle("Auto Sprint", nil, function(s)
game:GetService("RunService").Stepped:Connect(
    function()
        if state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 25
              else
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 15
        end
    end
)

end)
World:addToggle("FullBright", nil, function(State)
FullBright = State
        if FullBright then
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
        else
            game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
            game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
        end
game.Lighting.Changed:connect(
    function()
        if FullBright then
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
        else
            game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
            game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
        end
    end
)
end)
silentAimSection:addToggle("Aimbot", nil, function(State)
    getgenv().AimBot.Enabled = State
end)



silentAimSection:addToggle("WallCheck", nil, function(State)
    getgenv().AimBot.WallCheck = State
end)

silentAimSection:addToggle("Silent aim V1", nil, function(State)
getgenv().SilentAim = State

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayerToCurser()
    local MaxDistance, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v ~= LocalPlayer  and v.Character then
            local H = v.Character.FindFirstChild(v.Character, "Head")
            if H then 
                local Pos, Vis = workspace.CurrentCamera.WorldToScreenPoint(workspace.CurrentCamera, H.Position)
                if Vis then
                    local A1, A2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                    local Dist = (A2 - A1).Magnitude
                    if Dist < MaxDistance and Dist <= math.huge then
                        MaxDistance = Dist
                        Closest = v
                    end
                end
            end
        end
    end
    return Closest
end

for Fuck, You in next,getgc() do
   if getfenv(You).script == game.Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper and typeof(You) == "function" and getgenv().SilentAim then
       for Ass, Head in next, getconstants(You) do
           if tonumber(Head) == 0.25 then
               setconstant(You,Ass,0)
           elseif tonumber(Head) == 0 then
               setconstant(You,Ass,0.25)
           end
       end
   end
end 
end)

if game.PlaceId == 621129760 then
      game:GetService("Players").LocalPlayer.Idled:connect(function()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(...)
    local Args = {...}
    local Self = Args[1]
    if getnamecallmethod()=="FireServer" and tostring(Self)=="Utility" then
            return wait(math.huge)
    end
    return OldNameCall(...)
end)

local Circle = Drawing.new("Circle")
Circle.Color =  Color3.fromRGB(22, 13, 56)
Circle.Thickness = 1
Circle.Radius = 250
Circle.Visible = false
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1

game:GetService("RunService").RenderStepped:Connect(function()
    local Mouse = game:GetService("UserInputService"):GetMouseLocation()
    Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
end)
getgenv().AimBot = {
WallCheck = false,
Enabled = false,
FOV = 250,
Smoothness = 0.05
}



local Shoot = false


function NotObstructing(i, v)
    if getgenv().AimBot.WallCheck then
        c = workspace.CurrentCamera.CFrame.p
        a = Ray.new(c, i- c)
        f = workspace:FindPartOnRayWithIgnoreList(a, v)
        return f == nil
    else
        return true
    end
end
game:GetService("UserInputService").InputBegan:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        Shoot = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        Shoot = false
    end
end)

function GetMouse()
    return Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y)
end
function GetClosestToCuror()
    MousePos = GetMouse()
    Closest = math.huge
    Target = nil
    for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0  then
                Point,OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen and NotObstructing(v.Character.HumanoidRootPart.Position,{game.Players.LocalPlayer.Character,v.Character}) then
                    Distance = (Vector2.new(Point.X,Point.Y) - MousePos).magnitude
                      if Distance <= getgenv().AimBot.FOV then
                          Closest = Distance
                       Target = v
                     end
               end
            end
         end
    return Target
end 

game:GetService("RunService").RenderStepped:Connect(
    function()
        if getgenv().AimBot.Enabled == false or Shoot == false then
            return
        end
        ClosestPlayer = GetClosestToCuror()
        if ClosestPlayer and getgenv().Method == "FirstPerson" then
           workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p,ClosestPlayer.Character.HumanoidRootPart.CFrame.p)
        end
        if ClosestPlayer and getgenv().Method == "ThirdPerson" then
            local Mouse = game.Players.LocalPlayer:GetMouse()
            local TargetPos = game.workspace.Camera:WorldToViewportPoint(ClosestPlayer.Character.HumanoidRootPart.Position)
            mousemoverel(
                (TargetPos.X - Mouse.X) * getgenv().AimBot.Smoothness,
                (TargetPos.Y - Mouse.Y) * getgenv().AimBot.Smoothness
            )
        end
    end
)

   local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Elerium Hub V4 - KAT", 5013109572)
local aimPage = venyx:addPage("Botting", 5012544693)
local silentAimSection = aimPage:addSection("LegitBot")
local aimpart = "Head"
local worldPage = venyx:addPage("World", 5012544693)
local World = worldPage:addSection("World")

silentAimSection:addDropdown("Aim Part", {"Head", "Torso"}, function(v)
    if v == "Torso" then
       aimpart = "HumanoidRootPart"
      else
         aimpart = aimpart   
    end
end)

      
silentAimSection:addButton("Silent aim", function()
    getgenv().silentaim_settings = {
   fov = 150,
   hitbox = aimpart,
   fovcircle = true,
}
-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Player
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local CurrentCamera = workspace.CurrentCamera

local function GetClosest(Fov)
   local Target, Closest = nil, Fov or math.huge

   for i,v in pairs(Players:GetPlayers()) do
       if (v.Character and v ~= Player and v.Character:FindFirstChild(getgenv().silentaim_settings.hitbox)) then
           local Position, OnScreen = CurrentCamera:WorldToScreenPoint(v.Character[getgenv().silentaim_settings.hitbox].Position)
           local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude

           if (Distance < Closest and OnScreen) then
               Closest = Distance
               Target = v
           end
       end
   end
   
   return Target
end

local Target
local CircleInline = Drawing.new("Circle")
local CircleOutline = Drawing.new("Circle")
RunService.Stepped:Connect(function()
   CircleInline.Radius = getgenv().silentaim_settings.fov
   CircleInline.Thickness = 2
   CircleInline.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
   CircleInline.Transparency = 1
   CircleInline.Color = Color3.fromRGB(255, 255, 255)
   CircleInline.Visible = getgenv().silentaim_settings.fovcircle
   CircleInline.ZIndex = 2

   CircleOutline.Radius = getgenv().silentaim_settings.fov
   CircleOutline.Thickness = 4
   CircleOutline.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
   CircleOutline.Transparency = 1
   CircleOutline.Color = Color3.new()
   CircleOutline.Visible = getgenv().silentaim_settings.fovcircle
   CircleOutline.ZIndex = 1

   Target = GetClosest(getgenv().silentaim_settings.fov)
end)

local Old; Old = hookmetamethod(game, "__namecall", function(Self, ...)
   local Args = {...}

   if (not checkcaller() and getnamecallmethod() == "FindPartOnRayWithIgnoreList") then
       if (table.find(Args[2], workspace.WorldIgnore.Ignore) and Target and Target.Character) then
           local Origin = Args[1].Origin

           Args[1] = Ray.new(Origin, Target.Character[getgenv().silentaim_settings.hitbox].Position - Origin)
       end
   end

   return Old(Self, unpack(Args))
end)

end)

silentAimSection:addToggle("Show FOV", nil, function(v)
   getgenv().silentaim_settings.fovcircle = v
end)

silentAimSection:addToggle("Auto Sprint", nil, function(s)
game:GetService("RunService").Stepped:Connect(
    function()
        if state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 25
              else
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 15
        end
    end
)

end)
World:addToggle("FullBright", nil, function(State)
FullBright = State
        if FullBright then
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
        else
            game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
            game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
        end
game.Lighting.Changed:connect(
    function()
        if FullBright then
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
        else
            game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
            game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
        end
    end
)
end)
silentAimSection:addToggle("Aimbot", nil, function(State)
    getgenv().AimBot.Enabled = State
end)



silentAimSection:addToggle("WallCheck", nil, function(State)
    getgenv().AimBot.WallCheck = State
end)

silentAimSection:addToggle("Silent aim V1", nil, function(State)
getgenv().SilentAim = State

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayerToCurser()
    local MaxDistance, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v ~= LocalPlayer  and v.Character then
            local H = v.Character.FindFirstChild(v.Character, "Head")
            if H then 
                local Pos, Vis = workspace.CurrentCamera.WorldToScreenPoint(workspace.CurrentCamera, H.Position)
                if Vis then
                    local A1, A2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                    local Dist = (A2 - A1).Magnitude
                    if Dist < MaxDistance and Dist <= math.huge then
                        MaxDistance = Dist
                        Closest = v
                    end
                end
            end
        end
    end
    return Closest
end

for Fuck, You in next,getgc() do
   if getfenv(You).script == game.Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper and typeof(You) == "function" and getgenv().SilentAim then
       for Ass, Head in next, getconstants(You) do
           if tonumber(Head) == 0.25 then
               setconstant(You,Ass,0)
           elseif tonumber(Head) == 0 then
               setconstant(You,Ass,0.25)
           end
       end
   end
end 
end)

World:addToggle("AutoFarm", nil, function(state) 
getgenv().Sex = State
game:GetService("RunService").Stepped:connect(
    function()
        pcall(
            function()
                if state then
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                    for _, v in pairs(game.Players:GetChildren()) do
                        if v ~= game.Players.LocalPlayer then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                game:GetService("Workspace").Spawn.DefaultSpawns.SpawnPoint.CFrame
                            v.Character.HumanoidRootPart.CFrame =
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                            if game:GetService("Workspace").Gamemode.Value == "Classic" then
                                game:GetService("VirtualUser"):ClickButton1(Vector2.new(125, 125))
                                for _, x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if x.Name == "Knife" then
                                        x.Parent = game.Players.LocalPlayer.Character
                                    end
                                end
                            end
                        end
                    end
                end
                if game.workspace.Gamemode.Value == "Murder" then
                    game:GetService("Workspace").MapMain.OUTDATED:FindFirstChild("Crate").CFrame =
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        )
    end
)
end)
        
World:addButton("Anti Lag", function()
for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then 
        v.Material = Enum.Material.SmoothPlastic
        if v:IsA("Texture") then
            v:Destroy()
        end
    end
end

end)



World:addKeybind("Toggle UI Keybind", Enum.KeyCode.Z, function() 
  venyx:toggle()
end, 
function(value) toggleUIKey = value end)

World:addButton("ServerHop", function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

-- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.
Teleport() 
end)
        
end
  else
    print("a") 
end
