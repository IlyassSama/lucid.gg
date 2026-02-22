local Macros = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function FindNearestLive(NearMouse)
        local closestHRP = nil
        local closestDist = math.huge
        
        for _, v in ipairs(workspace.Live:GetChildren()) do
            if v.Name ~= LocalPlayer.Name and v:FindFirstChild("HumanoidRootPart") then
                local dist = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if NearMouse then
                    local Mouse = LocalPlayer:GetMouse()
                    dist = (v.HumanoidRootPart.Position - Mouse.Hit.Position).Magnitude
                end

                if dist < 100 and dist < closestDist then
                    closestDist = dist
                    closestHRP = v.HumanoidRootPart
                end
            end
        end
    return closestHRP
end

Macros[getgenv().Keys[1]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    sel = FindNearestLive(true)
    v = sel.Parent or nil
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "2",
            ToolName = "Kyoka Suigetsu",
            moveChoice = "Complete Swap",
            targ = v,
            teamtarg = v,
        }
    )
    Event:FireServer("spaceoff")
end

Macros[getgenv().Keys[2]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    sel = FindNearestLive(true)
    v = sel.Parent or nil
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "2",
            ToolName = "Kyoka Suigetsu",
            moveChoice = "True Power",
            targ = v,
            teamtarg = v,
        }
    )
    Event:FireServer("spaceoff")
end

Macros[getgenv().Keys[3]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "2",
            ToolName = "Kyoka Suigetsu",
            moveChoice = "Replace Self",
        }
    )
    Event:FireServer("spaceoff")
end

Macros[getgenv().Keys[4]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    sel = FindNearestLive(true)
    v = sel.Parent or nil
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "3",
            ToolName = "Kido",
            moveChoice = "Kurohitsugi",
            targ = v,
            teamtarg = v,
        }
    )
    Event:FireServer("spaceoff")
end

Macros[getgenv().Keys[5]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "3",
            ToolName = "Kido",
            moveChoice = "Danku",
        }
    )
    Event:FireServer("spaceoff")
end

Macros[getgenv().Keys[6]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "3",
            ToolName = "Kido",
            moveChoice = "Raikoho",
        }
    )
    Event:FireServer("spaceoff")
end

return Macros
