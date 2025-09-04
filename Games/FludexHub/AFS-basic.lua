repeat wait("0."..math.random(1,2))
until getgenv().Roblox_Updates == "o[tVTzrSQq]"
repeat wait("0."..math.random(1,3))
until tostring(game:GetService("CoreGui").RobloxGui.CoreValue.Value) == tostring(1865734982258)



local var = {
    farm = "",
    KeySpam = {},
    FarmValue = 0,
    ChikaraFarm = false,
    Magnitude = 10,
    MagnitudeCheck = Vector3.new(0,0,0),
    FollowMagnitude = 15,
    MobFrame = {},
}



-- // Noclip
local StatNoclip = false
local Noclip = {false,false,false,false,false,false,false,false,false,false}
do 

    local noclip_table,noclip_cam = {},nil
    game:GetService("RunService").Stepped:connect(function()
        if table.find(Noclip,true) then
            for i = 1, #noclip_table do
                noclip_table[i].CanCollide = false
            end
        end
    end)

    local function add_noclip_table(x)
        noclip_table = {}
        x:WaitForChild("Head")
        for i, v in pairs(x:GetChildren()) do
            if v:IsA("BasePart") then
                table.insert(noclip_table, v)
            end
        end
    end

    if game:GetService("Players").LocalPlayer.Character then
        add_noclip_table(game:GetService("Players").LocalPlayer.Character)
    end
    game:GetService("Players").LocalPlayer.CharacterAdded:connect(function(x)
        add_noclip_table(x)
    end)
end

-- // Game Functions
local CheckForMobs, GameNotify, GameLoader, getstat, SetKey, OpenAllShops, ForceClose, ReturnDeath
do
    CheckForMobs = function()
        local path = game:GetService("Workspace").Scriptable
        if path:FindFirstChild("MobsSpawner") ~= nil and path:FindFirstChild("SpawnedMobs") then
            return true
        else
            return false
        end
    end

    GameNotify = function(a,b)
        local c
        if b == 1 then
           c = false
        elseif b == 2 then
            c = "LevelUp"
        elseif b == 3 then
            c = "Boss"
        end
        require(game.Players.LocalPlayer.PlayerGui.Main.MainClient.NotifModule).Notify(a, c)
    end

    GameLoader = function()
        local saved = settings.TweenSpeed
        for i = 1, 2 do wait(0.1)
            settings.TweenSpeed = 0
            local a,b = "0."..i,false
            for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do --NPCs
                if v:FindFirstChild("ClickBox") then
                    Teleport(v.ClickBox.CFrame + Vector3.new(0,5,0))
                    wait(a)
                end
                game:GetService("RunService").Heartbeat:Wait()
            end
            game:GetService("RunService").Heartbeat:Wait()
            for i,v in pairs(game:GetService("Workspace").Shops:GetChildren()) do --Shops
                if v:FindFirstChild("ClickBox") then
                    Teleport(v.ClickBox.CFrame + Vector3.new(0,5,0))
                    wait(a) game:GetService("RunService").Heartbeat:Wait()
                end
                
            end
            game:GetService("RunService").Heartbeat:Wait()
            for i,v in pairs(game:GetService("Workspace").DimensionPortal:GetChildren()) do --Dimensions
                if v:FindFirstChild("ClickBox") then
                    Teleport(v.ClickBox.CFrame + Vector3.new(0,5,0))
                    wait(a)
                end
                
            end
            game:GetService("RunService").Heartbeat:Wait()
            if CheckForMobs() then
                for i,v in pairs(game:GetService("Workspace").Scriptable.MobsSpawner:GetChildren()) do
                    if v.ClassName == "Part" then
                        Teleport(v.CFrame + Vector3.new(0,5,0))
                    end
                    game:GetService("RunService").Heartbeat:Wait()
                    game:GetService("RunService").Heartbeat:Wait()
                end
            end
            wait(1.5)
        end
        settings.TweenSpeed = saved
    end

    getstat = function(x)
        local r = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.PlayerDataClient)
        for i,v in pairs(r.Data.Stats[x]) do
            return v 
        end
    end


    SetKey = function(v)
        local x = game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.StatModuleClient
        local y = game:GetService("Players").LocalPlayer.PlayerGui.Main.Hotkeys
        if v == "Strength" then
            require(x).SelectKey(y[1])
        elseif v == "Durability" then
            if getstat("Durability") < 100 then
                require(x).SelectKey(y[2])  
            else
                require(x).SelectKey(y[4])
            end
        elseif v == "Chakra" then    
            require(x).SelectKey(y[3])
        elseif v == "Sword" then
            require(x).SelectKey(y[4])
        end
    end

    OpenAllShops = function()
        for i,v in pairs(game:GetService("Workspace").Shops:GetChildren()) do
            if v:FindFirstChild("ClickBox") then
                fireclickdetector(v.ClickBox.ClickDetector)
                wait(0.25)
                ForceClose()
                wait()
            end
        end
        
    end

    ForceClose = function()
        local a = game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.CategoryModule
        local close = require(a).ForceCloseAll
        close()
    end

    local DiedPos,CheckDiedPos,GoDiedPos
    ReturnDeath = function(x)
        if x == true then
            CheckDiedPos = game.Players.LocalPlayer.character:WaitForChild("Humanoid").Died:Connect(function(v)
                DiedPos = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame    
            end)
            GoDiedPos = game.Players.LocalPlayer.CharacterAdded:Connect(function(v)
                wait(0.3)
                Teleport(DiedPos)
            end)
        elseif x == false then
            pcall(function()
                CheckDiedPos:Disconnect()
                GoDiedPos:Disconnect()
            end)
        end
    end
    
end
if getgenv().TPCHECKER == nil then
    getgenv().TPCHECKER = true
    GameNotify("Script is loading, this can take a while!!!",1)
    local BLABLA = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
    local NotFound = GameLoader()
    wait(1)
    spawn(function()
        OpenAllShops()
    end)    
    Teleport(BLABLA)
    wait(0.5)
end

-- // Game Tables
local NPCSNames = {}
local Dimensions = {} 
pcall(function()
    for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do 
        if v:IsA("Model") then 
            table.insert(NPCSNames, v.Name)
        end 
    end 
    for i,v in pairs(game:GetService("Workspace").DimensionPortal:GetChildren()) do 
        if v.ClassName == "Model" and not table.find(Dimensions, v.Name) then 
            table.insert(Dimensions, v.Name)
        end 
    end
end)


-------------------------------------

local Library = Libex.UI.new({
    Title = "FludexHub",
    Bottom = "Anime Fighting Sim",
    Folder = "FludexHub/Games/AFS",
}):Initialise()

local GetValue = function(x)
    if Library.Flags[x] ~= nil then
        if Library.Flags[x].Value == true then
            return true
        elseif type(Library.Flags[x].Value) == "string" or type(Library.Flags[x].Value) == "number" then
            return Library.Flags[x].Value
        else
            return false
        end
    end
end

-- // Home Window
local _, Home = Library:NewGroup({{Name = "Home", Width = 225, Icon = "home"}})

