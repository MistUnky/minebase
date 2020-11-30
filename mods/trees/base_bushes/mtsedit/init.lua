--
-- mt-mod/minetest/init.lua
--
-- Copyright (C) 2019 bzt (bztsrc@gitlab)
--
-- Permission is hereby granted, free of charge, to any person
-- obtaining a copy of this software and associated documentation
-- files (the "Software"), to deal in the Software without
-- restriction, including without limitation the rights to use, copy,
-- modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
-- HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-- WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.
--
-- @brief Minetest mod that adds support for exporting node spec to MTSEDit and import MTS files
-- https://gitlab.com/bztsrc/mtsedit
--

local S = minetest.get_translator("mtsedit")

mtsedit = { loadstat = {}, savestat = {} }

-- translations for some common Minetest nodes to Minecraft names as used by MTSEdit
-- both technical names and human readable names can be used as key, but spaces must
-- be converted to underscores '_' in the latter. Otherwise exact match expected.
mtsedit.translate = {
    ["Air"] = "",
    ["Cave_Ice"] = "Packed_Ice",
    ["Lily_Pad"] = "Waterlily",
    ["Papyrus"] = "Sugar_Canes",
    ["Bones"] = "Bone_Block",
    -- needs "Block" to be added as an extra
    ["Double_Slab_of_Gold"] = "Double_Gold_Block_Slab",
    ["Double_Slab_of_Iron"] = "Double_Iron_Block_Slab",
    ["Slab_of_Gold"] = "Gold_Block_Slab",
    ["Slab_of_Iron"] = "Iron_Block_Slab"
}
-- these will be substituted in names
mtsedit.replacements = {
    ["_Wood"] = "",
    ["_Tree"] = "_Log",
    ["_Bars"] = "_Bar",
    ["_Bricks"] = "_Brick",
    ["_Stairs"] = "_Stair",
    ["_Planks"] = "_Plank",
    ["_Walls"] = "_Wall",
    ["Apple"] = "Birch",
    ["Steel"] = "Iron",
    ["Gray"] = "Grey",
    ["Wooden_"] = "Oak_",
    ["Moss_"] = "Mossy_",
    ["Mese_"] = "Redstone_"
}
mtsedit.replacements2 = {
    ["Block_of_"] = "_Block",
    ["Slab_of_"] = "_Slab",
    ["Stair_of_"] = "_Stair",
    ["Stairs_of_"] = "_Stair"
}

-- helper function to parse a CSV line into table
local function parsecsv(line)
    local csv = {}
    local pos = 1
    if line == nil or line == "" then return nil end
    while true do
        local c = string.sub(line,pos,pos)
        if (c == "" or c == "\r" or c == "\n") then break end
        if (c == " ") then pos = pos + 1
        elseif (c == '"') then
            local txt = ""
            repeat
                local startp,endp = string.find(line,'^%b""',pos)
                txt = txt..string.sub(line,startp+1,endp-1)
                pos = endp + 1
                c = string.sub(line,pos,pos)
                if (c == '"') then txt = txt..'"' end
            until (c ~= '"')
            table.insert(csv,txt)
            pos = pos + 1
        else
            local startp,endp = string.find(line,",",pos)
            local txt = ""
            if (startp) then
                while (string.sub(line,startp,startp) == " ") do startp = startp - 1 end
                table.insert(csv,string.sub(line,pos,startp-1))
                pos = endp + 1
            else
                txt = string.gsub(string.gsub(string.sub(line,pos),"\r",""),"\n","")
                table.insert(csv,txt)
                break
            end
        end
    end
    return csv
end

