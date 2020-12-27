/*\
	# Ore Veins
	Represents material hidden beneath the earth for Deep Core Mining
\*/
/area/lavaland/surface/ore_vein
	name = "Undefined Ore Vein"
	var/obj/item/stack/ore/ore_type //What you're pulling out of the ground
	var/material_rate = 0	//Affects overall value of the ore vein
	var/obj/machinery/deepcore/drill/active_drill
	outdoors = FALSE //Considered "indoors" to enable area calculations

/area/lavaland/surface/ore_vein/proc/extract_ore() //Called by deepcore drills, returns a list of keyed ore stacks by amount
	var/list/ores = list()
	if(!areasize)
		update_areasize()
	ores[ore_type] = CEILING((sqrt(areasize) * material_rate), 1)
	return ores

/area/lavaland/surface/ore_vein/iron
	name = "Iron Ore Vein"
	ore_type = /obj/item/stack/ore/iron
	material_rate = 6

/area/lavaland/surface/ore_vein/plasma
	name = "Inert Plasma Vein"
	ore_type = /obj/item/stack/ore/plasma
	material_rate = 5

/area/lavaland/surface/ore_vein/gold
	name = "Gold Ore Vein"
	ore_type = /obj/item/stack/ore/gold
	material_rate = 3

/area/lavaland/surface/ore_vein/silver
	name = "Silver Ore Vein"
	ore_type = /obj/item/stack/ore/silver
	material_rate = 4

/area/lavaland/surface/ore_vein/titanium
	name = "Titanium Ore Vein"
	ore_type = /obj/item/stack/ore/titanium
	material_rate = 3

/area/lavaland/surface/ore_vein/uranium
	name = "Uranium Ore Vein"
	ore_type = /obj/item/stack/ore/uranium
	material_rate = 2

/area/lavaland/surface/ore_vein/diamond
	name = "Diamond Ore Vein"
	ore_type = /obj/item/stack/ore/diamond
	material_rate = 1