-- // Other Windows
local _, FirstWindow, SecondWindow, ThirdWindow
if CheckForMobs() then
    _, FirstWindow, SecondWindow, ThirdWindow = Library:NewGroup({
        {Name = "Farming & Collectables", Width = 225, Icon = "trending-up"},
        {Name = "Mobs & Boss Battle", Width = 225, Icon = "skull"},
        {Name = "Shops & Champs", Width = 225, Icon = "shopping-cart"}
    })
else
    _, FirstWindow, SecondWindow, ThirdWindow = Library:NewGroup({
        {Name = "Farming & Collectables", Width = 225, Icon = "trending-up"},
        {Name = "Boss Battle & KeySpams", Width = 225, Icon = "skull"},
        {Name = "Shops & Champs", Width = 225, Icon = "shopping-cart"}
    })
end

-- // Miscellaneous
local _, LocalPlyr, Misc, ___ = Library:NewGroup({
    {Name = "LocalPlayer & Others", Width = 225, Icon = "user"},
    {Name = "Miscellaneous", Width = 225, Icon = "layers"}
})
--// Home Functions
do
    Home:Label({Text = "Thanks For Using Our Script!"})
    Home:Label({Text = "If You Find Any Bugs Pls Report"})
    Home:Label({Text = "It In Our Discord!"})
    Home:Seperator()
    Home:Button({Name = "Join Our Discord",Callback = function() 
        if Invite then
            local a = Invite() 
            if type(a):lower() == "bool" then
                Library:Notification({
                    Title = "Copied To Clipboard",
                    Content = "We Copied The Discord Invite To Your Clipboard",
                    Delay = 5
                })
            else
                Library:Notification({
                    Title = "Discord Invite:",
                    Content = a,
                    Delay = 25
                })
            end
        end
    end})

end