-- helper to generate a block id name
local function getblockid(name, str)
    -- if there's a known translation for the technical name
    if (mtsedit.translate[name] ~= nil) then return mtsedit.translate[name] end
    local blockid = string.gsub(string.gsub(str, "'", "_"), " ", "_")
    -- cut off that I don't know what part
    if string.sub(blockid,1,1) == "\27" then
        local start2p,end2p = string.find(blockid,"\27",2)
        local start1p,end1p = string.find(blockid,")",1)
        if (start1p == nil) then start1p = 1 end
        blockid = string.sub(blockid,start1p+1,start2p-1)
    end
    -- if there's a translation for the name
    if (mtsedit.translate[blockid] ~= nil) then blockid = mtsedit.translate[blockid] end
    for from,to in pairs(mtsedit.replacements2) do
        if (string.sub(blockid,1,string.len(from)) == from) then
            blockid = string.sub(blockid, string.len(from)+1)..to
        end
    end
    for from,to in pairs(mtsedit.replacements) do blockid = string.gsub(blockid, from, to) end
    return blockid
end

-- Export node data into CSV
function mtsedit.export(param)
    if param == nil or param == "" then
        return false, S("Specify <palette> (like \"Mineclone2\", \"Minetest Game\" etc.)")
    end

    local fn = minetest.get_worldpath() .. "/blocks.csv"
    local defpalettes = { "_Name", "BlockID", "BlockName", "Biome Specific", "MapGen Alias", param }
    local palettes, nodes, known, s = {}, {}, {}, {}
    local line, node, i, cnt, idx = 0, "", 0, 1, 0

    -- read in csv if exists
    local file,err = io.open(fn, "r")
    if file == nil or err then
        palettes = defpalettes
        file = nil
    else
        palettes = parsecsv(file:read())
        if palettes == nil then
            palettes = defpalettes
        end
    end
    for i,t in ipairs(palettes) do if (cnt > 5 and t == param) then idx = i end cnt = cnt + 1 end
    if (idx == 0) then
        table.insert(palettes, param)
        idx = cnt
    end
    idx = idx - 1
    cnt = cnt - 1
    if (file ~= nil) then
        while true do
            local node
            line = parsecsv(file:read())
            if (line == nil) then break end
            node = string.gsub(string.gsub(table.remove(line, 1), "'", "_"), " ", "_")
            nodes[node] = line
            if (line[idx] ~= nil) then known[line[idx]] = node end
        end
        file:close()
    end

    -- add nodes which are defined in this game (nodes defined in enabled mods included)
    for node,t in pairs(minetest.registered_nodes) do
        local blockid
        if (known[node] ~= nil) then
            blockid = known[node]
        else
            blockid = getblockid(node, t["description"])
        end
        if (blockid ~= nil and blockid ~= "") then
            -- if new node
            if (nodes[blockid] == nil) then
                i = 5
                nodes[blockid] = { "", "", "", "" }
                while (i < cnt) do table.insert(nodes[blockid], node) i = i + 1 end
            end
            -- if no biome specific name given already check if there's one
            if (node ~= "air" and node ~= "ignore" and t["drawtype"] ~= "airlike" and
                (nodes[blockid][3] == nil or nodes[blockid][3] == "")) then
                for name,biome in pairs(minetest.registered_biomes) do
                    for propname,propval in pairs(biome) do
                        if (string.sub(propname,1,5) == "node_" and propval == node) then
                            nodes[blockid][3] = "biome:"..propname
                            break
                        end
                    end
                end
            end
            -- mapgen specific name
            if (nodes[blockid][4] == nil) then nodes[blockid][4] = "" end
            if (nodes[blockid][4] == "") then
                for mapgen,oname in pairs(minetest.registered_aliases) do
                    if (oname == node) then
                        nodes[blockid][4] = mapgen
                        break
                    end
                end
            end
            -- replace block names
            i = 5
            while (i < cnt) do
                if (i == idx or nodes[blockid][i] == nil or nodes[blockid][i] == "") then nodes[blockid][i] = node end
                i = i + 1
            end
        end
    end

    -- write out updated blocks.csv
    file,err = io.open(fn, "wb")
    if (file == nil or err) then return false, S("Unable to write @1", fn) end
    for i,t in ipairs(palettes) do
        local start1p,end1p = string.find(t,",")
        local start2p,end2p = string.find(t,'"')
        if (i > 1) then file:write(",") end
        if (start1p or start2p) then
            file:write(string.format("%q", t))
        else
            file:write(t)
        end
    end
    file:write("\r\n")
    for node,t in pairs(nodes) do table.insert(s, node) end
    table.sort(s)
    for _,node in ipairs(s) do
        local start1p,end1p = string.find(node,",")
        local start2p,end2p = string.find(node,'"')
        if (start1p or start2p) then
            file:write(string.format("%q", node))
        else
            file:write(node)
        end
        for _,n in ipairs(nodes[node]) do
            local startp,endp = string.find(n,",")
            if (startp) then
                file:write(","..string.format("%q", n))
            else
                file:write(","..n)
            end
        end
        file:write("\r\n")
    end
    file:close()
    return true, S("@1 saved.", fn)
