local Macros = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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
    wait(0.14)
    Event:FireServer(
        "fire",
        {
            air = true,
            range = "3",
            ToolName = "Time Shift"
        }
    )
    wait(0.025)
    Event:FireServer("spaceoff")
end

return Macros