-- // FirstWindow Functions
do
    local SelectedStat = FirstWindow:Dropdown({
        Name = "Select A Stat:",
        Options = {"Strength", "Durability", "Chakra", "Sword", "Agility", "Speed"},
        Flag = "SelectedStat",
    })

    local oldStat = ""
    FirstWindow:Toggle({
        Name = "Auto Farm",
        Default = false,
        Flag = "AutoFarmStat",
        Callback = function() 

            while GetValue("AutoFarmStat") and wait(0.5) do
                local path = game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.StatModuleClient
                local GetKey = GetValue("SelectedStat")

                if GetKey == "Agility" or GetKey == "Speed" then
                    if require(path).SelectedKey ~= nil then
                        require(path).SelectKey(game:GetService("Players").LocalPlayer.PlayerGui.Main.Hotkeys[4]) 
                        if require(path).SelectedKey ~= nil then
                            require(path).SelectKey(game:GetService("Players").LocalPlayer.PlayerGui.Main.Hotkeys[4]) 
                        end
                    end 
                    require(path).SendToServer("Speed")
                    wait(0.15)
                    require(path).SendToServer("Agility")
                    wait(0.15)
                else
                    wait(0.1)
                    if oldStat ~= GetKey then
                        SetKey(GetKey)
                        oldStat = GetKey
                    end
                    if require(path).SelectedKey == nil then
                        SetKey(GetKey)
                    end
                    require(path).ActivateKey()
                end
            end
        end
    })
   

    local float_plate = Instance.new("Part", workspace)
    float_plate.Size = Vector3.new(500, 5, 500)
    float_plate.Transparency = 1
    float_plate.Anchored = true
    float_plate.Name = StringCreate and StringCreate() or "nil"

    local Auto_Teleport = function(xa)
        if var.ChikaraFarm then return end
        local choosen_stat = GetValue("SelectedStat") or ""
        local BoolCheckr = xa
        local function auto_farm(x,y,z)
            var.MagnitudeCheck = Vector3.new(x,y,z)
            if (game.Players.LocalPlayer.Character.PrimaryPart.Position-var.MagnitudeCheck).magnitude >= var.Magnitude or BoolCheckr then
                Teleport(CFrame.new(x,y,z))
                float_plate.CFrame = CFrame.new(x,y-7,z)
            end
        end


            if game.PlaceId == 4042427666 then
                if choosen_stat == "Strength" then
                        if getstat("Strength") >= 100000000000 then auto_farm(1885, 146+(var.FarmValue), 110)
                    elseif getstat("Strength") >= 1000000000 then auto_farm(757, 145+(var.FarmValue), 945)
                    elseif getstat("Strength") >= 100000000 then auto_farm(-8, 84+(var.FarmValue), -1288)
                    elseif getstat("Strength") >= 10000000 then auto_farm(-2227, 615+(var.FarmValue), 555)
                    elseif getstat("Strength") >= 1000000 then auto_farm(-876, 47+(var.FarmValue), 196)
                    elseif getstat("Strength") >= 100000 then auto_farm(-1225, 60+(var.FarmValue), 504)
                    elseif getstat("Strength") >= 10000 then auto_farm(1374, 139+(var.FarmValue), -121)
                    elseif getstat("Strength") >= 100 then auto_farm(25, 65+(var.FarmValue), 153)
                    end
                elseif choosen_stat == "Durability" then
                        if getstat("Durability") >= 100000000000 then auto_farm(-2748, -209+(var.FarmValue), 371)
                    elseif getstat("Durability") >= 1000000000 then auto_farm(2491, 1440+(var.FarmValue), -355)
                    elseif getstat("Durability") >= 100000000 then auto_farm(-306, 61+(var.FarmValue), -1633)
                    elseif getstat("Durability") >= 10000000 then auto_farm(-1029, 109+(var.FarmValue), -913)
                    elseif getstat("Durability") >= 1000000 then auto_farm(-593, 191+(var.FarmValue), 753)
                    elseif getstat("Durability") >= 100000 then auto_farm(-49, 81+(var.FarmValue), 2050)
                    elseif getstat("Durability") >= 10000 then auto_farm(-1620, 58+(var.FarmValue), -523)
                    elseif getstat("Durability") >= 100 then auto_farm(87, 87+(var.FarmValue), 896)
                    end
                elseif choosen_stat == "Chakra" then
                        if getstat("Chakra") >= 100000000000 then auto_farm(1529, 487+(var.FarmValue), 1907)
                    elseif getstat("Chakra") >= 1000000000 then auto_farm(3085, 112+(var.FarmValue), 1124)
                    elseif getstat("Chakra") >= 250000000 then auto_farm(1059, 255+(var.FarmValue), -610)
                    elseif getstat("Chakra") >= 15000000 then auto_farm(367, -152+(var.FarmValue), -1812)
                    elseif getstat("Chakra") >= 1500000 then auto_farm(1647, 447+(var.FarmValue), 661)
                    elseif getstat("Chakra") >= 150000 then auto_farm(944, 138+(var.FarmValue), 802)
                    elseif getstat("Chakra") >= 15000 then auto_farm(1454, 144+(var.FarmValue), -568)
                    elseif getstat("Chakra") >= 500 then auto_farm(26, 71+(var.FarmValue), -108)
                    end
                elseif choosen_stat == "Agility" then
                        if getstat("Agility") >= 100000 then auto_farm(3517, 64+(var.FarmValue), 161)
                    elseif getstat("Agility") >= 10000 then auto_farm(-404, 134+(var.FarmValue), -59)
                    elseif getstat("Agility") >= 100 then auto_farm(74, 86+(var.FarmValue), 470)
                    end
                elseif choosen_stat == "Speed" then
                        if getstat("Speed") >= 100000 then auto_farm(3517, 64+(var.FarmValue), 161)
                    elseif getstat("Speed") >= 10000 then auto_farm(-404, 134+(var.FarmValue), -59)
                    elseif getstat("Speed") >= 100 then auto_farm(-76, 66+(var.FarmValue), -488)
                    end
                end
                --//dem 2
            elseif game.PlaceId == 5113678354 then
                if choosen_stat == "Strength" then
                        if getstat("Strength") >= 100000000000000000 then auto_farm(2127, 424+(var.FarmValue), -1739)
                    elseif getstat("Strength") >= 1000000000000000 then auto_farm(824, 245+(var.FarmValue), -465)
                    elseif getstat("Strength") >= 100000000000000 then auto_farm(1679, -302+(var.FarmValue), 227)
                    elseif getstat("Strength") >= 1000000000000 then auto_farm(156, 61+(var.FarmValue), 718)
                    end
                elseif choosen_stat == "Durability" then
                        if getstat("Durability") >= 100000000000000000 then auto_farm(-762, 61+(var.FarmValue), 31)
                    elseif getstat("Durability") >= 1000000000000000 then auto_farm(1045, 266+(var.FarmValue), -1989)
                    elseif getstat("Durability") >= 100000000000000 then auto_farm(3473, 610+(var.FarmValue), -128)
                    elseif getstat("Durability") >= 1000000000000 then auto_farm(1807, 304+(var.FarmValue), 1391)
                    end
                elseif choosen_stat == "Chakra" then
                        if getstat("Chakra") >= 100000000000000000 then auto_farm(2999, 1860+(var.FarmValue), 830)
                    elseif getstat("Chakra") >= 1000000000000000 then auto_farm(-1474, 1879+(var.FarmValue), 1413)
                    elseif getstat("Chakra") >= 100000000000000 then auto_farm(2588, 86+(var.FarmValue), 894)
                    elseif getstat("Chakra") >= 1000000000000 then auto_farm(187, 71+(var.FarmValue), 1415)
                    end
                end
                --//dem 3
            elseif game.PlaceId == 5113680396 then
                if choosen_stat == "Strength" then
                        if getstat("Strength") >= 999999999999999849005056 then auto_farm(1711, -310+(var.FarmValue), 1815)
                    elseif getstat("Strength") >= 99999999999999991611392 then auto_farm(3644, 1089+(var.FarmValue), 1436)
                    elseif getstat("Strength") >= 1000000000000000000000 then auto_farm(3238, 82+(var.FarmValue), -1798)
                    elseif getstat("Strength") >= 100000000000000000000 then auto_farm(737, 1117+(var.FarmValue), 2136)
                    elseif getstat("Strength") >= 1000000000000000000 then auto_farm(-1113, 302+(var.FarmValue), -771)
                    end
                elseif choosen_stat == "Durability" then
                        if getstat("Durability") >= 999999999999999849005056 then auto_farm(3309, 122+(var.FarmValue), -353)
                    elseif getstat("Durability") >= 99999999999999991611392 then auto_farm(1224, 103+(var.FarmValue), -2259)
                    elseif getstat("Durability") >= 1000000000000000000000 then auto_farm(366, 78+(var.FarmValue), -952)
                    elseif getstat("Durability") >= 100000000000000000000 then auto_farm(1699, 1016+(var.FarmValue), -725)
                    elseif getstat("Durability") >= 1000000000000000000 then auto_farm(4907, 1181+(var.FarmValue), -1248)
                    end
                elseif choosen_stat == "Chakra" then
                        if getstat("Chakra") >= 999999999999999849005056 then auto_farm(2128, 102+(var.FarmValue), -1186)
                    elseif getstat("Chakra") >= 99999999999999991611392 then auto_farm(-390, 328+(var.FarmValue), 1282)
                    elseif getstat("Chakra") >= 1000000000000000000000 then auto_farm(3852, 471+(var.FarmValue), 153)
                    elseif getstat("Chakra") >= 100000000000000000000 then auto_farm(-1617, 318+(var.FarmValue), 181)
                    elseif getstat("Chakra") >= 1000000000000000000 then auto_farm(366, -134+(var.FarmValue), -230)
                    end
                end
                --//dem 4
            elseif game.PlaceId == 5445525505 then
                if choosen_stat == "Strength" then
                        if getstat("Strength") >= 1000000000000000019884624838656 then auto_farm(-1036, 362+(var.FarmValue), 660)
                    elseif getstat("Strength") >= 99999999999999991433150857216 then auto_farm(443, 111+(var.FarmValue), -1593)
                    elseif getstat("Strength") >= 999999999999999875848601600 then auto_farm(-3273, 123+(var.FarmValue), -162)
                    elseif getstat("Strength") >= 99999999999999987584860160 then auto_farm(-985, 102+(var.FarmValue), -1395)
                    end
                elseif choosen_stat == "Durability" then
                        if getstat("Durability") >= 1000000000000000019884624838656 then auto_farm(-2011, 109+(var.FarmValue), -1257)
                    elseif getstat("Durability") >= 99999999999999991433150857216 then auto_farm(74, 191+(var.FarmValue), 450)
                    elseif getstat("Durability") >= 999999999999999875848601600 then auto_farm(1281, 209+(var.FarmValue), 1464)
                    elseif getstat("Durability") >= 99999999999999987584860160 then auto_farm(-2579, 275+(var.FarmValue), 417)
                    end
                elseif choosen_stat == "Chakra" then
                        if getstat("Chakra") >= 1000000000000000019884624838656 then auto_farm(-578, 67+(var.FarmValue), 2223)
                    elseif getstat("Chakra") >= 99999999999999991433150857216 then auto_farm(63, 164+(var.FarmValue), 2351)
                    elseif getstat("Chakra") >= 999999999999999875848601600 then auto_farm(1248, 648+(var.FarmValue), -945)
                    elseif getstat("Chakra") >= 99999999999999987584860160 then auto_farm(-1025, 80+(var.FarmValue), 1593)
                    end
                end
                --//dem 5
            elseif game.PlaceId == 6479720355 then
                if choosen_stat == "Strength" then
                        if getstat("Strength") >= 99999999999999997748809823456034029568 then auto_farm(2240, 99+(var.FarmValue), 2423)
                    elseif getstat("Strength") >= 999999999999999894846684784341549056 then auto_farm(-2580, 451+(var.FarmValue), -132)
                    elseif getstat("Strength") >= 99999999999999996863366107917975552 then auto_farm(3273, 56+(var.FarmValue), 1047)
                    elseif getstat("Strength") >= 999999999999999945575230987042816 then auto_farm(3411, 1093+(var.FarmValue), -2225)
                    elseif getstat("Strength") >= 99999999999999987351763694911488 then auto_farm(-2234, 202+(var.FarmValue), -2274)
                    end
                elseif choosen_stat == "Durability" then
                        if getstat("Durability") >= 99999999999999997748809823456034029568 then auto_farm(652, 177+(var.FarmValue), -2284)
                    elseif getstat("Durability") >= 999999999999999894846684784341549056 then auto_farm(2537, 378+(var.FarmValue), -2704)
                    elseif getstat("Durability") >= 99999999999999996863366107917975552 then auto_farm(3560, -186+(var.FarmValue), 422)
                    elseif getstat("Durability") >= 999999999999999945575230987042816 then auto_farm(576, 103+(var.FarmValue), 2852)
                    elseif getstat("Durability") >= 99999999999999987351763694911488 then auto_farm(-3204, 42+(var.FarmValue), 1764)
                    end
                elseif choosen_stat == "Chakra" then
                        if getstat("Chakra") >= 99999999999999997748809823456034029568 then auto_farm(-291, -298+(var.FarmValue), 615)
                    elseif getstat("Chakra") >= 999999999999999894846684784341549056 then auto_farm(2384, 549+(var.FarmValue), 246)
                    elseif getstat("Chakra") >= 99999999999999996863366107917975552 then auto_farm(295, -119+(var.FarmValue), -807)
                    elseif getstat("Chakra") >= 999999999999999945575230987042816 then auto_farm(1373, -592+(var.FarmValue), 275)
                    elseif getstat("Chakra") >= 99999999999999987351763694911488 then auto_farm(1544, 281+(var.FarmValue), 1101)
                    end
                elseif choosen_stat == "Agility" then
                    if getstat("Agility") >= 1000000 then auto_farm(-170, 103+(var.FarmValue), 935)
                    end
                elseif choosen_stat == "Speed" then
                    if getstat("Speed") >= 1000000 then auto_farm(1237, -271+(var.FarmValue), -943)
                    end
                end
                --//dem 6
            elseif game.PlaceId == 9386500519 then
                if choosen_stat == "Strength" then
                        if getstat("Strength") >= 99999999999999981277195531206711524196352 then auto_farm(-863, 369+(var.FarmValue), 2996)
                    elseif getstat("Strength") >= 999999999999999939709166371603178586112 then auto_farm(-1230, -243+(var.FarmValue), -781)
                    end
                elseif choosen_stat == "Durability" then
                        if getstat("Durability") >= 99999999999999981277195531206711524196352 then auto_farm(-1232, 657+(var.FarmValue), -2676)
                    elseif getstat("Durability") >= 999999999999999939709166371603178586112 then auto_farm(3519, 166+(var.FarmValue), 3654)
                    end
                elseif choosen_stat == "Chakra" then
                        if getstat("Chakra") >= 99999999999999981277195531206711524196352 then auto_farm(2369, 244+(var.FarmValue), -85)
                    elseif getstat("Chakra") >= 999999999999999939709166371603178586112 then auto_farm(318, 316+(var.FarmValue), 611)
                    end
                end
            end 
        
    end



    local AutoTeleport = FirstWindow:Toggle({
        Name = "Auto Teleport",
        Default = false,
        Flag = "AutoTeleport",
        Callback = function(x)
            if x then
                Noclip[1] = true
                while GetValue("AutoTeleport") and wait(0.1) do
                    Auto_Teleport(false)
                    game:FindService("RunService").Heartbeat:Wait()
                end
            else
                Noclip[1] = false
                float_plate.CFrame = CFrame.new(0,5000,0)
            end
        end
    })

    FirstWindow:Slider({
        Name = "Set Teleport Height",
        Min = -100,
        Max = 100,
        Increment = 1,
        Default = 0,
        Flag = "STH_",
        Callback = function(x)
            var.FarmValue = x
            if GetValue("AutoTeleport") then
                Auto_Teleport(true)
            end
        end
    })

    FirstWindow:Slider({
        Name = "Set Magnitude",
        Min = 10,
        Max = 500,
        Increment = 1,
        Default = 0,
        Flag = "SM__",
        Callback = function(x)
            var.Magnitude = x
        end
    })

    -- // Seperator
    FirstWindow:Seperator()

    FirstWindow:Toggle({
        Name = "Farm Chikara Chards",
        Default = false,
        Flag = "ChikaraFarm",
        Callback = function(x)
            var.ChikaraFarm = x
            while GetValue("ChikaraFarm") and wait(1) do
                for i,v in pairs(game:GetService("Workspace").MouseIgnore:GetChildren()) do
                    if GetValue("ChikaraFarm") and v.Name == "ChikaraCrate" and v:FindFirstChild("ClickBox") then 
                        local x = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
                        var.ChikaraFarm = true
                        Noclip[2] = true
                        float_plate.CFrame = v.ClickBox.CFrame + Vector3.new(0,-18,0)
                        Teleport(v.ClickBox.CFrame + Vector3.new(0,-10,0))
                        pcall(function()
                            repeat wait(0.1) game:FindService("RunService").Heartbeat:Wait()
                                fireclickdetector(v.ClickBox.ClickDetector)
                            until v.ClickBox == nil or v.ClickBox.ClickDetector == nil
                        end)

                        Teleport(x)
                        Noclip[2] = false
                        var.ChikaraFarm = false
                        wait(4)
                    end
                end
            end
        end
    })

    FirstWindow:Button({
        Name = "Find Devil Fruit",
        Callback = function()
            local check = false
            for i,v in pairs(game:GetService("Workspace").MiscModels:GetChildren()) do
                if v.Name == "Model" and v:FindFirstChild("ClickBox") and v.ClickBox:FindFirstChild("ClickDetector") then
                    local v = v.ClickBox.ClickDetector
                    fireclickdetector(v)
                    check = true break
                end
            end
            if not check then 
                Library:Notification({
                    Title = "Devil Fruit Not Found!",
                    Content = "You Have To Wait Until One Spawns Or Check Another Server.",
                    Delay = 10
                })
            end
        end
    })
    
    local DragonOrbFunc = function()
        for i,v in pairs(game:GetService("Workspace").MouseIgnore:GetChildren()) do
            if v.Name == "Model" and v:FindFirstChild("ClickPart")  then
                fireclickdetector(v.ClickPart.ClickDetector)
                return
            end
        end
        Library:Notification({
            Title = "No Dragon Orbs Found!",
            Content = "There Are No Dragon Orbs Found, Pls Be Patient And Wait For Another One To Spawn.",
            Delay = 5
        })
    end
    FirstWindow:Toggle({
        Name = "Farm Dragon Orbs",
        Default = false,
        Flag = "OrbFarm",
        Callback = function()
            while GetValue("OrbFarm") and wait(0.5) do
                DragonOrbFunc()
            end
        end
    })



    -- // Seperator
    FirstWindow:Seperator()

    FirstWindow:Dropdown({
        Name = "Select A NPC:",
        Flag = "SelectedNPC",
        Options = NPCSNames,
    })

    FirstWindow:Button({
        Name = "Talk To The NPC",
        Callback = function()
            local a = GetValue("SelectedNPC")
            if a then
                local x = pcall(function()
                    fireclickdetector(game:GetService("Workspace").NPCs[a].ClickBox.ClickDetector)
                end)
                if not x then
                    Library:Notification({
                        Title = "Could Not Find NPC!",
                        Content = "This NPC Has Not Spawned In The Game Yet, Pls Fly Around And Try Again.",
                        Delay = 10
                    })
                end
            end
        end
    })

