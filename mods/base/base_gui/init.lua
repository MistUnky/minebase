-- base_gui/init.lua

-- GUI related stuff
minetest.register_on_joinplayer(function(player)
	-- Set formspec prepend
	local formspec = [[
			bgcolor[#080808BB;true]
			listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF] ]]
	local name = player:get_player_name()
	local info = minetest.get_player_information(name)
	if info.formspec_version > 1 then
		formspec = formspec .. "background9[5,5;1,1;base_gui_formbg.png;true;10]"
	else
		formspec = formspec .. "background[5,5;1,1;base_gui_formbg.png;true]"
	end
	player:set_formspec_prepend(formspec)

	-- Set hotbar textures
	player:hud_set_hotbar_image("base_gui_hotbar.png")
	player:hud_set_hotbar_selected_image("base_gui_hotbar_selected.png")
end)

function base.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;base_gui_hb_bg.png]"
	end
	return out
end

base.gui_survival_form = "size[8,8.5]\z
	list[current_player;main;0,4.25;8,1;]\z
	list[current_player;main;0,5.5;8,3;8]\z
	list[current_player;craft;1.75,0.5;3,3;]\z
	list[current_player;craftpreview;5.75,1.5;1,1;]\z
	image[4.75,1.5;1,1;base_gui_arrow_bg.png^[transformR270]\z
	listring[current_player;main]\z
	listring[current_player;craft]"
	.. base.get_hotbar_bg(0,4.25)
