if game.PlaceId == 6284583030 then
local Players = gane.Players
local Workspace = game.Workspace
local RunService = game.RunService
local ReplicatedStorage = game.ReplicatedStorage
local HttpService = game.HttpService
local RunService = game.RunService
local Player = Players.LocalPlayer
local Coins = Workspace["__THINGS"].Coins
local wait = task.wait 
local spawn = task.spawn
repeat wait() until ReplicatedStorage:FindFirstChild("Library",true)
local Client = require(ReplicatedStorage.Library.Client)
local Frame = require(ReplicatedStorage:FindFirstChild("Framework"):FindFirstChild("Library"))
local Orbs = getsenv(Player.PlayerScripts:FindFirstChild("Orbs",true))
local Lootbags = getsenv(Player.PlayerScripts:FindFirstChild("Lootbags",true))
debug.setupvalue(Client.Network.Invoke, 1, function() return true end)
debug.setupvalue(Client.Network.Fire, 1, function() return true end)

local Name = "PetSimulatorX.json"

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
Frame.Signal.Fire("Fireworks Animation")


local function getNearestCoin()
    local TargetDistance = math.huge
    local Target
    for i, v in ipairs(Coins:GetChildren()) do
        if v:FindFirstChild("Coin") then
            local Mag =
                (Get.Players.LocalPlayer.Character.HumanoidRootPart.Position -
                v:FindFirstChild("Coin").Position).Magnitude
            if Mag < TargetDistance then
                TargetDistance = Mag
                Target = v
            end
        end
    end
    return Target
end

local Location = nil
local get_thread_identity = get_thread_context or getthreadcontext or getidentity or syn.get_thread_identity
local set_thread_identity = set_thread_context or setthreadcontext or setidentity or syn.set_thread_identity
for i,v in pairs(getgc()) do
    if type(v) == "function" and getinfo(v).name == "ActuallyTeleport" then
        Teleport = v 
        break
    end 
end 
Teleport2 = function(A)
    if A then
        local O = get_thread_identity()
        set_thread_identity(2)
        Teleport(A)
        set_thread_identity(O)
    end 
    return A 
end 

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Elerium Hub V4 - Pet Simulator X", 5013109572)
local Page = venyx:addPage("Main", 5012544693)
local Section1 = Page:addSection("PetSimX")


local Toggle1 = Section1:addToggle("AutoFarm", nil, function(State)
spawn(function()
    while wait(0.1) do
        pcall(function()
            if State then
            local Pets = Client.PetCmds.GetEquipped() 
                for K,O in pairs(Pets) do
                    Client.Network.Invoke('Join Coin', getNearestCoin().Name, {O.uid})
                    Client.Network.Fire('Farm Coin', getNearestCoin().Name, O.uid)
                    for i,v in pairs(Workspace["__THINGS"].Orbs:GetChildren()) do
                        v.CFrame = Player.Character:GetModelCFrame()
                    end 
                    for i,v in pairs(Workspace["__THINGS"].Lootbags:GetChildren()) do
                        v.CFrame = Player.Character:GetModelCFrame()
                    end
                end 
            else
                return Client.Network.Invoke("Redeem Rank Rewards"), Client.Network.Invoke("Redeem Free Gift", i), Frame.Signal.Fire("Fireworks Animation")
            end 
        end)
    end 
end)
end)

local Toggle1 = Section1:addToggle("Skip Hatch Egg Anamtion", nil, function(State)
for Index, Value in pairs(getgc(true)) do
    if (typeof(Value) == "table" and rawget(Value, "OpenEgg")) and State then
        Value.OpenEgg = function()
            return
        end
    end
    end
end)
  
local Toggle1 = Section1:addToggle("Infinite Jump", nil, function(State)
game:GetService("UserInputService").JumpRequest:connect(
    function()
        if State then
            Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end
)
end)

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/EleriumESP.lua"))()

Section1:addToggle("ESP Enabled", nil, function(State)
   if State then
    ESP:Toggle(true)
     else
       ESP:Toggle(false)
   end
end)

Section1:addToggle("Players", nil, function(State)
    if State then
    ESP.Players = true
     else
       ESP.Players = false
   end
end)

Section1:addToggle("Tracers", nil, function(State)
    if State then
    ESP.Tracers = true
     else
       ESP.Tracers = false
   end
end)

Section1:addToggle("Names", nil, function(State)
   if State then
    ESP.Names = true
     else
       ESP.Names = false
   end
end)

Section1:addToggle("Boxes", nil, function(State)
    if State then
    ESP.Boxes = true
     else
       ESP.Boxes = false
   end
end)

local Button1 = Section1:addButton("Anti Lag", function()
for _, v in pairs(Workspace:GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
        v.Material = Enum.Material.SmoothPlastic
        if v:IsA("Texture") then
            v:Destroy()
        end
    end
end
end)
  
else
  loadstring(game:HttpGet("https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/unsupportedgames.lua"))()
end
