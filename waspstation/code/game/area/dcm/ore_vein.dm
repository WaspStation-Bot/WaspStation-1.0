/*\
	# Ore Veins
	Represents material hidden beneath the earth for Deep Core Mining
\*/
/area/lavaland/surface/ore_vein
	name = "Undefined Ore Vein"
	var/obj/item/stack/ore/ore_type //What you're pulling out of the ground
	var/material_rate_coeff = 0	//Affects overall value of the ore vein
	var/obj/machinery/deepcore/drill/active_drill

/area/lavaland/surface/ore_vein/proc/extract_ore() //Called by deepcore drills, returns a list of keyed ore stacks by amount
	return list(ore_type = round(sqrt(areasize) * material_rate_coeff * 10))

/area/lavaland/surface/ore_vein/iron
	name = "Iron Ore Vein"
	ore_type = /obj/item/stack/ore/iron
	material_rate_coeff = 0.6

/area/lavaland/surface/ore_vein/plasma
	name = "Inert Plasma Vein"
	ore_type = /obj/item/stack/ore/plasma
	material_rate_coeff = 0.5

/area/lavaland/surface/ore_vein/gold
	name = "Gold Ore Vein"
	ore_type = /obj/item/stack/ore/gold
	material_rate_coeff = 0.3

/area/lavaland/surface/ore_vein/silver
	name = "Silver Ore Vein"
	ore_type = /obj/item/stack/ore/silver
	material_rate_coeff = 0.4

/area/lavaland/surface/ore_vein/titanium
	name = "Titanium Ore Vein"
	ore_type = /obj/item/stack/ore/titanium
	material_rate_coeff = 0.3

/area/lavaland/surface/ore_vein/uranium
	name = "Uranium Ore Vein"
	ore_type = /obj/item/stack/ore/uranium
	material_rate_coeff = 0.2

/area/lavaland/surface/ore_vein/diamond
	name = "Diamond Ore Vein"
	ore_type = /obj/item/stack/ore/diamond
	material_rate_coeff = 0.1