end

-- // SecondWindow Functions
do

    local JoinBoss = SecondWindow:Toggle({
        Name = "Auto Join Boss Battle",
        Default = false,
        Flag = "JoinBattle",
        Callback = function()
            while GetValue("JoinBattle") and wait(0.85) do
                fireclickdetector(game:GetService("Workspace").BossArena.ClickBox.ClickDetector)
            end
        end
    })


    local StopFollow = false
    local boss_freeze = function()
        local Human = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid", true)
        local pos = Human and Human.RootPart and Human.RootPart.CFrame
        local pos1 = workspace.CurrentCamera.CFrame
        local char = game:GetService("Players").LocalPlayer.Character
        if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid"):ChangeState(15) end
        char:ClearAllChildren()
        local newChar = Instance.new("Model")
        newChar.Parent = workspace
        game:GetService("Players").LocalPlayer.Character = newChar
        wait()
        game:GetService("Players").LocalPlayer.Character = char
        newChar:Destroy()
        wait(1)
        spawn(function()
            game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
            wait(1)
            --game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").RootPart.CFrame = pos
            game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").RootPart.CFrame = game:GetService("Workspace").BossArena.PlayerSpawn.CFrame
            workspace.CurrentCamera.CFrame = pos1
        end)        
    end

    local StartFreeze = function()
        for i,v in pairs(game:GetService("Workspace").BossArena:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                boss_saved_pos = v.HumanoidRootPart.Position
                wait(0.2)
                pcall(function()
                    if boss_saved_pos ~= v.HumanoidRootPart.Position then
                        StopFollow = true
                        local count = 0
                        for i=1,50 do wait(0.05)
                            pcall(function()
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                            end)
                        end
                        pcall(function()
                            boss_freeze()
                        end)
                        wait(5)
                        StopFollow = false
                        return
                    end
                end)
            end
        end
    end
    SecondWindow:Toggle({
        Name = "Auto Freeze Boss",
        Default = false,
        Flag = "FreezeBoss",
        Callback = function()
            local boss_saved_pos
            while GetValue("FreezeBoss") and wait(0.1) do
                StartFreeze()
            end
        end
    })

    local StopFollowCheck = false
    local FollowFunc = function()
        for i,v in pairs(game:GetService("Workspace").BossArena:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") then
                if StopFollow then wait(0.1) return end
                pcall(function()
                    if (game:GetService("Players").LocalPlayer.Character.PrimaryPart.Position - v.HumanoidRootPart.Position).magnitude >= var.FollowMagnitude then
                        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkToPoint = v.HumanoidRootPart.Position
                        local BossPos = game:GetService("Workspace").BossArena[v.Name].HumanoidRootPart.Position
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, BossPos)
                        StopFollowCheck = false
                    elseif StopFollowCheck == false then
                        StopFollowCheck = true
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,"W",false,game)
                        wait(0.05)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false,"W",false,game)
                    end
                end)
            end
        end
    end
    SecondWindow:Toggle({
        Name = "Auto Follow Boss",
        Default = false,
        Flag = "FollowBoss",
        Callback = function()
            while GetValue("FollowBoss") and wait() do
                FollowFunc()
            end
        end
    })

    SecondWindow:Slider({
        Name = "Set Follow Magnitude",
        Min = 30,
        Max = 200,
        Increment = 1,
        Default = 50,
        Flag = "SFM_",
        Callback = function(x)
            var.FollowMagnitude = x
        end
    })

    if CheckForMobs() then

        SecondWindow:Seperator()

        local mob_names = {}
        for i,v in pairs(game:GetService("Workspace").Scriptable.SpawnedMobs:GetChildren()) do
            if not table.find(mob_names,v.Name) then
                table.insert(mob_names,v.Name)
            end
        end
        local SelectedMob = SecondWindow:Dropdown({
            Name = "Select A Mob",
            Flag = "SelectedMob",
            Options = mob_names,
        })


        local PosMobFarm,AimLockMob = 0,false
        local mob_farm = function(xa)
            local MobName = GetValue("SelectedMob")
            if MobName == nil then return end
            if PosMobFarm == nil then PosMobFarm = 0 end

            var.MobFrame = {}
            local TP_mob_dist = math.huge

            for i,v in pairs(game:GetService("Workspace").Scriptable.SpawnedMobs:GetChildren()) do
                if v.Name == MobName and tostring(v.PrimaryPart) == "Hitpart" then
                    pcall(function()
                        local check = string.find(v.Hitpart.Info.Frame.Health.Text, "0/") 
                        if check ~= 1 then -- 1 is dood 2 is nog nie dood en nil is dat de hitpart nog niet is ingeladen
                            pcall(function()
                                local x = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Hitpart.Position).magnitude
                                if x < TP_mob_dist then 
                                    TP_mob_dist = x 
                                    var.MobFrame = {v.Hitpart.Position.X, v.Hitpart.Position.Y, v.Hitpart.Position.Z + PosMobFarm}
                                    wait()
                                end
                            end)
                        end
                    end)
                end
            end

            if var.MobFrame[3] == nil then return end

            if AimLockMob then
                    for i = 1,10 do task.wait()
                        local krt = Vector3.new(var.MobFrame[1],var.MobFrame[2],var.MobFrame[3]-PosMobFarm)
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, krt)
                    end
            end

            local x = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - Vector3.new(unpack(var.MobFrame))).magnitude
            if x >= 20 or xa then 
                Teleport(CFrame.new(unpack(var.MobFrame)))
            end
        end

        SecondWindow:Toggle({
            Name = "Auto Farm Mob",
            Default = false,
            Flag = "MobFarm",
            Callback = function()
                while GetValue("MobFarm") and wait(0.1) do
                    mob_farm(false)
                end
            end
        })

        SecondWindow:Toggle({
            Name = "Auto AimLock",
            Default = false,
            Flag = "MobAimLock",
            Callback = function(x)
                AimLockMob = x
            end
        })
        
        SecondWindow:Slider({
            Name = "Distance Between The Mob",
            Min = -25,
            Max = 25,
            Flag = "DBTM_",
            Increment = 1,
            Default = 5,
            Callback = function(x)
                PosMobFarm = x
                if GetValue("MobFarm") then
                    mob_farm(true)
                end
            end
        })
    end

    SecondWindow:Seperator()

    SecondWindow:Toggle({
        Name = "Spam Keys",
        Default = false,
        Flag = "KeybindSpammer",
        Callback = function()
            while GetValue("KeybindSpammer") and wait() do
                local VIM = game:GetService("VirtualInputManager")
                for _, v in pairs(var.KeySpam) do
                    if not GetValue("KeybindSpammer") then return end
                    local v = string.upper(v)
                    if table.find({"Z","X","C","V"},v) then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,v,false,game)
                        wait()
                        game:GetService("VirtualInputManager"):SendKeyEvent(false,v,false,game)
                    elseif not table.find({"Z","X","C","V"},v) then
                        local args = {[1] = "UseP",[2] = {["External"] = {["MouseP"] = CFrame.new(nil,nil,nil)},
                            ["Key"] = v}}
                        game:GetService("ReplicatedStorage").RSPackage.Events.GeneralFunction:InvokeServer(unpack(args))
                    end
                    wait(1)
                end
            end
        end
    })

    local oldKey = "Unknown"
    SecondWindow:Keybind({
        Name = "Add/Remove Key",
        Default = Enum.KeyCode.Unknown,
        Flag = "AddRemoveKey",
        Callback = function()
            if GetValue("AddRemoveKey") ~= oldKey then
                oldKey = GetValue("AddRemoveKey")
                local key = tostring(GetValue("AddRemoveKey"))
                local index = table.find(var.KeySpam,key)
                if (index) then
                    table.remove(var.KeySpam,index)
                    Library:Notification({
                        Title = "Removed Key!",
                        Content = "The Key "..key.." Is Removed From The List.",
                        Delay = 3
                    })
                else
                    table.insert(var.KeySpam,key)
                    Library:Notification({
                        Title = "Added Key!",
                        Content = "The Key "..key.." Is Added To The list.",
                        Delay = 3
                    })
                end
            end
        end
    })


    SecondWindow:Button({
        Name = "View Key List",
        Callback = function()
            table.sort(var.KeySpam)
            Library:Notification({
                Title = "Selected Keys:",
                Content = table.concat(var.KeySpam,", "),
                Delay = 5
            })
        end
    })

