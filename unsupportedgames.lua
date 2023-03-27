

--[[
  ______ _      ______ _____  _____ _    _ __  __ 
 |  ____| |    |  ____|  __ \|_   _| |  | |  \/  | 
 | |__  | |    | |__  | |__) | | | | |  | | \  / |
 |  __| | |    |  __| |  _  /  | | | |  | | |\/| |
 | |____| |____| |____| | \ \ _| |_| |__| | |  | |
 |______|______|______|_|  \_\_____|\____/|_|  |_|     
]]

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Elerium Hub V4 - Unsupported Game", 5013109572)
local Client = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local wait = task.wait 
local spawn = task.spawn 

local creditsPage = venyx:addPage("Hub", 5012544693)
local creditsSection = creditsPage:addSection("Supported Games")
creditsSection:addButton("Murder Mystery 2", function()
  
end)

creditsSection:addButton("KAT", function()
    
end)

creditsSection:addButton("Arsenal", function()
    
end)
  
creditsSection:addButton("Pet Simulator X", function()
      
end)
  

creditsSection:addKeybind("Toggle UI Keybind", Enum.KeyCode.RightShift, function() 
  venyx:toggle()
end, 
function(value) toggleUIKey = value end)

local Name = "EleriumHubMain.txt"

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

