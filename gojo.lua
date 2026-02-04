local keycodeMap = {
["0"] = 0x30,
["1"] = 0x31,
["2"] = 0x32,
["3"] = 0x33,
["4"] = 0x34,
["5"] = 0x35,
["6"] = 0x36,
["7"] = 0x37,
["8"] = 0x38,
["9"] = 0x39,
["a"] = 0x41,
["b"] = 0x42,
["c"] = 0x43,
["d"] = 0x44,
["e"] = 0x45,
["f"] = 0x46,
["g"] = 0x47,
["h"] = 0x48,
["i"] = 0x49,
["j"] = 0x4A,
["k"] = 0x4B,
["l"] = 0x4C,
["m"] = 0x4D,
["n"] = 0x4E,
["o"] = 0x4F,
["p"] = 0x50,
["q"] = 0x51,
["r"] = 0x52,
["s"] = 0x53,
["t"] = 0x54,
["u"] = 0x55,
["v"] = 0x56,
["w"] = 0x57,
["x"] = 0x58,
["y"] = 0x59,
["z"] = 0x5A,
["enter"] = 0x0D,
["shift"] = 0x10,
["ctrl"] = 0x11,
["alt"] = 0x12,
["pause"] = 0x13,
["capslock"] = 0x14,
["spacebar"] = 0x20,
["space"] = 0x20,
["pageup"] = 0x21,
["pagedown"] = 0x22,
["end"] = 0x23,
["home"] = 0x24,
["left"] = 0x25,
["up"] = 0x26,
["right"] = 0x27,
["down"] = 0x28,
["insert"] = 0x2D,
["delete"] = 0x2E,
["f1"] = 0x70,
["f2"] = 0x71,
["f3"] = 0x72,
["f4"] = 0x73,
["f5"] = 0x74,
["f6"] = 0x75,
["f7"] = 0x76,
["f8"] = 0x77,
["f9"] = 0x78,
["f10"] = 0x79,
["f11"] = 0x7A,
["f12"] = 0x7B,
}

local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local Run = game:GetService('RunService')

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

local function delay(ms)
task.wait(ms / 1000)
end

local function simulatekeydown(key)
local code = keycodeMap[key:lower()]
keypress(code)
end

local function simulatekeyup(key)
local code = keycodeMap[key:lower()]
keyrelease(code)
end

local Macros = {}

Macros.Z = function()
simulatekeydown("3")
simulatekeyup("3")

delay(150)
simulatekeydown("3")
simulatekeyup("3")

simulatekeydown("3")
simulatekeydown("q")
simulatekeyup("q")
simulatekeyup("3")

delay(10)
simulatekeydown("3")
delay(40)
simulatekeyup("3")

delay(60)
simulatekeydown("3")
delay(30)
simulatekeyup("3")
end

Macros.X = function()
simulatekeydown("2")
delay(110)

simulatekeydown("1")
delay(60)
simulatekeyup("2")

delay(60)
simulatekeydown("f")
delay(60)
simulatekeyup("f")

delay(10)
simulatekeyup("1")

delay(50)
simulatekeydown("f")
delay(10)

simulatekeydown("1")
delay(50)
simulatekeyup("1")

delay(10)
simulatekeyup("f")

delay(30)
simulatekeydown("1")
simulatekeydown("f")
delay(60)
simulatekeyup("1")
simulatekeyup("f")

delay(60)
simulatekeydown("1")
simulatekeydown("f")
delay(60)
simulatekeyup("1")
simulatekeyup("f")

delay(50)
simulatekeydown("1")
delay(20)
simulatekeydown("f")
delay(50)
simulatekeyup("1")
delay(10)
simulatekeyup("f")

delay(50)
simulatekeydown("1")
delay(20)
simulatekeydown("f")
delay(60)
simulatekeyup("1")
simulatekeyup("f")

delay(60)
simulatekeydown("1")
simulatekeydown("f")
delay(60)
simulatekeyup("1")
delay(10)
simulatekeyup("f")

delay(60)
simulatekeydown("1")
simulatekeydown("f")
delay(80)
simulatekeyup("f")
simulatekeyup("1")
end

Macros.C = function()
simulatekeydown("1")
simulatekeyup("1")

delay(430)
simulatekeydown("SPACE")
simulatekeyup("SPACE")

simulatekeydown("w")
simulatekeydown("q")
simulatekeyup("q")

delay(40)
simulatekeyup("w")

delay(250)
end

Macros.Y = function()
simulatekeydown("3")
simulatekeyup("3")

simulatekeydown("3")
simulatekeyup("3")

simulatekeydown("3")
simulatekeydown("q")
simulatekeyup("q")
simulatekeyup("3")

delay(10)
simulatekeydown("3")
delay(50)
simulatekeyup("3")

delay(60)
simulatekeydown("3")
delay(30)
simulatekeyup("3")
end

Macros.J = function()
simulatekeydown("4")
simulatekeyup("4")

delay(560)
simulatekeydown("2")
delay(100)
simulatekeyup("2")

delay(90)
simulatekeydown("1")
delay(110)
simulatekeyup("1")

delay(130)
simulatekeydown("3")
delay(80)
simulatekeyup("3")

delay(1420)

local timings = {80,80,90,80,80,80,90}
for _, t in ipairs(timings) do
simulatekeydown("1")
delay(t)
simulatekeyup("1")
delay(60)
end

delay(190)
simulatekeydown("3")
delay(80)
simulatekeyup("3")

delay(390)

local t2 = {50,60,60,60,60}
for _, t in ipairs(t2) do
simulatekeydown("3")
delay(t)
simulatekeyup("3")
delay(80)
end

delay(380)
end

Macros.T = function()
simulatekeydown("2")
simulatekeyup("2")
local sel = FindNearestLive()
local cs = LocalPlayer.Character:WaitForChild('CHARGINGSMASH',6)
if not cs or not sel then return end
cs.Destroying:Wait()
Root = LocalPlayer.Character.HumanoidRootPart
mCD = Run.RenderStepped:Connect(function()
Root.CFrame = Root.CFrame:lerp(sel.CFrame+Vector3.new(0,6,0),0.15);
end)
wait(1.5)
mCD:Disconnect()
end

Macros.Five = function()
simulatekeydown("4")
simulatekeyup("4")
delay(30)
for i = 1,10 do
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('Humanoid') then
for i,v in LocalPlayer.Character:FindFirstChild('Humanoid'):GetPlayingAnimationTracks() do
v:AdjustSpeed(0);
v:Stop();
end;
end;
delay(1)
end
simulatekeydown("r")
delay(20)
simulatekeydown("1")
simulatekeyup("1")
delay(20)
simulatekeyup("r")
mouse1click()
end

return Macros
