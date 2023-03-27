local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
Player.PlayerGui:WaitForChild("MainGUI")
repeat
    wait()
until game:IsLoaded()
wait()
Player.Idled:connect(
    function()
        VirtualUser:ClickButton2(Vector2.new())
    end
)

local Name = "mm2.json"

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

repeat
    wait()
until Player.Character:FindFirstChild("HumanoidRootPart")

for i, v in pairs(Workspace:GetChildren()) do
    if v:IsA("BasePart") and v.Name ~= "Part" then
        v.CanCollide = false
    end
end

RunService.Stepped:connect(
    function()
        for i, v in pairs(ReplicatedStorage.Remotes.Extras.GetPlayerData:InvokeServer()) do
            if v.Role == "Murderer" then
                Settings.Murderer = i
            end
        end

        for i, v in pairs(ReplicatedStorage.Remotes.Extras.GetPlayerData:InvokeServer()) do
            if v.Role == "Sheriff" then
                Settings.Sheriff = i
            end
        end
    end
)

local KillAll = function(v)
    if Player.Character:FindFirstChild("Knife") then
        Player.Character.Knife.Throw:FireServer(
            CFrame.new(v.Character:GetModelCFrame().Position),
            v.Character:GetModelCFrame().Position - Vector3.new(0, 1, 0)
        )
    end
    if Player.Backpack:FindFirstChild("Knife") then
        Player.Backpack.Knife.Throw:FireServer(
            CFrame.new(v.Character:GetModelCFrame().Position),
            v.Character:GetModelCFrame().Position - Vector3.new(0, 1, 0)
        )
    end
end

local L = {}
function GodModeFunc()
    if Player.Character then
        if Player.Character:FindFirstChild("Humanoid") then
            for _, accessory in pairs(Player.Character.Humanoid:GetAccessories()) do
                table.insert(L, accessory:Clone())
            end
            Player.Character.Humanoid.Name = "1"
        end
        local l = Player.Character["1"]:Clone()
        l.Parent = Player.Character
        l.Name = "Humanoid"
        wait(0.1)
        Player.Character["1"]:Destroy()
        Workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid
        for _, accessory in pairs(L) do
            Player.Character.Humanoid:AddAccessory(accessory)
        end
        Player.Character.Animate.Disabled = true
        wait(0.1)
        Player.Character.Animate.Disabled = false
        --Tag:
        local Tag = Instance.new("BoolValue", Player.Character)
        Tag.Name = "GodMode"
        Tag.Value = true
        spawn(
            function()
                local Jumping = false
                local Died = false
                Player.Character.Humanoid.Died:connect(
                    function()
                        Died = true
                    end
                )
                UserInputService.InputBegan:connect(
                    function(i, v)
                        if not v and not Died then
                            Jumping = false
                            spawn(
                                function()
                                    repeat
                                        RunService.RenderStepped:Wait()
                                    until not Jumping or Died
                                end
                            )
                        else
                            repeat
                                RunService.RenderStepped:Wait()
                            until not Jumping
                        end
                    end
                )
                UserInputService.InputEnded:connect(
                    function(i, v)
                        if not v and not Died then
                            Jumping = false
                        end
                    end
                )
            end
        )
    end
end

