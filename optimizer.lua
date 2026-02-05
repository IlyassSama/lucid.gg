local players = game:GetService("Players")
local rs = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local ss = game:GetService("SoundService")
local repstorage = game:GetService("ReplicatedStorage")

local guis = {
	"CustomLeaderboard", "DrRandomList", "EmptyScreenGui", "HudShop",
	"InsertedObjects", "RaikohoCutscene", "ScreenGui", "UpdateLog", "Watermark", "TextLabel",
}

local huds = { "Key", "BossHealth", "Bottom", "Emote", "EmoteList", "xbox" }

local scripts = { "MusicPlayer", "FriendListGetter", ".RunOnceLocal", ".LocalFX_All" }

local objects = {
	"FriendyNPCs", "Lobby", ".UBW", "1v1Leaderboard", "2v2Leaderboard", "3v3Leaderboard",
	"Cam", "Crate", "DESERT", "DuelField", "TreasurePile", "UniverseResetTown",
}

local function hideModel(model)
	for _, descendant in model:GetDescendants() do
		if descendant:IsA("BasePart") then
			descendant.Transparency = 1
			descendant.CastShadow = false
		end
		if descendant:IsA("Decal") or descendant:IsA("Texture") then
			descendant.Transparency = 1
		end
		if descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") or descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") or descendant:IsA("PointLight") or descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight") then
			descendant.Enabled = false
		end
	end

	if model:IsA("BasePart") then
		model.Transparency = 1
		model.CanCollide = false
		model.CastShadow = false
	end
end

local function stripInstance(instance)
	pcall(function()
		if instance:IsA("BasePart") then
			local parent = instance.Parent
			local isPlayer = parent and players:GetPlayerFromCharacter(parent)
			if not isPlayer then
				instance.Material = Enum.Material.SmoothPlastic
				instance.Transparency = 1
				instance.CastShadow = false
			end
		end
		if instance:IsA("Decal") or instance:IsA("Texture") then
			instance.Transparency = 1
		end
		if instance:IsA("ParticleEmitter") or instance:IsA("Trail") or instance:IsA("Beam") or instance:IsA("Fire") or instance:IsA("Smoke") or instance:IsA("Sparkles") or instance:IsA("PointLight") or instance:IsA("SpotLight") or instance:IsA("SurfaceLight") or instance:IsA("BillboardGui") or instance:IsA("SurfaceGui") then
			instance.Enabled = false
		end
		if instance:IsA("MeshPart") or instance:IsA("SpecialMesh") then
			instance.TextureID = ""
		end
	end)
end

local function muteSound(sound)
	if sound:IsA("Sound") then
		sound.Volume = 0
		sound:Stop()
	end
end

pcall(function()
    local playerGui = players.LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, name in ipairs(guis) do
            local item = playerGui:FindFirstChild(name)
            if item then item:Destroy() end
        end
        local hud = playerGui:FindFirstChild("HUD")
        if hud then
            for _, name in ipairs(huds) do
                local item = hud:FindFirstChild(name)
                if item then item:Destroy() end
            end
        end
    end
end)

pcall(function()
    local playerScripts = players.LocalPlayer:FindFirstChild("PlayerScripts")
    if playerScripts then
        for _, name in ipairs(scripts) do
            local script = playerScripts:FindFirstChild(name)
            if script and (script:IsA("LocalScript") or script:IsA("ModuleScript")) then
                script.Disabled = true
            end
        end
        for _, descendant in playerScripts:GetDescendants() do
            for _, name in ipairs(scripts) do
                if descendant.Name == name and descendant:IsA("LocalScript") then
                    descendant.Disabled = true
                end
            end
        end
    end
end)

pcall(function()
    lighting.GlobalShadows = false
    lighting.FogEnd = 100000
    lighting.Brightness = 1
    lighting.ClockTime = 12
    lighting.GeographicLatitude = 0
    lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
    lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    
    for _, child in lighting:GetChildren() do
        if child:IsA("Sky") then child.Parent = nil end
        if child:IsA("Atmosphere") or child:IsA("Bloom") or child:IsA("BlurEffect") or child:IsA("ColorCorrectionEffect") or child:IsA("DepthOfFieldEffect") or child:IsA("SunRaysEffect") then
            child.Enabled = false
        end
    end
end)

pcall(function()
    for _, name in ipairs(objects) do
        local item = workspace:FindFirstChild(name)
        if item then hideModel(item) end
    end
end)

pcall(function()
    ss.RespectFilteringEnabled = false
    for _, descendant in workspace:GetDescendants() do muteSound(descendant) end
    for _, descendant in ss:GetDescendants() do muteSound(descendant) end
    for _, descendant in repstorage:GetDescendants() do muteSound(descendant) end
    
    local playerGui = players.LocalPlayer:FindFirstChild("PlayerGui")

    if playerGui then
        for _, descendant in playerGui:GetDescendants() do muteSound(descendant) end
    end
    
    ss.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Sound") then
            descendant.Volume = 0
            descendant:Stop()
        end
    end)
end)

for _, descendant in workspace:GetDescendants() do stripInstance(descendant) end

workspace.DescendantAdded:Connect(function(descendant)
    stripInstance(descendant)
    muteSound(descendant)
end)

pcall(function()
    workspace.Terrain.Decoration = false
    workspace.Terrain.WaterWaveSize = 0
    workspace.Terrain.WaterWaveSpeed = 0
    workspace.Terrain.WaterReflectance = 0
    workspace.Terrain.WaterTransparency = 1
end)

if setfpscap then setfpscap(60) end

task.spawn(function()
    while true do
        rs:Set3dRenderingEnabled(false)
        task.wait(1)
    end
end)
