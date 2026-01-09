--//File system
loadstring(game:HttpGet("https://raw.githubusercontent.com/Woutt/Scryptiq/main/Libex/File_system.lua"))() 
FS_func.FileSystem("Scryptiq/GameSaves/")
FS_func.FileSystem("Scryptiq/Assets/")

--//Load api and libex
loadstring(game:HttpGet("https://raw.githubusercontent.com/Woutt/Scryptiq/main/Misc/API.lua"))() 
loadstring(game:HttpGet("https://raw.githubusercontent.com/Woutt/Scryptiq/main/Libex/Libary"))()

--//Find game
local kick,String = function() game:GetService("Players").LocalPlayer:Kick("Scryptiq doesnt support this game, discord link copied to clipboard!") end
local Error = pcall(function() String = game:HttpGet("https://raw.githubusercontent.com/Woutt/Scryptiq/main/Games/"..game.PlaceId) end)
if Error == false then Invite() wait(3) kick() else loadstring(String)() end
