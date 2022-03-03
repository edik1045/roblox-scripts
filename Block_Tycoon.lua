--// UI Library \\--
local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("edik1045 Hub | discord.gg/XUata5aXz9")

local serv = win:Server("edik1045 Hub", "")

local script = serv:Channel("Blocks")

script:Toggle(
    "Inf. Blocks",
    false,
    function(Inf)
        if Inf then
            Library.flags.Inf = true
        else
            Library.flags.Inf = false
            
        end
    end
)
script:Toggle(
    "All Blocks Fake (fake cuz cant drop lel)",
    false,
    function(Inf)
        if Inf then
            table.foreach(Blocks, function(A_1, A_2)
                A_2.Parent = Inventory
            end)
        else
            table.foreach(Blocks, function(A_1, A_2)
                A_2.Parent = nil
            end)
        end
    end
)
local bvslider = script:Slider(
    "Fake Blocks Value",
    0,
    1000,
    0,
    function(fbvalue)
        local Fake = Instance.new("NumberValue")
        Fake.Name = A_1.Name
        Fake.Value = fbvalue
                
    end
)

--// Exploit Check \\--
if #{hookmetamethod, getnamecallmethod} ~= 2 then
    game:Shutdown()
    return
end

--// Exploit Fix \\--
if not pcall(function() return syn.protect_gui end) then
    syn = {}
    syn.protect_gui = function(A_1)
        A_1.Parent = CoreGui
    end
end

--// Services \\--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--// Variables \\--
local Player = Players.LocalPlayer
local Inventory = Player:WaitForChild("Inventory")
local BlockFolder = ReplicatedStorage:WaitForChild("Blocks")
local Blocks = {}




--// Get Blocks \\--
for _, A_1 in next, BlockFolder:GetChildren() do
    table.insert(Blocks, (function()
        local Fake = Instance.new("NumberValue")
        Fake.Name = A_1.Name
        Fake.Value = fbvalue
        return Fake
    end)())
end


--// Block Spoof \\--
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    -- Variables
    local Args = {...}
    local Info = Args[2]
    local NamecallMethod = getnamecallmethod()

    -- Fake
    if NamecallMethod == "FireServer" and Self.Name == "PlaceBlockE" and typeof(Info) == "table" and (Info[3].ClassName == "NumberValue" or Library.flags.Inf) then
        Info[3] = {Name=Info[1];Value=1}
    end
    return OldNameCall(Self, unpack(Args))
end)