end

-- Export node textures data
function mtsedit.imgs()
    local fn = minetest.get_worldpath() .. "/blockimgs.csv"
    local file,err = io.open(fn, "wb")
    if err then return false, S("Unable to write @1", fn) end
    -- write out blockimgs.csv
    for node,t in pairs(minetest.registered_nodes) do
        local blockid = getblockid(node, t["description"])
        if (blockid ~= nil and blockid ~= "" and t["tiles"] ~= nil) then
            file:write(string.format("%q", blockid)..","..string.format("%q", node))
            if (t["drawtype"] == nil) then
                file:write(",normal")
            else
                file:write(","..t["drawtype"])
            end
            if (t["paramtype2"] == nil) then
                file:write(",regular")
            else
                file:write(","..t["paramtype2"])
            end
            if (t["node_box"] == nil or t["node_box"]["type"] == nil) then
                file:write(",")
            else
                file:write(","..t["node_box"]["type"].."")
            end
            if (t["mod_origin"] == nil or t["mod_origin"] == "") then
                file:write(",")
            else
                file:write(","..string.format("%q", minetest.get_modpath(t["mod_origin"])..""))
            end
            if (type(t["tiles"]) == "table") then
                for _,tile in pairs(t["tiles"]) do
                    if (type(tile) == "table") then
                        file:write(","..string.format("%q", table.concat(tile,",")))
                    else
                        file:write(","..string.format("%q", tile..""))
                    end
               end
            else
                file:write(","..string.format("%q", t["tiles"]..""))
            end
            file:write(",|")
            if (type(t["overlay_tiles"]) == "table") then
                for _,tile in pairs(t["overlay_tiles"]) do
                    if (type(tile) == "table") then
                        file:write(","..string.format("%q", table.concat(tile,",")))
                    else
                        file:write(","..string.format("%q", tile..""))
                    end
               end
            elseif (t["overlay_tiles"] ~= nil) then
                file:write(","..string.format("%q", t["tiles"]..""))
            end
            file:write("\r\n")
        end
    end
    file:close()
    return true, S("@1 saved.", fn)
end

-- Load schematics into the World
function mtsedit.load(name, param)
    if param == nil or param == "" then
        return false, S("Specify <schematic> file")
    end
    -- do not let the user use the parent directory reference in the filename
    local fn = minetest.get_worldpath() .. "/schems/" .. param .. ".mts"
    local magic, x, z
    if param:find("^[%w%s%^&'@{}%[%],%$=!%-#%(%)%%%.%+~_]+$") then
        local file,err = io.open(fn, "rb")
        if file ~= nil and err == nil then
            magic = file:read(12)
            file:close()
            -- Fck Lua, string.unpack crashes Minetest
            x = string.byte(string.sub(magic, 8, 8)) + string.byte(string.sub(magic, 7, 7)) * 256
            z = string.byte(string.sub(magic, 12, 12)) + string.byte(string.sub(magic, 11, 11)) * 256
        end
    end
    if magic == nil or string.sub(magic, 1, 4) ~= "MTSM" then return false, S("Failed to load @1", fn) end
    mtsedit.loadstat[name] = { fn, x, z }
    return true, S("Schematic loaded, use right click with the placement tool in your inventory")
