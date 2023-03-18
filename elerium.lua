
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



repeat
    wait()
until game:IsLoaded()

loadstring(game:HttpGet("https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/AntiCheat.lua"))()

local A = loadstring(game:HttpGet("https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/supportedgames"))()
getgenv().Get =
    setmetatable(
    {},
    {
        __index = function(A, B)
            return game:GetService(B)
        end
    }
)
local CoreGui = Get.CoreGui
local StarterGui = Get.StarterGui
local Lighting = Get.Lighting


    

local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Parent = Lighting
BlurEffect.Size = 0
local ScreenGui = Instance.new("ScreenGui")
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end
local ImageLabel = Instance.new("ImageLabel")
ScreenGui.Parent = CoreGui
ImageLabel.Parent = ScreenGui
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0.5, -(303 / 2), 0.5, -(263 / 2))
ImageLabel.Rotation = 0
ImageLabel.Size = UDim2.new(0, 303, 0, 263)
ImageLabel.Image = ""
ImageLabel.ImageTransparency = 1
for Index = 1, 50, 2 do
    BlurEffect.Size = Index
    ImageLabel.ImageTransparency = ImageLabel.ImageTransparency - 0.1
    wait()
end
wait(0.1)
ImageLabel:TweenPosition(UDim2.new(0.5, 342 / 1, 0.5, 263 / 2, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5))
wait(0.1)
for Index = 1, 50, 2 do
    BlurEffect.Size = 50 - Index
    ImageLabel.ImageTransparency = ImageLabel.ImageTransparency + 0.1
    wait()
end
BlurEffect:Destroy()
ScreenGui:Destroy()

local queue_on_teleport =
    queue_on_teleport or
    syn and
        syn.queue_on_teleport [[
       repeat wait() until game:IsLoaded() wait(5) print("ServerHoped or rejoined")
       loadstring(game:HttpGet('https://raw.githubusercontent.com/kazionwtf/eleriumprojectives/main/Source'))()]]

for i, v in pairs(Games) do
    if i == game.PlaceId then
        loadstring(game:HttpGet(v))()
    end
end

for i, v in pairs(Unknown) do
    loadstring(game:HttpGet(v))()
end


wait(5)

local function Copy()
    setclipboard("server got termed lol wait a lil")
end
local Gang = Instance.new("BindableFunction")

function Gang.OnInvoke(v)
    if v == "Yes" then
        Copy()
        SendNotification("Discord", "Discord Link Copying Sucessful", "rbxassetid://5013109572", 15)
    end
end
StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Elerium Hub Discord",
        Text = "Copy to clipboard?",
        Duration = 5,
        Callback = Gang,
        Button1 = "Yes",
        Button2 = "No"
    }
)
