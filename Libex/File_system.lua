
local WriteFile = writefile or write_file or write or nil
local IsFolder = isfolder or is_folder or nil
local MakeFolder = makefolder or make_folder or createfolder or create_folder or nil
local FileSystem = function(Directory, Contents)
    if WriteFile and IsFolder and MakeFolder then
        if (Directory:sub(1, 1) == "/") then
            Directory = Directory:sub(2, -1)
        end

        if (Directory:sub(1, 2) == "./") then
            Directory = Directory:sub(3, -1)
        end

        if (not Directory:find("/")) then
            return WriteFile(Directory, Contents)
        end

        local Directories = Directory:split("/")
        local CurrentDirectory = ""
        
        for i = 1, #Directories - 1 do
            local Direct = Directories[i]
            CurrentDirectory = CurrentDirectory .. "/" .. Direct
            if (not IsFolder(CurrentDirectory)) then
                MakeFolder(CurrentDirectory)
            end
        end
        if Contents then
            return WriteFile(Directory, Contents)
        end
    else
        print("File System Isnt Supported With Your Exploit")
    end
end

getgenv().FS_func = {
    ReadFile = readfile or read_file or read or nil,
    WriteFile = writefile or write_file or write or nil,
    AppendFile = appendfile or append_file or nil,
    LoadFile = loadfile or load_file or nil,
    RunFile = runfile or run_file or nil,
    ListFiles = listfiles or list_files or list or nil,
    IsFile = isfile or is_file or nil,
    IsFolder = isfolder or is_folder or nil,
    MakeFolder = makefolder or make_folder or createfolder or create_folder or nil,
    DelFolder = delfolder or del_folder or deletefolder or delete_folder or nil,
    GetAssets = getcustomasset or getasset or get_custom_asset or nil,
    FileSystem = FileSystem
}
return {}

--[[
    FS_func
    
    ReadFile
    WriteFile
    AppendFile
    LoadFile
    RunFile
    ListFiles
    IsFile
    IsFolder
    MakeFolder
    DelFolder
    GetAssets
    FileSystem
--]]