end

-- // Shop - Champs
do
    local specialKeyReq,buy_tbl = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.PlayerDataClient).Data.SavedSpecialsKey,{}
    for i,_ in pairs(specialKeyReq) do
        if not table.find(buy_tbl,i) then
            if i ~= "Quirks" then
                table.insert(buy_tbl,i)
            else
                table.insert(buy_tbl,"Quirk")
            end
        end
    end
    local dropdown_power, special_select
    ThirdWindow:Dropdown({
        Name = "Select a special:",
        Options = buy_tbl,
        Flag = "ChoosenSpeciall",
        Callback = function(x)
            special_select = x
            local tbl = {}
            --[[
                --voor de special_select namen te zoeken
                local a = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.PlayerDataClient).Data.SavedSpecialsKey
                for i = 1,10 do rconsoleprint("\n") end
                for i,_ in pairs(a) do
                    rconsoleprint(i.."\n")    
                end
            --]]
            if special_select == "Stands" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.StandsData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Kagunes" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.KaguneData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Fruits" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.FruitData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Quirk" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.QuirkData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Grimoires" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.GrimoireData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "BreathStyles" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.BreathStylesData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Bloodlines" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.BloodlinesData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Arnament" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.ArnamentData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Pyrokinesis" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.PyrokinesisData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Titan" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.TitanData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "CursedTechniques" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.CursedTechniquesData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "DemonArt" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.DemonArtData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "Nen" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.NenData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            elseif special_select == "MagicRelease" then
                local a = game:GetService("ReplicatedStorage").RSPackage.Modules.MagicReleaseData
                for i,v in pairs(require(a).Items) do
                    if v.ShopOnly == nil then
                        table.insert(tbl, v.Name)
                    end
                end
            end
            dropdown_power:Refresh(tbl,true)
        end
    })

    dropdown_power = ThirdWindow:Dropdown({
        Name = "Select A Power:",
        Options = {"Select A","Special First!"},
        Flag = "SelectedPowerBuy",

    })

    local function check_buy_special()
        local a = game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Specials.Container.Buttons[special_select].Frame
        for i,v in pairs(a:GetChildren()) do
            if v:IsA("TextLabel") and v.Name ~= "Instructions" then
                if v.Text == GetValue("SelectedPowerBuy") then
                    return true
                else
                    return false
                end
            end
        end
        return true
    end
    local function buy_special(v) -- "Grimoire"
        if v == nil then 
            return
        end
        local a = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.SpecialsClient)
        local x,y = game:GetService("ReplicatedStorage").RSPackage.Events.GeneralFunction:InvokeServer("SOb", v)
        
        if not table.find({x,y}, nil) then
            a.OpenCrate(x,v)
        end
    end

    local BuyCheck = false
    local ABSToggleFunc = function() end
    local ABSTOGGLE = ThirdWindow:Toggle({
        Name = "Auto Buy Special",
        Default = false,
        Flag = "BuyToggle",
        Callback = function(x)
            if x and BuyCheck == false then
                BuyCheck = true
                Library:Notification({
                    Title = "How Does Auto Buy Work???",
                    Content = "This Function Will Keep Buying Specials Until You Collected What You Want!",
                    Delay = 25
                })
            end
            while GetValue("BuyToggle") and wait(0.1) do
                if check_buy_special() == false then
                    buy_special(special_select)
                else
                    ABSToggleFunc()
                    wait("0."..math.random(3,9))
                end
            end
        end
    })
    ABSToggleFunc = function() ABSTOGGLE:Set(false) end
    ThirdWindow:Seperator() 

    local AuraChests = {} 
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Store.Container.Frames.Aura:GetChildren()) do 
        pcall(function()
            if v:IsA("Frame") and not table.find(AuraChests,v.Name) then 
                table.insert(AuraChests,v.Name)
            end
        end)
    end 

    ThirdWindow:Dropdown({
        Name = "Select A Chest:",
        Options = AuraChests,
        Flag = "BuyChestDropdown",
    })


    ThirdWindow:Toggle({
        Name = "Auto Buy Chest",
        Default = false,
        Flag = "ChestToggle",
        Callback = function(x)
            while GetValue("ChestToggle") and wait(0.7) do
                spawn(function()
                    local ChestName = GetValue("BuyChestDropdown")
                    local l__RSPackage__3 = game:GetService("ReplicatedStorage").RSPackage
                    -- local v14 = require(l__RSPackage__3.Modules.AuraInfo)
                    local v15 = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.AuraHandler)
                    
                    if type(ChestName) == "string" then
                        local v48, v49, v50, v51 = l__RSPackage__3.Events.GeneralFunction:InvokeServer("OpenAura", ChestName)
                        if not v48 then
                            v15.new(v49)
                        end
                    end
                end)
            end
        end
    })

    ThirdWindow:Seperator()

    local AllChampNames = {}
    for i, v in pairs(require(game:GetService("ReplicatedStorage").RSPackage.Modules.ChampionsData).Items) do
        table.insert(AllChampNames,v.Name)
    end
    table.sort(AllChampNames)
    local SelectedChampOboard,ChampCheck = 1
    ThirdWindow:Dropdown({
        Name = "Select A Champ:",
        Options = AllChampNames,
        Flag = "SelectedChamp",
        Callback = function(x)
            ChampCheck = x
            local a = require(game:GetService("ReplicatedStorage").RSPackage.Modules.ChampionsData)
            for i, v in pairs(a.Items) do
                if v.Name == ChampCheck and v.NoBoard == nil then 
                    if v.Board == "ChampionRarityBoard2" then
                        SelectedChampOboard = 2
                    elseif v.Board == "ChampionRarityBoard3" then
                        SelectedChampOboard = 3
                    elseif v.Board == "ChampionRarityBoard4" then
                        SelectedChampOboard = 4
                    elseif v.Board == "ChampionRarityBoard5" then
                        SelectedChampOboard = 5
                    else
                        SelectedChampOboard = 1
                    end
                end
            end
        end
    })

    local function buy_champs(n)

            local a = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.SpecialsClient)
            local x = game:GetService("ReplicatedStorage").RSPackage.Events.GeneralFunction:InvokeServer("ChOb", SelectedChampOboard)
            local z = game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.SpecialObtain.Container.CurrentObtain.Value
            -- print(z)
            if z == nil then z = "Champions" end
            if not table.find({x,z},nil) then
                if x == "A" then
                    GameNotify("your broke af, go grind more chikara",1)
                elseif x == "B" then
                    GameNotify("we cant buy you more because your invertory is full",1)
                elseif type(x) == "table" then
                    a.OpenCrate(x[1],z)
                else
                    pcall(function()
                        a.OpenCrate(x,z)
                    end)
                end
            end


    end

    local ABCToggleFunc = function() end
    local ABCToggle = ThirdWindow:Toggle({
        Name = "Auto Buy Champs",
        Default = false,
        Flag = "ChampToggle",
        Callback = function(x)
            while GetValue("ChampToggle") and wait(0.1) do 
                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Champions.Container.List:GetDescendants()) do 
                    if GetValue("ChampToggle") and v.Name == "ChampionName" and v.Parent.ClassName == "Frame" and v.Text == GetValue("SelectedChamp") then 
                        local a = game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Champions.Container.Details.Lock.TextLabel.Text
                        if a == "Lock" then
                            local b = game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Champions.Container.Details.Lock
                            for _,f in next,getconnections(b.MouseButton1Click) do
                                f.Function()
                            end
                        end
                        ABCToggleFunc()
                        return
                    end
                end
                buy_champs(SelectedChampOboard)
            end
        end
    })
    ABCToggleFunc = function() ABCToggle:Set(false) end


    local function sell_champs()
        local a = game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Champions.Container.List
        local count = 0
        for i,v in pairs(a:GetChildren()) do
            count = count + 1
        end
        count = count -1 -- UIGridLayout telt nie mee
        for i = 1, count do 
            local x = game:GetService("ReplicatedStorage").RSPackage.Events.GeneralFunction:InvokeServer("isChampionLocked", i) -- veranderd
            if x == false then -- niet locked
                for _,f in next,getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Champions.Container.List[tostring(i)].Container.View.MouseButton1Click) do
                    f:Function()
                end
                wait(0.2)
                local r = game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Champions.Container.Details.ChampionName.Text
                if r ~= GetValue("SelectedChamp") then 
                    for _,f in next,getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.Category.Frames.Champions.Container.Details.Confirm.Yes.MouseButton1Click) do
                        f.Function()
                    end
                end
            end
            game:FindService("RunService").Heartbeat:Wait()
        end
    end

    ThirdWindow:Toggle({
        Name = "Sell Unlocked Champs",
        Default = false,
        Flag = "ChampSellToggle",
        Callback = function()
            while GetValue("ChampSellToggle") and wait() do
                pcall(function()
                    sell_champs()
                end)
            end
        end
    })


