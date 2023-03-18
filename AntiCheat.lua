repeat task.wait() until game:IsLoaded()
local G = getgenv and getgenv() or _G or shared
if game.PlaceId == 185655149 then
    wait(50)
end
for i,v in pairs(game:GetChildren()) do
    G[v.ClassName] = v 
end 
G.Player = Players.LocalPlayer
G.wait = task.wait 
G.spawn = task.spawn
G.Heartbeat = RunService.Heartbeat
G.Stepped = RunService.Stepped
G.RenderStepped = RunService.RenderStepped
G.Error = ScriptContext.Error
G.MessageOut = LogService.MessageOut
G.Kick = Player.Kick
G.Idled = Player.Idled
G.GC = GetChildren
G.GD = GetDescendants

local Name = game.PlaceId .. ".json"
local Des = {}
if makefolder and not isfile("Elerium Hub") then
    makefolder("Elerium Hub")
end 

G.Settings = {}
local Pcall = pcall(function()
    if isfile("Elerium Hub//" .. Name) then
        readfile("Elerium Hub//" .. Name)
    else 
        writefile("Elerium Hub//" .. Name, HttpService:JSONEncode(Des))
    end 
end)

if isfile("Elerium Hub//" .. Name) and readfile("Elerium Hub//" .. Name) then
    Settings = HttpService:JSONDecode(readfile("Elerium Hub//" .. Name))
end 


local Nos = {
    "PreloadAsync",
    "Kick",
     "kick",
    "xpcall",
    "gcinfo",
    "collectgarbage",
    "FindService",
}
local Disables = {
    Error,
    MessageOut
}

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(...)
    local Args = {...}
    local A, B, C = ...
    if table.find(Nos, A.Name) then
        return 
    end 
    if table.find(Nos, getnamecallmethod()) then
        return  
    end 
    return OldNameCall(...)
end)

for i,v in pairs(Disables) do 
    for i,v in pairs(getconnections(v)) do
        if v.Disable then
            v:Disable()
        elseif v.Disconnect then
            v:Disconnect()
        end 
    end 
end
if setfflag then
    setfflag("HumanoidParallelRemoveNoPhysics", "False")
    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
end
if setfpscap then
    setfpscap(100)
end

ScriptContext:SetTimeout(0.5)

G.GetFunction = function(A)
    for i,v in pairs(getgc()) do
        if type(v) == "function" and getinfo(v).name == tostring(A) then
            A = v 
        end 
    end 
    return A 
end 

G.Teleport = function(A, B, Toggle)
    if Toggle and A and B then
        A.CFrame = B.CFrame 
    end 
    return A, B, Toggle
end 

G.DisableConnection = function(A, B)
    for i,v in pairs(getconnections(A[tostring(B)])) do 
        v:Disable()
    end 
    return A, B 
end

G.Tween = function(A, B, C)
    if A and B then
        local Time = (B.Position - A.Position).Magnitude / C 
        local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
        local Tween = TweenService(A, Info, {CFrame = CFrame.new(B.Position)})
        Tween:Play()
        wait(Time)
    end 
    return A, B, C
end 

G.Save = function()
    pcall(function()
        writefile("Elerium Hub//" .. Name, HttpService:JSONEncode(Settings))
    end)
end 

G.ServerHop = function()
    spawn(function()
        while wait() do
            pcall(function()
                local Gay = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
                for i,v in pairs(Gay.data) do
                    if v.playing < v.maxPlayers then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, Player)
                        break
                    end 
                end
            end)
            wait(4)
        end 
    end)
end 

G.Rejoin = function()
    return TeleportService:Teleport(game.PlaceId, Player)
end 

G.NoClip = function(A)
    return A:ChangeState(11)
end 
G.NoClip2 = function(A)
    for i,v in pairs(A:GetChildren()) do
        if v:IsA("BasePart") then
            v.CanCollide = false 
        end 
    end 
end 
