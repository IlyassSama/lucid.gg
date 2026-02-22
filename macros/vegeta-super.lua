local Macros = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function FindNearestLive()
        local closestHRP = nil
        local closestDist = math.huge
        
        for _, v in ipairs(workspace.Live:GetChildren()) do
            if v.Name ~= LocalPlayer.Name and v:FindFirstChild("HumanoidRootPart") then
                local dist = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
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
    Event:FireServer("space")
    wait(0.025)
    Event:FireServer(
        "truem1",
        {
            md = Vector3.new(0, 0, 0),
            skeyreal = false,
            skeydown = true,
            dodgevelo = Vector3.new(0, 0, 0),
            air = false
        }
    )
    wait(0.025)
    Event:FireServer(
        "fire",
        {
            air = true,
            range = "4",
            ToolName = "Final Strike"
        }
    )
    wait(0.025)
    Event:FireServer("spaceoff")
end

Macros[getgenv().Keys[2]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    Event:FireServer("space")
    local sel = FindNearestLive()
    wait(0.025)
    Event:FireServer(
        "truem1",
        {
            md = Vector3.new(0, 0, 0),
            skeyreal = false,
            skeydown = true,
            dodgevelo = Vector3.new(0, 0, 0),
            air = false
        }
    )
    wait(0.025)
    Event:FireServer('g')
    for i = 1,3 do
    wait(0.05)
    Event:FireServer(
        "truem1",
        {
            md = Vector3.new(0, 0, 0),
            skeyreal = false,
            skeydown = true,
            dodgevelo = Vector3.new(0, 0, 0),
            air = false
        }
    )
    end
    wait(0.025)
    Event:FireServer("spaceoff")
    wait(0.7)
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "1",
            ToolName = "Grab",
            targ = sel.Parent,
            teamtarg = sel.Parent
        }
    )
end

return Macros
