getgenv().API_Loaded = nil
getgenv().Request = http_request or request or http.request or HttpPost or httprequest or function(...) end
getgenv().Clipboard = write_clipboard or writeclipboard or setclipboard or set_clipboard or function(...) print(...) end
--local exploit,version = identifyexecutor()

getgenv().settings = {TweenSpeed = 0.05}
getgenv().Teleport = function(...)
    local TP, info = ..., TweenInfo.new(settings.TweenSpeed, Enum.EasingStyle.Linear)
    pcall(function()
        game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), info, {CFrame = TP}):Play()
        wait(settings.TweenSpeed)
    end)
end

getgenv().SaveError = function(v)
    local datum = os.date("%Y/%m/%d")
    local time = os.date("%I:%M")
    local path = tostring("Scryptiq/errors/"..datum)

    if not FS_func.IsFile(path) then 
        FS_func.WriteFile(path, "") 
    end
    FS_func.AppendFile(path, "["..time.."] "..v.."\n")
end

getgenv().StringCreate = function(v)
    local x = {}
    if v == nil then v = math.random(10,20) end
    for i = 1, v do
        x[i] = string.char(math.random(32, 126))
    end
    return table.concat(x)
end

getgenv().Rejoin = function()
    if #game:GetService("Players"):GetPlayers() <= 1 then
        game:GetService("Players").LocalPlayer:Kick("\n\n\nRejoining server please wait :)\n\n\n") wait()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    else
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
    end
end

getgenv().AntiAfk = function()
    local GetCon = getconnections or get_connections or get_signal_cons or nil
    if GetCon ~= nil then
        for i,v in pairs(GetCon(game:GetService("Players").LocalPlayer.Idled)) do
            if v["Disable"] then v["Disable"](v)
            elseif v["Disconnect"] then v["Disconnect"](v)
            end
        end
    else
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end

getgenv().ServerHop = function()
    local servers = {}
    local cursor = ""
    while cursor and #servers == 0 do
        task.wait()
        local req = Request({
            Url = ("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100&cursor=%s"):format(placeid,cursor)
        })
        local body = game:GetService("HttpService"):JSONDecode(req.Body)

        if body and body.data then
            task.spawn(function()
                for i,v in pairs(body.data) do
                    if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and not table.find(data.jobids,v.id) then
                        table.insert(servers, 1, v.id)
                    end 
                end
            end)

            if body.nextPageCursor then
                cursor = body.nextPageCursor
            end
        end
    end
    while #servers > 0 do
        local random = servers[math.random(1, #servers)]
        TeleportService:TeleportToPlaceInstance(placeid, random, Players.LocalPlayer)
        task.wait(1)
    end
end

getgenv().EmptyServer = function(x)
    local pageLimit = tonumber(x) or math.huge
    local minimum = math.huge
    local Page,nextCursor,serverId = 0,nil,nil
    repeat game:FindService("RunService").Heartbeat:Wait()
        local Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        if (nextCursor) then 
            Url = Url .. "&cursor=" .. nextCursor 
        end
        local Servers = game:GetService("HttpService"):JSONDecode(game:HttpGet(Url))
        if (Servers) then
            nextCursor = Servers.nextPageCursor or nil
            Page = Page + 1
            for _,v in pairs(Servers.data) do
                v.playing = v.playing or math.huge
                v.id = v.id or ""
                if v.id ~= game.JobId and v.playing <= minimum then 
                    minimum = v.playing
                    serverId = v.id
                end
            end
        end
    until (not nextCursor) or (Page >= pageLimit)
    if (serverId) then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverId)
    end
end

getgenv().Invite = function()
    local url = "https://discord.gg/xF6fnGGyC6"
    if (Clipboard) then
        Clipboard(url)
    else
        return url
    end
    task.spawn(function()
        for port=6463, 6472, 1 do
            local inv = "http://127.0.0.1:"..tostring(port).."/rpc?v=1"
            local http = game:GetService("HttpService")
            local t = {cmd = "INVITE_BROWSER", args = {["code"] = x["inv"]}, nonce = string.lower(http:GenerateGUID(false))}
            local post = http:JSONEncode(t)
            Request({Url = inv, Method = "POST", Body = post, Headers = {["Content-Type"] = "application/json", ["Origin"] = "https://discord.com"}})
        end
    end)
    return true
end

--https://discord.gg/xF6fnGGyC6

getgenv().API_Loaded = true
