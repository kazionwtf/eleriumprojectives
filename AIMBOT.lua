--> VARIABLES <--
local players = game:GetService("Players")
local player =  players.LocalPlayer
local mouse =   player:GetMouse()
local camera =  game:GetService("Workspace").CurrentCamera

--> FUNCTIONS <--
function notBehindWall(target)
  local Ray = Ray.new(player.Character.Head.Position, (target.Position - player.Character.Head.Position).Unit * 300)
  local part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, {player.Character}, false, true)
  if part then
    local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
    if not humanoid then
      humanoid = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
    end
    if humanoid and target and humanoid.Parent == target.Parent then
      local pos, visible = camera:WorldToScreenPoint(target.Position)
      if visible then
        return true
      end
    end
  end
end

function getPlayerClosestToMouse()
  local target = nil
  local maxDist = 100
  
  for _,v in pairs(players:GetPlayers()) do
    if v.Character then
      if v.Character:FindFirstChild("Humanoid") and v.Character.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.TeamColor ~= player.TeamColor then
         local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
         local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).magnitude
         if dist < maxDist and vis then
           local torsoPos = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
           local torsoDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(torsoPos.X, torsoPos.Y)).magnitude
           local headPos = camera:WorldToViewportPoint(v.Character.Head.Position)
           local headDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(headPos.X, headPos.Y)).magnitude
           if torsoDist > headDist then
             if notBehindWall(v.Character.Head) then
                target = v.Character.Head
             end
            else
              if notBehindWall(v.Character.HumanoidRootPart) then
                 target = v.Character.HumanoidRootPart
              end
           end
           maxDist = dist
         end
      end
    end
  end
   return target
end

--> hooking to the remote <--

local gmt = getrawmetatable(game)
setreadonly(gmt, false)

local oldNameCall = gmt._namecall

gmt._namecall = newcclosure(function(self, ...)
  local args = {...}
  local method = getgamecallmethod()
  if tostring(self) == "HitPart" and tostring(method) == "FireServer" then
     args[1] = getPlayerClosestToMouse()
     args[2] = getPlayerClosestToMouse().Position
     return self.FireServer(self, unpack(args))
  end
    return oldNameCall(self, ...)
end)
