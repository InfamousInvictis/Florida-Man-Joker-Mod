-- Announce our loading in console...
sendInfoMessage("Florida!", "FloridaMod")

-- Set our presence for reference later or by others.
floridamod = SMODS.current_mod
local mod_path = ''..SMODS.current_mod.path

local folders = NFS.getDirectoryItems(mod_path.."Items")
local objects = {}

local function collect_item_files(base_fs, rel, out)
    for _, name in ipairs(NFS.getDirectoryItems(base_fs)) do
        local abs = base_fs.."/"..name
        local info = NFS.getInfo(abs)
        if info and info.type == "directory" then
            collect_item_files(abs, rel.."/"..name, out)
        elseif info and info.type == "file" and name:match("%.lua$") then
            table.insert(out, rel.."/"..name)
        end
    end
end

local files = {}
collect_item_files(mod_path.."Items", "Items", files)

local function load_items(curr_obj)
    if curr_obj.init then curr_obj:init() end
    if not curr_obj.items then
        print("Warning: curr_obj has no items")
        return
    end
    for _, item in ipairs(curr_obj.items) do
        item.ignore = item.ignore or false
        if SMODS[item.object_type] and not item.ignore then
            SMODS[item.object_type](item)
        elseif CardSleeves and CardSleeves[item.object_type] and not item.ignore then
            CardSleeves[item.object_type](item)
        elseif not item.ignore then
            print("Error loading item "..item.key.." of unknown type "..item.object_type)
        end
    end
end

for _, rel in ipairs(files) do
    local f, err = SMODS.load_file(rel)
    if not f then
        print("Error loading item file '"..rel.."': "..tostring(err))
    else
        local ok, curr_obj = pcall(f)
        if ok then
            table.insert(objects, curr_obj)
        end
    end
end

table.sort(objects, function(a, b)
    local function get_lowest_order(obj)
        if not obj.items then return math.huge end
        local lowest = math.huge
        for _, item in ipairs(obj.items) do
            if item.order and item.order < lowest then
                lowest = item.order
            end
        end
        return lowest
    end
    return get_lowest_order(a) < get_lowest_order(b)
end)

for _, curr_obj in ipairs(objects) do
    load_items(curr_obj)
end