end

-- // LocalPlayer & Others
do
    local UpdateHumanFunc = function() end

    LocalPlyr:Slider({
        Name = "WalkSpeed",
        Min = 16,
        Max = 500,
        Increment = 1,
        Default = game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed or 50,
        Flag = "WalkSpeed_",
        Callback = function() UpdateHumanFunc() end
    })


    LocalPlyr:Slider({
        Name = "JumpPower",
        Min = 50,
        Max = 500,
        Increment = 1,
        Default = game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower or 50 ,
        Flag = "JumpPower_",
        Callback = function() UpdateHumanFunc() end
    })
    wait()
    UpdateHumanFunc = function() 
        if type(GetValue("WalkSpeed_")) ~= "number" then return end
        pcall(function()
            game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = GetValue("WalkSpeed_")
            game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = GetValue("JumpPower_")
        end)
    end
    spawn(function() while wait(1) do UpdateHumanFunc() end end)

    LocalPlyr:Slider({
        Name = "Fly Speed",
        Min = 0,
        Max = 1200,
        Increment = 1,
        Default = 0,
        Flag = "FlySpeed_",
        Callback = function(x)
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.BodyPosition.D = 1250-x
            end)
        end
    })

    LocalPlyr:Toggle({
        Name = "Conceal Power",
        Default = false,
        Flag = "ConCealPower",
        Callback = function(x)
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.TotalPower.Enabled = not x
            end)
        end
    })

    local infinjump = game:GetService("UserInputService").JumpRequest:connect(function() end)
    LocalPlyr:Toggle({
        Name = "Infinity Jump",
        Default = false,
        Flag = "InfinityJump_",
        Callback = function(x)
            if x == true then
                infinjump = game:GetService("UserInputService").JumpRequest:connect(function()
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end)
            elseif x == false then
                infinjump:Disconnect()
            end
        end
    })

    LocalPlyr:Toggle({
        Name = "Return To Your Death",
        Default = false,
        Flag = "DeathReturn",
        Callback = function(x)
            ReturnDeath(x)
        end
    })

    LocalPlyr:Toggle({
        Name = "Noclip (CanCollide)",
        Default = false,
        Flag = "BasicNoclip",
        Callback = function(x)
            Noclip[3] = x
        end
    })

    local CNIF
    LocalPlyr:Toggle({
        Name = "Camera Noclip/Inf Zoom",
        Default = false,
        Flag = "CNIF_",
        Callback = function(x)
            CNIF = x
            for useless, garbage in next,getgc() do
                if getfenv(garbage).script == game.Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper and typeof(garbage) == "function" then
                    for number, value in next, getconstants(garbage) do
                        if tonumber(value) == 0.25 and CNIF then
                            setconstant(garbage,number,0)
                            game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = math.huge
                        elseif tonumber(value) == 0 and not CNIF then
                            setconstant(garbage,number,0.25)
                            game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = 70
                        end
                    end
                end
            end
        end
    })

    LocalPlyr:Seperator()

    -- //
    local TargetName,updateFuncText
    local TextBoxVar TextBoxVar = LocalPlyr:TextBox({
        Name = "Other Players Name",
        Default = "",
        TextDisappear = false, -- verwijderd na da je klaar bent met tippe
        Flag = "OtherPlayerName",
        Callback = function(x)
            local a = string.lower(x)
            for _,v in pairs(game:GetService("Players"):GetChildren()) do 
                if v.Name ~= game.Players.LocalPlayer.Name then
                    if string.match(string.lower(v.Name), a) then
                        TargetName = v.Name
                        pcall(function()
                        updateFuncText(v.Name)
                        end)
                    end
                end
		    end
        end

    })
    updateFuncText = function(x) TextBoxVar:Set(x) end

    LocalPlyr:Button({
        Name = "Teleport To Player",
        Callback = function()
           Teleport(game.Players[TargetName].Character.HumanoidRootPart.CFrame)
        end
    })

    LocalPlyr:Seperator()

    table.sort(Dimensions)

    LocalPlyr:Dropdown({
        Name = "Goto Dimension:",
        Options = Dimensions,
        Callback = function(value)
            for _, v in pairs(game:GetService("Workspace").DimensionPortal:GetChildren()) do
                if v.Name == value and v:FindFirstChild("ClickBox") then
                    Teleport(v.ClickBox.CFrame + Vector3.new(0, 10, 0))
                    fireclickdetector(v.ClickBox.ClickDetector)
                    return
                end
            end
            Library:Notification({
                Title = "Could Not Locate The Portals!",
                Content = "The Dimension Portals Are Not Spawned In Yet Pls Fly Around So We Can Locate It For You.",
                Delay = 25
            })
        end
    })

    LocalPlyr:Dropdown({
        Name = "Goto Another Dimensions:",
        Options = {"Inferno", "Akaza","Christmas boss","Christmas boss 2", "Corrupted Ice Dungeon", "Overlord Dungeon"},
        Callback = function(v)
            if v == "Inferno" then
                game:GetService("TeleportService"):Teleport(6479693773, game:GetService("Players").LocalPlayer)
            elseif v == "Akaza" then
                game:GetService("TeleportService"):Teleport(7220992373, game:GetService("Players").LocalPlayer)
            elseif v == "Christmas boss" then
                game:GetService("TeleportService"):Teleport(6138035804, game:GetService("Players").LocalPlayer)
            elseif v == "Christmas boss 2" then
                game:GetService("TeleportService"):Teleport(8436368941, game:GetService("Players").LocalPlayer)
            elseif value == "Corrupted Ice Dungeon" then
                game:GetService("TeleportService"):Teleport(7220975160, game:GetService("Players").LocalPlayer)
            elseif value == "Overlord Dungeon" then
                game:GetService("TeleportService"):Teleport(7220986579, game:GetService("Players").LocalPlayer)
            end
        end
    })

    

   
