

loadstring(game:HttpGet(tostring("https://raw.githubusercontent.com/Woutt/FludexHub/main/Libex/code.lua")))()

-- // Start Library
local Library = Libex.UI.new({
    Title = nil,
    Bottom = "test game",
    Folder = "FludexHub/Games",
}):Initialise()

-- // Create Groups
local _, Home = Library:NewGroup({
    {Name = "Home", Width = 225, Icon = "home"}
})
do
    Home:Label({Text = "Thanks For Using Our Script!"})
    Home:Label({Text = "If You Find Any Bugs Pls Report"})
    Home:Label({Text = "It In My Discord!"})

    Home:Seperator()
    Home:Button({Name = "Join Our Discord",Callback = function() getgenv().discord_invite() end})

end

local _, Dashboard, AimingGUI, WeaponManager = Library:NewGroup({
    {Name = "Dashboard", Width = 225, Icon = "contact"},
    {Name = "Aiming", Width = 225, Icon = "skull"},
    {Name = "Weapon Manager", Width = 225, Icon = "electricity"}
})

do

    Dashboard:Button({
        Name = "nice button",
        Callback = function()
            print("hi")
        end
    })

    Dashboard:Seperator()

    local firstlabel = Dashboard:Label({Text = "look am a label", Align = Enum.TextXAlignment.Left})

    Dashboard:Button({
        Name = "update label",
        Callback = function()
            firstlabel:Set("NewText")
        end
    })

    Dashboard:Seperator()

    local firstToggle = Dashboard:Toggle({
        Name = "toggle name",
        Default = false,
        Flag = "TestToggle",
        Callback = function(x)
            print(x)
        end
    })

    Dashboard:Button({
        Name = "update toggle",
        Callback = function()
            firstToggle:Set(true)
        end
    })

    Dashboard:Seperator()

    local SliderVar = Dashboard:Slider({
        Name = "Slider Name",
        Min = 0,
        Max = 100,
        Increment = 1,
        Default = 50,
        Flag = "TestSlider",
        Callback = function(x)
            print(x,typeof(x)) -- number 
        end
    })

    Dashboard:Button({
        Name = "update slider",
        Callback = function()
            SliderVar:Set(25)
        end
    })

    Dashboard:Button({
        Name = "slider other settings",
        Callback = function()
            Library.Flags.TestSlider.Min = 10
            Library.Flags.TestSlider.Max = 200
            Library.Flags.TestSlider.Increment = 2
            Library.Flags.TestSlider.Value = 60 -- // aka Default - but doesnt update, then you need to use .Set func
        end
    })

    Dashboard:Seperator()
    Dashboard:Seperator()
    Dashboard:Seperator()
end

do

    
    -- //
    local TextBoxVar = AimingGUI:TextBox({
        Name = "Textbox Name",
        Default = "YouuuuuuuuuUUuuuuuuuuuuuuuU",
        TextDisappear = false, -- verwijderd na da je klaar bent met tippe
        Flag = "TextBoxPartyy",
        Callback = function(x)
            print(x) -- string
        end

    })

    AimingGUI:Button({
        Name = "textbox set",
        Callback = function()
            TextBoxVar:Set("new text")
        end
    })


    AimingGUI:Seperator()


    local FirstDropdown = AimingGUI:Dropdown({
        Name = "test dropdown",
        Options = {"hi","test",1,2,3,"hiii","","boom","nil","gg"},
        Default = "you",
        DefaultValue = "select idk?",
        Flag = "NormalDropdown",
        Callback = function(x)
            print(x,typeof(x)) -- string and number (it doesnt transform in a string)
        end
    })

    AimingGUI:Button({
        Name = "Dropdown refresh",
        Callback = function()
            FirstDropdown:Refresh({"new","text"},true) -- // self, table, delete - if true then delete button from the dropdown and add the new ones - else just add the new buttons to the old
        end
    })
    
    AimingGUI:Button({
        Name = "textbox set",
        Callback = function()
            FirstDropdown:Set("Set to somthing new lol")
        end
    })



    AimingGUI:Seperator()

    local FirstDropdown = AimingGUI:Dropdown({ -- auto update
        Name = "test dropdown",
        Options = "Players", -- player dropdown keyword
        Default = "you",
        DefaultValue = "select idk?",
        Callback = function(x)
            print(x,typeof(x)) -- string
        end
    })

    AimingGUI:Seperator()


    local colorPickeur  = AimingGUI:ColorPicker({
        Name = "FOV Colour",
        Default = nil, --white
        Flag = "colorPickerFlag",
        Callback = function(x)
            print(x,typeof(x)) -- Color3
        end
    })
    
    AimingGUI:Button({
        Name = "color set",
        Callback = function()
            colorPickeur:Set(Color3.fromRGB(255, 0, 0))
        end
    })

    AimingGUI:Keybind({
        Name = "keybind? he",
        Value = nil,
        Flag = "KeyBindNice",
        Hold = false,
        Callback = function(x)
            print(x)
        end
    })



    AimingGUI:Seperator()

    AimingGUI:Button({
        Name = "button with Notification",
        Callback = function()
            Library:Notification({
                Title = "Add Target Part",
                Content = "Target Part added!",
                Delay = 3
            })
        end
    })


end

-- // WeaponManager
do  
    WeaponManager:Keybind({
        Name = "test name",
        Default = Enum.KeyCode.X,
        Flag = "keybindFlagaaa",
        Hold = true,
        Callback = function(x,y)
            print(x) -- Enum.KeyCode.key
            print(y) -- bool, if hes holding the key then true else false
        end
    })
end

-- -- // Misc - Config
-- do
--     -- // New Group
--     local Misc = Library:NewConfigPanel(Library)

--     Misc:Button({
--         Name = "button with notify",
--         Callback = function()
--             Library:Notification({
--                 Title = "Add Target Part",
--                 Content = "Target Part added!",
--                 Delay = 3
--             })
--         end
--     })
-- end

