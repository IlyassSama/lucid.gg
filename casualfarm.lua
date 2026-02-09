-- // Configuration & Initialization
if (getgenv().Connections) then
    for _, Connection in getgenv().Connections do
        Connection:Disconnect();
    end;
end;

getgenv().Connections = {};

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VirtualUser = game:GetService("VirtualUser");
local HttpService = game:GetService("HttpService");
local Player = Players.LocalPlayer;
local PlayerGui = Player:WaitForChild("PlayerGui");
local RunService = game:GetService("RunService");

print("Loaded on: " .. Player.Name)


local MainAccount = getgenv().AltTable[1]

-- // Game Settings
local PlaceIds = {
    ['Game'] = 1458767429,
    ['Ranked'] = 2008032602,
};

local Deaths = 0;
local LastLevel = nil; 
local Matches = 0

setfpscap(20)
RunService:Set3dRenderingEnabled(false)

-- // Helper Functions
local function checkMoney()
    repeat task.wait() until PlayerGui:FindFirstChild('HUD') and PlayerGui.HUD:FindFirstChild('Money', true)
    return PlayerGui.HUD.Money.Text
end

local function checkPrestige()
    repeat task.wait() until PlayerGui:FindFirstChild('HUD') and PlayerGui.HUD:FindFirstChild('Lvl', true)
    local fullText = PlayerGui.HUD.Lvl.Text
    if fullText:match('|') then
        return string.split(fullText, '|')[2]:match("^%s*(.-)%s*$")
    end
    return "0"
end

local function checkLevel()
    repeat task.wait() until PlayerGui:FindFirstChild('HUD') and PlayerGui.HUD:FindFirstChild('Lvl', true)
    return tonumber(string.split(string.split(PlayerGui.HUD.Lvl.Text, 'Lvl. ')[2], ' ')[1]) or 0
end

-- // Webhook Functions
local function SendMessage(url, message)
    if url == "" then return end
    local data = { ["content"] = message }
    request({
        Url = url,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(data)
    })
end

local function SendMessageEMBED(url, embed)
    if url == "" then return end
    local data = { ["embeds"] = { embed } }
    request({
        Url = url,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(data)
    })
end

function SendStatsWebhook()
    if getgenv().Webhook == "" then return end
    
    local money = checkMoney() or "Loading..."
    local level = checkLevel()
    local prestige = checkPrestige()
    local thumbnailUrl = "https://api.newstargeted.com/roblox/users/v1/avatar-headshot?userid=" .. Player.UserId .. "&size=150x150"

    local didPrestige = (LastLevel and LastLevel >= 99 and level <= 1)
    LastLevel = level

    local embed = {
        ["title"] = didPrestige and "🎉 You Prestiged! 🎉" or "ABA Auto Farm Results",
        ["description"] = "Player: **" .. Player.Name .. "**",
        ["color"] = didPrestige and 65280 or 16776960,
        ["fields"] = {
            {["name"] = "💰 Money", ["value"] = money, ["inline"] = true},
            {["name"] = "📊 Level", ["value"] = tostring(level), ["inline"] = true},
            {["name"] = "Prestiges", ["value"] = prestige, ["inline"] = true},
            {["name"] = "Matches", ["value"] = tostring(Matches), ["inline"] = true},
        },
        ["thumbnail"] = {["url"] = thumbnailUrl},
        ["footer"] = {
            ["text"] = "Lucid.gg | PAID • " .. os.date("%m/%d/%Y %I:%M %p")
        }
    }

    SendMessageEMBED(getgenv().Webhook, embed)
end

-- // 1. Anti-AFK
getgenv().Connections['AntiAFK'] = Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- // 2. GUI & Rematch Logic
getgenv().Connections['GUI'] = PlayerGui.ChildAdded:Connect(function(Child)
    task.wait()

    if Child.Name == 'BanChooser' then
        local RemoteEvent = Child:FindFirstChild('Communicate', true)
        if RemoteEvent then RemoteEvent:FireServer('pass') end

    elseif Child.Name == 'MapBan' then
        task.wait(0.5)
        local maps = Child:FindFirstChild("Maps", true)
        if maps then
            for _, v in pairs(maps:GetChildren()) do
                if v:FindFirstChild('Title') then
                    ReplicatedStorage.MapBanner:FireServer(v.Title.Text)
                end
            end
        end

    elseif Child.Name == 'Rematch' then
        task.spawn(function()
            if Player.Name == MainAccount or getgenv().TrackAltStats then
                task.wait(2)
                SendStatsWebhook()
            end
        end)

        Deaths = 0
        Matches += 1
        ReplicatedStorage:WaitForChild("RematchVote"):FireServer()
    end
end)

-- // 3. Main Game Logic
if game.PlaceId == PlaceIds['Game'] then
    -- Instant Death Logic for Alts
    getgenv().Connections['CHARACTER'] = Player.CharacterAdded:Connect(function(Char)
        local MainPlr = Players:FindFirstChild(MainAccount)
        local alreadyDied = false

        if Player.Name ~= MainAccount and MainPlr then
            task.spawn(function()
                local hum = Char:WaitForChild("Humanoid", 10)
                if not hum then return end

                repeat task.wait()
                    local isReady = hum.Health > 0 and PlayerGui:FindFirstChild('HUD')
                until isReady

                if not alreadyDied and Player.Team and Player.Team ~= MainPlr.Team then
                    alreadyDied = true

                    local healthBar = PlayerGui.HUD:FindFirstChild("Health")
                    if healthBar and healthBar.Visible then
                        hum.Health = 0
                        hum:ChangeState(Enum.HumanoidStateType.Dead)
                        if hum.Health > 0 then
                            Char:BreakJoints()
                        end
                    end
                    Deaths += 1
                end
            end)
        end
    end)

elseif game.PlaceId == PlaceIds['Ranked'] then
    -- Casual Lobby Join + Team Teleport Logic
    local casualLobbies = workspace:FindFirstChild("CasualLobbies")

    if not casualLobbies then
        task.wait(3)
        local inputRemote = ReplicatedStorage:FindFirstChild('Input')
        if inputRemote then
            inputRemote:FireServer('CasualEnter')
        end

        repeat
            task.wait()
            casualLobbies = workspace:FindFirstChild("CasualLobbies")
        until casualLobbies
    end

    -- Destroy LocalCharacter (Anti-Kick)
    local localCharScript = Player.PlayerScripts:FindFirstChild("LocalCharacter")
    if localCharScript then
        localCharScript:Destroy()
    end

    -- Team Teleport Logic
    local character = Player.Character or Player.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local lobby = casualLobbies:FindFirstChild("1s Lobby17")
    if not lobby then return end

    local team = (Player.Name == MainAccount) and lobby:FindFirstChild("Team1") or lobby:FindFirstChild("Team2")

    if team and team:IsA("Model") then
        team:PivotTo(hrp.CFrame * CFrame.new(0, 13, -8))
    end
end⁩⁩⁩⁩⁩
