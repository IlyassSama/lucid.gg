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
    local camera = workspace.CurrentCamera
    local camdir = camera.CFrame.LookVector
    local campos = camera.CFrame.Position
    local sel = FindNearestLive()
    local mousehit = sel.CFrame
    Event:FireServer("fire", {
        air = false,
        neutral = true,
        campos = campos,
        range = "1",
        ToolName = "Linear Strike",
        camdir = camdir,
        targ = sel.Parent,
        teamtarg = sel.Parent,
        mousehit = mousehit
    })
    wait(0.85)
    local Root = LocalPlayer.Character.HumanoidRootPart
    Root.CFrame = Root.CFrame * CFrame.Angles(0, math.pi, 0)
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, child in ipairs(hrp:GetChildren()) do
            if child:IsA("BodyVelocity") then
                child:Destroy()
            end
        end
    end
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
    Event:FireServer("spaceoff")
end

return Macros
