local tbl = {
    "10475785213", -- // Circel
    "10475787657", -- // Square
    "10475788806", -- // Shadow
    "10477330253", -- // Full Circel
    "10477389234", -- // Gradient Plate
    "10477426577"  -- // Scroll Square
}

local WriteFile = writefile or write_file or write or nil
local IsFile = isfile or syn_isfile or is_file or nil
for i,v in pairs(tbl) do
    if (WriteFile and IsFile) then
        if not IsFile("Scryptiq/Assets/"..v..".png") then
            local url = "https://raw.githubusercontent.com/Woutt/Scryptiq/main/Libex/Assets/"..v..".png"
            WriteFile("Scryptiq/Assets/"..v..".png", game:HttpGet(url))
        end
    end
end

local GetAsset = function(x)
    local id = tbl[x]
    local AssetFunc = getcustomasset or nil
    if AssetFunc ~= nil then
        return AssetFunc("Scryptiq/Assets/"..id..".png")
    else
        return "rbxasset://"..id
    end
end
return GetAsset
