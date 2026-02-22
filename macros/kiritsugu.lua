local Macros = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

Macros[getgenv().Keys[1]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    Event:FireServer("space")
    wait(0.025)
    Event:FireServer(
        "fire",
        {
            air = true,
            range = "2",
            ToolName = "Rapid Fire"
        }
    )
    LocalPlayer.Character:WaitForChild("Slow").Destroying:Wait()
    wait(0.2)
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

Macros[getgenv().Keys[2]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    Event:FireServer(
        "truem1",
        {
            md = Vector3.new(0, 0, 0),
            skeyreal = false,
            skeydown = true,
            dodgevelo = Vector3.new(0, 0, 0),
            air = true
        }
    )
    wait(0.1)
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "4",
            ToolName = "Triple Accel"
        }
    )
    wait(0.025)
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "3",
            ToolName = "Combat Knife"
        }
    )
end

Macros[getgenv().Keys[3]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "4",
            ToolName = "Triple Accel"
        }
    )
    wait(0.025)
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "2",
            ToolName = "Contender"
        }
    )
end

Macros[getgenv().Keys[4]] = function()
    local Event = LocalPlayer.Backpack.ServerTraits.Input
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "4",
            ToolName = "Triple Accel"
        }
    )
    wait(0.025)
    Event:FireServer(
        "fire",
        {
            air = false,
            neutral = true,
            range = "2",
            ToolName = "Rapid Fire"
        }
    )
end

return Macros
