local var = {
    farm = "",
    KeySpam = {},
    TeleportHeight = 0,
    ChikaraFarm = false,
    Magnitude = 10,
    MagnitudeCheck = Vector3.new(0,0,0),
    FollowMagnitude = 15,
    MobFrame = {},
}

local float_plate = Instance.new("Part", workspace)
float_plate.Size = Vector3.new(500, 5, 500)
float_plate.Transparency = 1
float_plate.Anchored = true
float_plate.Name = StringCreate and StringCreate() or "nil"

-- // Noclip

local Noclip = {false,false,false,false,false,false,false,false,false,false}
do 

    local noclip_table,noclip_cam = {},nil
    game:GetService("RunService").Stepped:connect(function()
        if table.find(Noclip,true) then
            for i = 1, #noclip_table do
                noclip_table[i].CanCollide = false
            end
        else
            for i = 1, #noclip_table do
                noclip_table[i].CanCollide = true
            end
        end
    end)

    local function add_noclip_table(x)
        noclip_table = {}
        x:WaitForChild("Head")
        for i, v in pairs(x:GetDescendants()) do
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
local GameNotify, GameLoader, getstat, SetKey, ReturnDeath
do

    GameNotify = function(a,b)
        local c
        if b == 1 then
        c = false
        elseif b == 2 then
            c = "LevelUp"
        elseif b == 3 then
            c = "Boss"
        end
        local Notification = require(game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.Notifications)
        Notification.Notify({a, c})   
    end



    getstat = function(x)
        for _, v in pairs(game:GetService("Players").LocalPlayer.Stats:GetChildren()) do
            if x == "Strength" and v.Name == "1" then
                return math.floor(v.Value)
            elseif x == "Durability" and v.Name == "2" then
                return math.floor(v.Value)
            elseif x == "Chakra" and v.Name == "3" then
                return math.floor(v.Value)
            elseif x == "Sword" and v.Name == "4" then
                return math.floor(v.Value)
            elseif x == "Agility" and v.Name == "5" then
                return math.floor(v.Value)
            elseif x == "Speed" and v.Name == "6" then
                return math.floor(v.Value)
            end
        end
    end

    SetKey = function(v)
        local a = game:GetService("Players").LocalPlayer.PlayerGui.Main.MainClient.StatFunctions
        local b = require(a)["CurrentKey"]
        if v == "Strength" and b ~= 1 then
            require(a).EquipKey(1)
        elseif v == "Durability" then
            if getstat("Durability") < 100 and b ~= 2 then
                require(a).EquipKey(2)
            elseif getstat("Durability") > 100 and b ~= 4 then
                require(a).EquipKey(4)
            end
        elseif v == "Chakra" and b ~= 3 then    
            require(a).EquipKey(3)
        elseif v == "Sword" and b ~= 4 then
            require(a).EquipKey(4)
        elseif v == "Agility" or v == "Speed" then
            require(a).EquipKey(4)
        end
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
if getgenv().fezfe == nil then
    getgenv().fezfe = true
    GameNotify("Script is loading",1)
    local BLABLA = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame

        for _, v in pairs(workspace.Scriptable.NPC:GetDescendants()) do
            if v.Name == "ClickBox" and v:IsA("Part") then
                Teleport(v.CFrame + Vector3.new(0,5,0))
                game:GetService("RunService").Heartbeat:Wait()
            end
        end
        for i,v in pairs(game:GetService("Workspace").Scriptable.Spawners.Mob:GetDescendants()) do
            if v.ClassName == "Part"  then
                Teleport(v.CFrame + Vector3.new(0,5,0))
            end
        end

    wait(1)
    spawn(function() -- OpenAllShops
        for i,v in pairs(workspace.Scriptable.NPC.Shops:GetDescendants()) do
            if v:FindFirstChild("ClickBox") then
                fireclickdetector(v.ClickBox.ClickDetector)
                wait(0.25)
            end
        end
    end)    
    Teleport(BLABLA)
end

-------------------------------------

