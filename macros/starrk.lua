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

local function dv()
    for i,v in pairs(LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BodyVelocity") or v:IsA("BodyGyro") or v:IsA("RocketPropulsion") or v:IsA("BodyThrust") or v:IsA("BodyAngularVelocity") or v:IsA("AngularVelocity") or v:IsA("BodyForce") or v:IsA("VectorForce") or v:IsA("LineForce") then
            v:Destroy()
        end
    end
end

Macros[getgenv().Keys[1]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    sel = FindNearestLive(true)
    v = sel.Parent or nil
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
    for i = 1,2 do
    wait(0.025)
    Event:FireServer(
        "fire",
        {
            air = true,
            range = "3",
            ToolName = "Sonido Clones",
            targ = v,
            teamtarg = v
        }
    )
    end
    wait(1.55)
    dv()
    wait(0.025)
    Event:FireServer("spaceoff")
end

return Macros
