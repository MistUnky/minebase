-- furnaces_api/init.lua

furnaces = {}

function furnaces.get_active_formspec(fuel_percent, item_percent)
	return table.concat({"size[8,8.5]\z
		list[context;src;2.75,0.5;1,1;]\z
		list[context;fuel;2.75,2.5;1,1;]\z
		image[2.75,1.5;1,1;base_furnaces_furnace_fire_bg.png^[lowpart:"
		(fuel_percent), ":base_furnaces_furnace_fire_fg.png]\z
		image[3.75,1.5;1,1;base_gui_arrow_bg.png^[lowpart:",
		(item_percent), ":base_gui_arrow_fg.png^[transformR270]\z
		list[context;dst;4.75,0.96;2,2;]\z
		list[current_player;main;0,4.25;8,1;]\z
		list[current_player;main;0,5.5;8,3;8]\z
		listring[context;dst]\z
		listring[current_player;main]\z
		listring[context;src]\z
		listring[current_player;main]\z
		listring[context;fuel]\z
		listring[current_player;main]",
		base.get_hotbar_bg(0, 4.25)})
end

function furnaces.get_inactive_formspec()
	return "size[8,8.5]\z
		list[context;src;2.75,0.5;1,1;]\z
		list[context;fuel;2.75,2.5;1,1;]\z
		image[2.75,1.5;1,1;base_furnaces_furnace_fire_bg.png]\z
		image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]\z
		list[context;dst;4.75,0.96;2,2;]\z
		list[current_player;main;0,4.25;8,1;]\z
		list[current_player;main;0,5.5;8,3;8]\z
		listring[context;dst]\z
		listring[current_player;main]\z
		listring[context;src]\z
		listring[current_player;main]\z
		listring[context;fuel]\z
		listring[current_player;main]"..
		base.get_hotbar_bg(0, 4.25)
end