function GetClosestCoin()
    local TargetDistance = 100
    local Target
    for i, v in pairs(Workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("CoinContainer") then
            for i, v in pairs(v.CoinContainer:GetChildren()) do
                if v.Name == "Coin_Server" and v.Name ~= "CollectedCoin" then
                    local mag = (Player.Character.HumanoidRootPart.Position - v.Position).magnitude
                    if mag < TargetDistance then
                        TargetDistance = mag
                        CoinTarget = v
                    end
                end
            end
        end
    end
end
spawn(
    function()
        while wait() do
            pcall(
                function()
                    if
                        Settings.Coin and Player.PlayerGui:WaitForChild("MainGUI").Game.CashBag.Visible and
                            not Player.PlayerGui:WaitForChild("MainGUI").Game.CashBag.Full.Visible and
                            Player.Character and
                            Player.Character:FindFirstChild("HumanoidRootPart")
                     then
                        AutoFarming = true
                        if Settings.GodMode and not Player.Character:FindFirstChild("GodMode") then
                            GodModeFunc()
                        end
                        GetClosestCoin()
                        if CoinTarget ~= nil then
                            spawn(
                                function()
                                    Player.Character.HumanoidRootPart.CFrame =
                                        CFrame.new(
                                        CoinTarget.Position.X,
                                        CoinTarget.Position.Y + 1.5,
                                        CoinTarget.Position.Z
                                       )
                                    wait()
                                    firetouchinterest(Player.Character.HumanoidRootPart, CoinTarget, 0)
                                    firetouchinterest(Player.Character.HumanoidRootPart, CoinTarget, 1)
                                end
                            )
                        end
                        if Player.Character:FindFirstChild("Knife") or Player.Backpack:FindFirstChild("Knife") then
                            for i, v in pairs(Players:GetPlayers()) do
                                if v ~= Player then
                                    KillAll(v)
                                end
                            end
                        end
                        wait(2)
                        CoinTarget = nil
                        AutoFarming = false
                    end
                end
            )
        end
    end
)


RunService.Stepped:connect(
    function()
        if Settings.Coin then
            pcall(
                function()
                    Player.Character.Humanoid:ChangeState(11)
                end
            )
        end
    end
)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/uilibrary.lua"))()
local venyx = library.new("Elerium Hub V4 - Murder Mystery 2", 5012544107)
local Page = venyx:addPage("Murderer", 5012544386)
local Section1 = Page:addSection("Murderer Functions")
local Page1 = venyx:addPage("Sheriff", 5012544386)
local Section2 = Page1:addSection("Sheriff Functions")
local Page2 = venyx:addPage("Functions", 5012544107)
local oSection = Page2:addSection("Functions")
local Toggle1 = Section1:CreateToggle("Murder Silent Aim", nil, function(State)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayerToCurser()
    local MaxDistance, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v ~= LocalPlayer and v.Character then
            local H = v.Character.FindFirstChild(v.Character, "Head")
            if H then 
                local Pos, Vis = Workspace.CurrentCamera.WorldToScreenPoint(Workspace.CurrentCamera, H.Position)
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
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self,...)
    local Args = {...}
    if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() and  State then
        local GivemeHead = ClosestPlayerToCurser()
        if GivemeHead and GivemeHead.Character and GivemeHead.Character.FindFirstChild(GivemeHead.Character, "UpperTorso") then
            Args[1] = Ray.new(Workspace.CurrentCamera.CFrame.Position, (GivemeHead.Character.UpperTorso.Position - Workspace.CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNameCall(self, unpack(Args))
        end
    end
    return OldNameCall(self, ...)
end)
end)

local Toggle1 = Section2:CreateToggle("Sheriff Silent Aim", nil, function(State)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayerToCurser()
    local MaxDistance, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v ~= LocalPlayer and v.Name == getgenv().Murder and v.Character then
            local H = v.Character.FindFirstChild(v.Character, "Head")
            if H then 
                local Pos, Vis = Workspace.CurrentCamera.WorldToScreenPoint(Workspace.CurrentCamera, H.Position)
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
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self,...)
    local Args = {...}
    if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() and  State  then
        local GivemeHead = ClosestPlayerToCurser()
        if GivemeHead and GivemeHead.Character and GivemeHead.Character.FindFirstChild(GivemeHead.Character, "UpperTorso") then
            Args[1] = Ray.new(Workspace.CurrentCamera.CFrame.Position, (GivemeHead.Character.UpperTorso.Position - Workspace.CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNameCall(self, unpack(Args))
        end
    end
    return OldNameCall(self, ...)
end)
end)

local Toggle1 = oSection:CreateToggle("AutoFarm", nil, function(State)
  if State then
      Settings.Coin = true
      else
      Settings.Coin = false
   end
end) 
  local Toggle1 = oSection:CreateToggle("GodMode AutoFarm", nil, function(State)
        if State then
          Settings.GodMode = true
          Settings.Coin = Settings.GodMode
          else
          Settings.GodMode = false
          Settings.Coin = Settings.GodMode
        end
end)

local Toggle1 = Section1:CreateToggle("KillAll", nil, function(State)
spawn(
    function()
        while wait() and State do
            pcall(
                function()
                    if Player.Character:FindFirstChild("Knife") or Player.Backpack:FindFirstChild("Knife") then
                        for i, v in pairs(Players:GetPlayers()) do
                            if v ~= Player then
                                KillAll(v)
                            end
                        end
                    end
                end
            )
        end
    end
)

end)
    
local Button1 = oSection:addButton("GodMode", function()
GodModeFunc()
end)
    
local Button1 = oSection:addButton("Floss", function()
ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("floss")
end)

local Button1 = oSection:addButton("Zen", function()
ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("zen")
end)

local Button1 = oSection:addButton("Sit", function()
ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("sit")
end)

local Button1 = oSection:addButton("Dab", function()
ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("dab")
end)

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/Karrot-Esp"))()
ESP.Overrides.GetColor = function(v)
    if v == Workspace[Settings.Murderer] then return Color3.fromRGB(255,0,0) end 
    if v ==  Workspace[Settings.Sheriff] then return Color3.fromRGB(0,0,255) end
    return Color3.fromRGB(0, 255, 0)
end


local Toggle1 = oSection:CreateToggle("ESP Enabled", nil, function(State)
    if State then
        ESP:Toggle(true)
       else
          ESP:Toggle(false)
    end
end)

local Toggle1 = oSection:CreateToggle("Player Esp", nil, function(State)
    if State then
       ESP.Players = true
        else
          ESP.Players = false
    end
end)
local Toggle1 = oSection:CreateToggle("Tracers Esp", nil, function(State)
    if State then
       ESP.Tracers = true
      else
         ESP.Tracers = false
    end
end)
local Toggle1 = oSection:CreateToggle("Name Esp", nil, function(State)
    if State then
         ESP.Names = true
       else
          ESP.Names = false
     end
end)
local Toggle1 = oSection:CreateToggle("Boxes Esp", nil, function(State)
    if State then
        ESP.Boxes = true
      else
         ESP.Boxes = false
    end
end)

