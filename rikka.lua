local Macros = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Run = game:GetService('RunService')

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
    local mouse = LocalPlayer:GetMouse()
    local mousehit = mouse.Hit
    Event:FireServer("fire", {
        air = false,
        mousehit = mousehit,
        camdir = camdir,
        neutral = true,
        campos = campos,
        range = "1",
        ToolName = "Schwartzshieldo"
    })
    local Root = LocalPlayer.Character.HumanoidRootPart
    local sel = FindNearestLive()
    LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    LocalPlayer:WaitForChild("Backpack"):WaitForChild("ServerTraits"):WaitForChild("Input"):FireServer("dodge")
    local BV = Instance.new('BodyVelocity', game.Workspace)
    BV.Parent = Root
    BV.velocity = Vector3.new(0, 0, 0)
    BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
    wait(0.3)
    local mCD = Run.RenderStepped:Connect(function()
        Root.CFrame = Root.CFrame:lerp(sel.CFrame+Vector3.new(0,6,0),0.15);
    end)
    wait(1)
    BV:Destroy()
    mCD:Disconnect()
end

Macros[getgenv().Keys[2]] = function()
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
        range = "3",
        ToolName = "Chuuni-charge",
        camdir = camdir,
        targ = sel.Parent,
        teamtarg = sel.Parent,
        mousehit = mousehit
    })
    local Root = LocalPlayer.Character.HumanoidRootPart
    local BV = Instance.new('BodyVelocity', game.Workspace)
    BV.Parent = Root
    BV.velocity = Vector3.new(0, 0, 0)
    BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
    local mCD = Run.RenderStepped:Connect(function()
        Root.CFrame = Root.CFrame:lerp(sel.CFrame+Vector3.new(0,3,0),0.2);
    end)
    wait(1.5)
    BV:Destroy()
    mCD:Disconnect()
end

Macros[getgenv().Keys[3]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    local camera = workspace.CurrentCamera
    local camdir = camera.CFrame.LookVector
    local campos = camera.CFrame.Position
    local mouse = LocalPlayer:GetMouse()
    local mousehit = mouse.Hit
    Event:FireServer("fire", {
        air = false,
        mousehit = mousehit,
        camdir = camdir,
        neutral = true,
        campos = campos,
        range = "1",
        ToolName = "Avalon Strike"
    })
    LocalPlayer.Character:WaitForChild('CHARGINGSMASH'):Destroy()
    LocalPlayer.Character:WaitForChild('NoAttack'):Destroy()
    LocalPlayer.Character:WaitForChild('Action'):Destroy()
end

return Macros