local Library = Libex.UI.new({
    Title = "Scryptiq",
    Bottom = "Anime Fighting Sim",
    Folder = "Scryptiq/Games/AFS",
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
_, FirstWindow, SecondWindow, ThirdWindow = Library:NewGroup({
    {Name = "Farming & Collectables", Width = 225, Icon = "trending-up"},
    {Name = "Mobs & Boss Battle", Width = 225, Icon = "skull"},
    {Name = "Shops & Champs", Width = 225, Icon = "shopping-cart"}
})


-- // Miscellaneous
local _, LocalPlyr, Misc, ___ = Library:NewGroup({
    {Name = "LocalPlayer & Others", Width = 225, Icon = "user"},
    {Name = "Miscellaneous", Width = 225, Icon = "layers"}
})
--// Home Functions
do
    Home:Label({Text = "Thanks For Using My Script!"})
    Home:Label({Text = "If You Find Any Bugs Pls Report"})
    Home:Label({Text = "It In Our Discord!"})
    Home:Seperator()
    Home:Button({Name = "Join Our Discord",Callback = function() 
        local a = Invite() 
        if a == true then
            Library:Notification({
                Title = "Copied To Clipboard",
                Content = "We Copied The Discord Invite To Your Clipboard",
                Delay = 5
            })
        elseif type(a) == "string" then
            Library:Notification({
                Title = "Discord Invite:",
                Content = a,
                Delay = 25
            })
        else
            Library:Notification({
                Title = "ERROR",
                Content = "BIEP BIEP BOEP",
                Delay = 25
            })
        end
    end})
end


-- // FirstWindow Functions
do
    FirstWindow:Dropdown({
        Name = "Select A Stat:",
        Options = {"Strength", "Durability", "Chakra", "Sword", "Agility", "Speed"},
        Flag = "SelectedStat",
    })

    local oldStat = ""
    FirstWindow:Toggle({ -- het klikken is mommenteeel automatisch in de game...?
        Name = "Auto Farm",
        Default = false,
        Flag = "AutoFarmStat",
        Callback = function() 
            while wait(0.5) do
                if not GetValue("AutoFarmStat") then break end
                SetKey(GetValue("SelectedStat"))
                if GetValue("SelectedStat") == "Agility" or GetValue("SelectedStat") == "Speed" then
                    local a = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent")
                    a:FireServer(unpack("Train",5)) --jumping
                    a:FireServer(unpack("Train",6)) --running
                end
            end
        end
    })





    local FindBestArea = function(keuze)
        local InfoTable = {}
        local GameData = game:GetService("ReplicatedStorage").Modules.GameData
        for i, v in pairs(require(GameData).TrainingAreas) do
            local requirement = v.Data.Requires
            local stat = v.Data.Stat
            local power = getstat(keuze)

            if stat == 1 then
                stat = "Strength"
            elseif stat == 2 then
                stat = "Durability"
            elseif stat == 3 then
                stat = "Chakra"
            elseif stat == 4 then
                stat = "Sword"
            elseif stat == 5 then
                stat = "Agility"
            elseif stat == 6 then
                stat = "Speed"
            end

            if stat == keuze and requirement < power then
                table.insert(InfoTable,v)
            end
        end

        local a = {Data = {Requires = 0}}
        for i,v in pairs(InfoTable) do
            if a.Data.Requires < v.Data.Requires then
                a = v
            end
        end
        return a 
    end

    -- local c = FindBestArea("Durability")
    -- print(c.Data.AreaName,c.Position)
    local SavedTPP = {0,0,0}
    local function TPF(x,y,z)
        if var.ChikaraFarm then return end
        SavedTPP = {x,y,z}
        var.MagnitudeCheck = Vector3.new(x,y,z)
        if (game.Players.LocalPlayer.Character.PrimaryPart.Position-var.MagnitudeCheck).magnitude >= var.Magnitude then
            Teleport(CFrame.new(x,y,z))
            float_plate.CFrame = CFrame.new(x,y-7,z)
        end
    end

    local AutoTeleport = FirstWindow:Toggle({
        Name = "Auto Teleport",
        Default = false,
        Flag = "AutoTeleport",
        Callback = function(x)
            if x then
                Noclip[1] = true
            else
                Noclip[1] = false
                float_plate.CFrame = CFrame.new(0,5000,0)
            end

            local OldStat,OldHeight = "",0
            while true do
                if not GetValue("AutoTeleport") then break end
                if GetValue("SelectedStat") == nil then return end
                OldStat = GetValue("SelectedStat")
                local Area = FindBestArea(GetValue("SelectedStat")).Position

                for i = 1, 10 do
                    if OldStat ~= GetValue("SelectedStat") or not GetValue("AutoTeleport") then return end
                    if typeof(Area) == "Vector3" and Area.X and Area.Y and Area.Z then
                        TPF(Area.X, Area.Y + (var.TeleportHeight), Area.Z)
                    end
                    if OldHeight ~= var.TeleportHeight then
                        game:GetService("RunService").Heartbeat:Wait()
                        OldHeight = var.TeleportHeight
                    else
                        wait(0.5)
                    end
                end
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
            var.TeleportHeight = x
        end
    })

    FirstWindow:Slider({
        Name = "Set Magnitude",
        Min = 10,
        Max = 350,
        Increment = 1,
        Default = 0,
        Flag = "SM__",
        Callback = function(x)
            var.Magnitude = x
        end
    })

    -- // Seperator
    FirstWindow:Seperator()

    FirstWindow:Toggle({ --game:GetService("Workspace").Scriptable.ChikaraBoxes
        Name = "Farm Chikara Chards",
        Default = false,
        Flag = "ChikaraFarm",
        Callback = function(x)
            var.ChikaraFarm = x
            while true do
                if not GetValue("ChikaraFarm") then 
                    float_plate.CFrame = CFrame.new(0,5000,0)
                    break 
                end
                for i,v in pairs(game:GetService("Workspace").Scriptable.ChikaraBoxes:GetChildren()) do
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
                        wait(10)
                    end
                end
            end
        end
    })

    

    FirstWindow:Button({
        Name = "Get Devil Fruit",
        Callback = function()
            local check = false
            for i,v in pairs(game:GetService("Workspace").Scriptable.Fruits:GetChildren()) do
                if v.Name == "Model" and v:FindFirstChild("ClickBox") and v.ClickBox:FindFirstChild("ClickDetector") then
                    local v = v.ClickBox.ClickDetector
                    fireclickdetector(v)
                    check = true 
                    break
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
    
    local FoundFruit = FirstWindow:Label({Text = "There are no devil fruits atm", Align = Enum.TextXAlignment.Left})
    game:GetService("Workspace").Scriptable.Fruits.ChildAdded:Connect(function(v)
        FoundFruit.Set("Found: ", v.Name)
    end)
    game:GetService("Workspace").Scriptable.Fruits.ChildRemoved:Connect(function(v)
        FoundFruit.Set("There are no devil fruits atm")
    end)

    -- // Seperator
    FirstWindow:Seperator()

    local NPCSNames = {}
    pcall(function()
        for i,v in pairs(workspace.Scriptable.NPC.Quest:GetChildren()) do 
            if v:IsA("Model") then 
                table.insert(NPCSNames, v.Name)
            end 
        end 
    end)

    FirstWindow:Dropdown({
        Name = "Select a quest NPC:",
        Flag = "SelectedNPC",
        Options = NPCSNames,
    })

    FirstWindow:Button({
        Name = "Talk to hte quest NPC",
        Callback = function()
            local a = GetValue("SelectedNPC")
            if a then
                local x = pcall(function()
                    fireclickdetector(game:GetService("Workspace").Scriptable.NPC.Quest[a].ClickBox.ClickDetector)
                                        
                                        
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
            
        end
    })

    SecondWindow:Toggle({
        Name = "Auto Freeze Boss",
        Default = false,
        Flag = "FreezeBoss",
        Callback = function()
            
        end
    })


    SecondWindow:Toggle({
        Name = "Auto Follow Boss",
        Default = false,
        Flag = "FollowBoss",
        Callback = function()
            
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

    SecondWindow:Label({Text = "Boss functions are removed ATM"})

    SecondWindow:Seperator()

    local MobData = require(game:GetService("ReplicatedStorage").Modules.GameData).Mobs
    local mob_names = {}
    for i, v in pairs(MobData) do
        if not table.find(mob_names, v.Name) then
            table.insert(mob_names, v.Name)
        end
    end

    local SelectedMob = SecondWindow:Dropdown({
        Name = "Select A Mob",
        Flag = "SelectedMob",
        Options = mob_names,
    })


    local PosMobFarm,AimLockMob = 0,false
    local GetMobNumber = function(x)
        for i, v in pairs(MobData) do
            if v.Name == x then
                return i
            end
        end
    end
    local mob_farm = function(xa)
        local MobNames = GetValue("SelectedMob")
        if not MobNames then return end

        var.MobFrame = {}
        local TP_mob_dist = math.huge
        local mobFound = false

        for i,v in pairs(game:GetService("Workspace").Scriptable.Mobs:GetChildren()) do
            local a = v:FindFirstChild("HumanoidRootPart")
            if a and a:FindFirstChild("Details") and a.Details:FindFirstChild("Frame") then
                local MobInfo = a.Details.Frame 
                if string.find(MobInfo.MobName.Text, MobNames) then
                    local HPText = MobInfo.HP.Text
                    if not string.find(HPText, "^0/") then -- alive check
                        mobFound = true
                        local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
                        if dist < TP_mob_dist then
                            TP_mob_dist = dist
                            var.MobFrame = {a.Position.X, a.Position.Y, a.Position.Z + PosMobFarm}
                        end
                    end
                end
            end
        end

        if not mobFound then
            Library:Notification({
                Title = "Mob isnt spawned in yet",
                Content = "pls fly around so the mob spawns in",
                Delay = 10
            })
            wait(5)
            return
        end

        -- AimLock
        if AimLockMob then
            for i = 1,10 do task.wait()
                local krt = Vector3.new(var.MobFrame[1], var.MobFrame[2], var.MobFrame[3] - PosMobFarm)
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, krt)
            end
        end

        local distToMob = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(unpack(var.MobFrame))).Magnitude
        if distToMob >= 25 or xa then
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
                        game:GetService("ReplicatedStorage").Remotes.GeneralFunction:InvokeServer(unpack(args))
                    end
                    wait(1)
                end
            end
        end
    })

    local oldKey,AddRemoveKeyBind = "Unknown", function() end
    AddRemoveKeyBind = SecondWindow:Keybind({
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
                        Delay = 2
                    })
                else
                    table.insert(var.KeySpam,key)
                    Library:Notification({
                        Title = "Added Key!",
                        Content = "The Key "..key.." Is Added To The list.",
                        Delay = 2
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
    local buy_tbl = {}
    for i,v in pairs(game:GetService("Workspace").Scriptable.NPC.Shops.Special:GetChildren()) do
        if not table.find(buy_tbl,v.Name) then
            table.insert(buy_tbl,v.Name)
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
            local Specials = require(game:GetService("ReplicatedStorage").Modules.GameData).Specials
            for i,v in pairs(Specials[special_select].List) do
                --print(i,v.Name)
                table.insert(tbl, v.Name)
            end
            dropdown_power:Refresh(tbl,true)
        end
    })

    dropdown_power = ThirdWindow:Dropdown({
        Name = "Select A Power:",
        Options = {"BOO","Select A Special First!"},
        Flag = "SelectedPowerBuy",

    })



    local CheckYouSpecial = function()
        local a = game:GetService("Players").LocalPlayer.PlayerGui.Main.Frames.Specials.Container.Buttons[GetValue("ChoosenSpeciall")].Frame
        for i,v in pairs(a:GetChildren()) do
            if string.find(v.Name, "Name")  then
                return v.Text
            end
        end
    end

    local ABSToggleFunc = function() end
    local ABSTOGGLE = ThirdWindow:Toggle({
        Name = "Auto Buy Special",
        Default = false,
        Flag = "BuyToggle",
        Callback = function(x)
            while true do
                if not GetValue("BuyToggle") then break end
                
                if CheckYouSpecial() ~= GetValue("SelectedPowerBuy") then
                    pcall(function()
                        fireclickdetector(game:GetService("Workspace").Scriptable.NPC.Shops.Special[GetValue("ChoosenSpeciall")]["1"].ClickBox.ClickDetector)
                        wait(1)
                        game:GetService("ReplicatedStorage").Remotes.RemoteFunction:InvokeServer("BuyContainer", GetValue("ChoosenSpeciall") , 1) -- ChoosenSpeciall moet iets zoals "Quirks"
                        wait(1)
                        fireclickdetector(game:GetService("Workspace").Scriptable.NPC.Shops.Special[GetValue("ChoosenSpeciall")]["1"].ClickBox.ClickDetector)
                    end)
                else
                    Library:Notification({
                        Title = "Selected Power",
                        Content = "You got your selected power.",
                        Delay = 2
                    })
                    ABSToggleFunc()
                    wait(1)
                    break
                end
            end
        end
    })
    ABSToggleFunc = function() ABSTOGGLE:Set(false) end

    ThirdWindow:Seperator() 

    local AuraChests = {} 
    for i,v in pairs(require(game:GetService("ReplicatedStorage").Modules.GameData).AuraBoxes) do 
        table.insert(AuraChests,i)
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
            while true do
                if not GetValue("ChestToggle") then break end
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.RemoteEvent:FireServer("BuyBox", GetValue("BuyChestDropdown"))
                end)
                wait(1)
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


    LocalPlyr:Slider({
        Name = "WalkSpeed",
        Min = 16,
        Max = 500,
        Increment = 1,
        Default = game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed or 50,
        Flag = "WalkSpeed",
        Callback = function(x) 
            game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = x
        end
    })


    LocalPlyr:Slider({
        Name = "JumpPower",
        Min = 50,
        Max = 500,
        Increment = 1,
        Default = game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower or 50 ,
        Flag = "JumpPower",
        Callback = function(x) 
            game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = x
        end

    })

    -- LocalPlyr:Slider({
    --     Name = "Fly Speed",
    --     Min = 0,
    --     Max = 1200,
    --     Increment = 1,
    --     Default = 0,
    --     Flag = "FlySpeed_",
    --     Callback = function(x)
    --         pcall(function()
    --             game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.BodyPosition.D = 1250-x
    --         end)
    --     end
    -- })

    LocalPlyr:Toggle({
        Name = "Conceal Power",
        Default = false,
        Flag = "ConCealPower",
        Callback = function(x)
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Overhead.Enabled = not x
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

    LocalPlyr:Toggle({
        Name = "Camera Noclip/Inf Zoom",
        Default = false,
        Flag = "CNIF_",
        Callback = function(x)
            local sc = (debug and debug.setconstant) or setconstant
            local gc = (debug and debug.getconstants) or getconstants
            if not sc or not getgc or not gc then
                Library:Notification({
                    Title = "Exploit Problem",
                    Content = "Exploit doesnt support some functions",
                    Delay = 5
                })
                return
            end
            local pop = game.Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
            for _, v in pairs(getgc()) do
                if type(v) == 'function' and getfenv(v).script == pop then
                    for i, v1 in pairs(gc(v)) do
                        if tonumber(v1) == .25 and x == true then
                            sc(v, i, 0)
                            game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = math.huge
                        elseif tonumber(v1) == 0 then
                            sc(v, i, .25)
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
            Teleport(game.Players[TargetName].Character:FindFirstChild("HumanoidRootPart").CFrame)
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
            float_plate:Destroy()
            Library:Stop()
        end
    })

end
Library:Notification({
    Title = "Scryptiq",
    Content = "Toggle gui with Left Control",
    Delay = 10
})

GameNotify("Thanks for waiting "..game.Players.LocalPlayer.Name,3)









