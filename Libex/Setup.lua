local tbl = {
    "10475785213", -- // Circel
    "10475787657", -- // Square
    "10475788806", -- // Shadow
    "10477330253", -- // Full Circel
    "10477389234", -- // Gradient Plate
    "10477426577"  -- // Scroll Square
}


for i,v in pairs(tbl) do
    if (FS_func.WriteFile and FS_func.IsFile) then
        if not FS_func.IsFile("Scryptiq/Assets/"..v..".png") then
            local url = "https://raw.githubusercontent.com/Woutt/Scryptiq/main/Libex/Assets/"..v..".png"
            FS_func.WriteFile("Scryptiq/Assets/"..v..".png", game:HttpGet(url))
        end
    end
end

local GetAsset = function(x)
    local id = tbl[x]
    if FS_func.GetAssets ~= nil then
        return FS_func.GetAssets("Scryptiq/Assets/"..id..".png")
    else
        return "rbxasset://"..id
    end
end
return GetAsset