end

-- // Miscellaneous
do


    Misc:Button({
        Name = "FPS Booster",
        Callback = function()
            
            local lighting = game:GetService('Lighting')
            lighting.GlobalShadows = false
            lighting.FogEnd = 9e9
            lighting.Brightness = 0
            --sethiddenproperty(lighting, 'Technology', Enum.Technology.Compatbility)
            settings().Rendering.QualityLevel = "Level01"
            UserSettings():GetService("UserGameSettings").SavedQualityLevel = 1 
            local classes = {
                Part = {
                    Material = 'Plastic';
                    Reflectance = 0;
                };
                Fire = { Enabled = false; };
                Decal = { Transparency = 1; };
                SpecialMesh = { TextureId = 0; };
                Shirt = { ShirtTemplate = 0; };
                Pants = { PantsTemplate = 0; };
                ShirtGraphic = { Graphic = 0; };
            }
            do 
                classes.MeshPart = classes.Part
                classes.WedgePart = classes.Part
                
                classes.Texture = classes.Decal
                
                local fireClass = classes.Fire
                classes.PointLight = fireClass
                classes.SpotLight = fireClass
                classes.ParticleEmitter = fireClass
                classes.Trail = fireClass
                classes.SurfaceLight = fireClass
                classes.Smoke = fireClass
                classes.Sparkles = fireClass
                classes.BlurEffect = fireClass
                classes.SunRaysEffect = fireClass
                classes.ColorCorrectionEffect = fireClass
                classes.BloomEffect = fireClass
                classes.DepthOfFieldEffect = fireClass
            end

            -- comment this whole section from here
            local cleanup = {} 
            workspace.DescendantAdded:Connect(function(v) 
                cleanup[#cleanup] = v
            end)

            task.spawn(function() 
                while (true) do 
                    task.wait(10) -- takes 10 seconds to cleanup new instances, increase if needed
                    
                    for _, v in ipairs(cleanup) do 
                        local newVals = classes[v.ClassName]
                        if ( v.Parent and newVals ) then
                            for prop, val in pairs(newVals) do 
                                v[prop] = val 
                            end
                        end
                    end
                    table.clear(cleanup)
                    
                end
            end)
            -- to here if you don't think its necessary

            for _, v in ipairs(workspace:GetDescendants()) do 
                local newVals = classes[v.ClassName]
                if ( newVals ) then
                    for prop, val in pairs(newVals) do 
                        v[prop] = val 
                    end
                end
            end
        end
    })

    Misc:Button({
        Name = "Rejoin Server",
        Callback = function()
            local a = Rejoin and Rejoin() or nil
            if a ~= nil then a() end
        end
    })

    Misc:Button({
        Name = "ServerHop",
        Callback = function()
            local a = ServerHop and ServerHop() or nil
            if a ~= nil then a() end
        end
    })


    Misc:Button({
        Name = "Find Empty Server",
        Callback = function()
            local a = EmptyServer and EmptyServer() or nil
            if a ~= nil then a() end
        end
    })

    Misc:Seperator()



    Misc:TextBox({
        Name = "New Config Name",
        Default = "",
        Flag = "NCM_"
    })
    local ConfigRefresh
    Misc:Button({
        Name = "Create/Save Config",
        Callback = function()
            Library:SaveConfig(Library.Folder .. "/" .. GetValue("NCM_") .. ".txt")
            ConfigRefresh()
        end
    })

    Misc:Button({
        Name = "Delete Config",
        Callback = function()
            local del = delfolder or syn_delsfolder or del_folder or function() end
            del(Library.Folder .. "/" .. GetValue("NCM_") .. ".txt")
            ConfigRefresh()
        end
    })

    Misc:Seperator()

    local ConfigDropdown = Misc:Dropdown({
        Name = "Config Files",
        Options = {},
        Default = "",
        Flag = "Cfiles_",
    })

    ConfigRefresh = function()
        pcall(function()
            -- // Vars
            local Configs = {}

            -- // Loop through all of the folders
            for i, v in pairs(listfiles(Library.Folder)) do
                if (v:sub(-4) == ".txt") then
                    -- // Add to name to configs
                    table.insert(Configs, v:sub(Library.Folder:len() + 2, -5))
                end
            end

            -- // Refresh
            ConfigDropdown:Refresh(Configs, true)
        end)
    end
    ConfigRefresh()

    Misc:Button({
        Name = "Load Config",
        Callback = function()
            pcall(function()
                local read = readfile or read or function() end
                Library:LoadConfig(read(Library.Folder .. "/" .. GetValue("Cfiles_") .. ".txt"))
            end)
        end
    })

    Misc:Seperator()

    Misc:Keybind({
        Name = "Toggle GUI",
        Default = Enum.KeyCode.LeftControl,
        Callback = function()
            local Type = Library.Open and Library.MenuOut or Library.MenuIn
            Type(Library)
        end
    })  

    Misc:Button({
        Name = "Stop Script",
        Callback = function()
            Library:Stop()
        end
    })

end
GameNotify("Thanks for waiting "..game.Players.LocalPlayer.Name,3)
