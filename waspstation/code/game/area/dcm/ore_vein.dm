/*\
	# Ore Veins
	Represents material hidden beneath the earth for Deep Core Mining
\*/
/area/lavaland/surface/ore_vein
	name = "Undefined Ore Vein"
	var/datum/material/material_type //What you're pulling out of the ground
	var/material_rate_coeff = 0	//Affects overall value of the ore vein
	var/material_density		//ore earned per-tick, affected by size of vein
	var/obj/machinery/deepcore/drill/active_drill

/area/lavaland/surface/ore_vein/Initialize()
	. = ..()
	calculate_value()

/area/lavaland/surface/ore_vein/proc/calculate_value()
	material_density = (material_rate_coeff*1000)/(sqrt(areasize)**-1)

/area/lavaland/surface/ore_vein/iron
	name = "Iron Ore Vein"
	material_type = /datum/material/iron
	material_rate_coeff = 0.6

/area/lavaland/surface/ore_vein/plasma
	name = "Inert Plasma Vein"
	material_type = /datum/material/plasma
	material_rate_coeff = 0.5

/area/lavaland/surface/ore_vein/gold
	name = "Gold Ore Vein"
	material_type = /datum/material/gold
	material_rate_coeff = 0.3

/area/lavaland/surface/ore_vein/silver
	name = "Silver Ore Vein"
	material_type = /datum/material/silver
	material_rate_coeff = 0.4

/area/lavaland/surface/ore_vein/titanium
	name = "Titanium Ore Vein"
	material_type = /datum/material/titanium
	material_rate_coeff = 0.3

/area/lavaland/surface/ore_vein/uranium
	name = "Uranium Ore Vein"
	material_type = /datum/material/uranium
	material_rate_coeff = 0.2

/area/lavaland/surface/ore_vein/diamond
	name = "Diamond Ore Vein"
	material_type = /datum/material/diamond
	material_rate_coeff = 0.1