end

-- List available schematic files
function mtsedit.list(name)
    local path = minetest.get_worldpath() .. "/schems/"
    local list = minetest.get_dir_list(path, false)
    minetest.chat_send_player(name, "mtsedit: *.mts; PATH=" .. path)
    for i,n in pairs(list) do
        local l = string.len(n) - 4
        if string.sub(n, l+1) == ".mts" then minetest.chat_send_player(name, "  " .. string.sub(n, 1, l)) end
    end
end

-- Save selected area into schematic file
function mtsedit.save(name, param)
    if param == nil or param == "" then
        return false, S("Specify <schematic> file")
    end
    if mtsedit.savestat[name] == nil then
        return false, S("Select an area first by left clicking with the placement tool")
    end
    mtsedit.savestat[name][1]:remove()
    mtsedit.savestat[name][1] = nil
    local fn = minetest.get_worldpath() .. "/schems/" .. param .. ".mts"
    if param:find("^[%w%s%^&'@{}%[%],%$=!%-#%(%)%%%.%+~_]+$") and minetest.create_schematic(mtsedit.savestat[name][2], mtsedit.savestat[name][3], nil, fn) ~= nil then
        minetest.chat_send_player(name, "mtsedit: " .. S("Area") .. " " .. minetest.pos_to_string(mtsedit.savestat[name][2]).. " - " .. minetest.pos_to_string(mtsedit.savestat[name][3]))
        return true, S("@1 saved.", fn)
    end
    return false, S("Unable to write @1", fn)
end

-- Grow or shrink the selected area
function mtsedit.grow(name, param)
    if param == nil or param == "" then
        return false, S("Specify <delta> value")
    end
    if mtsedit.savestat[name] ~= nil and mtsedit.savestat[name][1] ~= nil then
        local props = mtsedit.savestat[name][1]:get_properties()
        if props ~= nil and props["visual_size"] ~= nil then
            local siz = props["visual_size"]
            mtsedit.savestat[name][1]:set_properties({visual_size={x=siz.x + param, y=siz.y + param, z=siz.z + param}})
        end
    end
    return true, ""
end

-- Register selected area marker
minetest.register_entity(":mtsedit:selection", {
    initial_properties = {
        visual = "cube",
        visual_size = {x=1.3, y=1.3, z=1.3},
        textures = {"mtsedit_select.png", "mtsedit_select.png", "mtsedit_select.png",
            "mtsedit_select.png", "mtsedit_select.png", "mtsedit_select.png"},
        physical = false,
        use_texture_alpha = true,
        backface_culling = false,
        static_save = false,
        glow = 0.5
    },
})

