local scriptsByPlaceId = {
	[10450270085] = "https://raw.githubusercontent.com/IlyassSama/lucid.gg/refs/heads/main/jjs.lua",
  [16379684339] = "https://raw.githubusercontent.com/IlyassSama/lucid.gg/refs/heads/main/jjs.lua",
  [16379688837] = "https://raw.githubusercontent.com/IlyassSama/lucid.gg/refs/heads/main/jjs.lua",
	[136599248168660] = "https://raw.githubusercontent.com/IlyassSama/lucid.gg/refs/heads/main/solo_hunters.lua",
	[1458767429] = "https://raw.githubusercontent.com/IlyassSama/lucid.gg/refs/heads/main/aba.lua",
  [2008032602] = "https://raw.githubusercontent.com/IlyassSama/lucid.gg/refs/heads/main/aba.lua",
  [127794225497302] = "https://raw.githubusercontent.com/IlyassSama/lucid.gg/refs/heads/main/abyss.lua",
}

local placeId = game.PlaceId
local gameId = game.GameId
local scriptUrl = scriptsByPlaceId[placeId] or scriptsByPlaceId[gameId]

if scriptUrl then
	loadstring(game:HttpGet(scriptUrl))()
else
	warn("Game or Place not supported. Please report in discord immediatly!")
end