-- Register placement tool
minetest.register_tool("mtsedit:place", {
    description = S("Place the loaded structure"),
    inventory_image = "mtsedit_place.png",
    range = 8.0,
    light_source = 14,
    on_use = function(itemstack, user, pointed_thing)
        local name = user:get_player_name()
        local pos = user:get_pos()
        pos.x, pos.y, pos.z = math.floor(pos.x + 0.5), math.floor(pos.y + 0.5), math.floor(pos.z + 0.5)
        if pointed_thing.type == "node" or mtsedit.savestat[name] == nil then
            if pointed_thing.type == "node" then pos = pointed_thing.under end
            if mtsedit.savestat[name] ~= nil then mtsedit.savestat[name][1]:remove() end
            mtsedit.savestat[name] = { minetest.add_entity(pointed_thing.under, "mtsedit:selection"), pos }
        elseif mtsedit.savestat[name] ~= nil then
            local p1, p2, mp = {}, {}, mtsedit.savestat[name][2]
            p1 = { x = math.min(mp.x, pos.x), y = math.min(mp.y, pos.y), z = math.min(mp.z, pos.z) }
            p2 = { x = math.max(mp.x, pos.x), y = math.max(mp.y, pos.y), z = math.max(mp.z, pos.z) }
            mp = { x = math.floor((1 + p2.x - p1.x) / 2) + p1.x, y = math.floor((1 + p2.y - p1.y) / 2) + p1.y, z = math.floor((1 + p2.z - p1.z) / 2) + p1.z}
            mtsedit.savestat[name][1]:set_pos(mp)
            mtsedit.savestat[name][1]:set_properties({visual_size={x=p2.x-p1.x, y=p2.y-p1.y, z=p2.z-p1.z}})
            mtsedit.savestat[name][3] = pos
        end
        return nil
    end,
    on_place = function(itemstack, user, pointed_thing)
        local name = user:get_player_name()
        if pointed_thing.type == "node" then
            if mtsedit.loadstat[name] ~= nil then
                local pos, dir, st = pointed_thing.above, user:get_look_dir(), mtsedit.loadstat[name]
                local d, r, x, z = "z", 0, math.abs(dir.x), math.abs(dir.z)
                if x > z then
                    if dir.x > 0 then r = 90 else r = 270; pos.x = pos.x - st[2] end
                else
                    if dir.z < 0 then r = 180; pos.z = pos.z - st[3]; end; d = "x"
                end
                if minetest.place_schematic(pos, st[1], r, {}, true, {["place_center_"..d] = true}) == nil then
                    minetest.chat_send_player(name, "mtsedit: " .. S("Failed to place the schematic @1", fn))
                end
            else
                minetest.chat_send_player(name, "mtsedit: " .. S("First use the \"/mtsedit load\" chat command to load a schematic"))
            end
        end
    end,
})

-- Register chat commands
minetest.register_chatcommand("mtsedit", {
    description = S("Load and save MTS files easily or export MTSEdit block data"),
    params = S("[load|list|save|export|imgs|help] [file]"),
    func = function(name, param)
        -- give placement tool
        local structitem = ItemStack("mtsedit:place")
        local inv = minetest.get_inventory({type="player",name=name})
        if not inv:contains_item("main", "mtsedit:place") and  not inv:contains_item("hand", "mtsedit:place") then
            local left = inv:add_item("hand", structitem)
            if not left:is_empty() then left = inv:add_item("main", left) end
        end
        -- parse arguments
        if param == nil or param == "" or param == "help" then
            minetest.chat_send_player(name, "  /mtsedit load <mts> - " .. S("Load an MTS file from \"(world directory)/schems/<schematic>.mts\" into the world"))
            minetest.chat_send_player(name, "  /mtsedit list - " .. S("Show available schematic files"))
            minetest.chat_send_player(name, "  /mtsedit save <mts> - " .. S("Save the selected area into an MTS file"))
            minetest.chat_send_player(name, "  /mtsedit grow <delta> - " .. S("Grow or shrink the selected area"))
            minetest.chat_send_player(name, "  /mtsedit export <palette> - " .. S("Export node data to <palette> column of \"(world directory)/blocks.csv\""))
            minetest.chat_send_player(name, "  /mtsedit imgs - " .. S("Export node texture data to \"(world directory)/blockimgs.csv\""))
        else
            local startp,endp = string.find(param .. " ", " ", 3)
            local arg = string.sub(param, startp+1)
            if     string.sub(param, 1, 4) == "load" then return mtsedit.load(name, arg)
            elseif string.sub(param, 1, 4) == "list" then return mtsedit.list(name)
            elseif string.sub(param, 1, 4) == "save" then return mtsedit.save(name, arg)
            elseif string.sub(param, 1, 4) == "grow" then return mtsedit.grow(name, arg)
            elseif string.sub(param, 1, 6) == "export" then return mtsedit.export(arg)
            elseif string.sub(param, 1, 4) == "imgs" then return mtsedit.imgs()
            else return false, S("Unknown mtsedit command") end
        end
        return false, ""
    end,
})
