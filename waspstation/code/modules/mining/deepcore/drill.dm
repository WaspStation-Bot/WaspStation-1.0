/obj/machinery/deepcore/drill
	name = "Deep Core Bluespace Drill"
	desc = "A sophisticated machince capable of extracting ores deep within a planets surface."
	icon = 'waspstation/icons/obj/machines/drill.dmi'
	icon_state = "deep_core_drill"
	density = TRUE
	anchored = FALSE
	type_flags = DCM_TYPE_INPUT
	use_power = NO_POWER_USE
	pressure_resistance = 30
	max_integrity = 300
	integrity_failure = 0.2

	var/deployed = FALSE //If the drill is anchored and ready-to-mine
	var/active = FALSE //If the drill is activly mining ore
	var/area/ore_vein/active_vein //Ore vein currently set to be mined in

/obj/machinery/deepcore/drill/Initialize(mapload)
	. = ..()

/obj/machinery/deepcore/drill/process()
	if(machine_stat & BROKEN || active && !active_vein)
		active = FALSE
		return
	if(deployed && active)

		if(network)
			return
			//TODO: DCMnet
		else //Dry deployment of ores
			return

/obj/machinery/deepcore/drill/proc/mineOre()
	if(!active_vein)
		if(scanArea() != DCM_LOCATED_VEIN)
			return FALSE
	else


/obj/machinery/deepcore/drill/proc/scanArea()
	//Checks for ores and latches to an active vein if one is located.
	var/area/deployed_zone = get_area(src)
	if(deployed_zone && isarea(deployed_zone))
		if(istype(deployed_zone, /area/ore_vein))
			var/area/ore_vein/vein = deployed_zone
			if(!vein.active_drill)
				vein.active_drill = src
				active_vein = vein
				return DCM_LOCATED_VEIN
			else
				return DCM_OCCUPIED_VEIN
		else
			return DCM_NO_VEIN

/obj/machinery/deepcore/drill/update_icon_state()
	if(deployed)
		if(machine_stat & BROKEN)
			icon_state = "deep_core_drill-deployed-broken"
			return
		if(active)
			icon_state = "deep_core_drill-active"
		else
			icon_state = "deep_core_drill-idle"
	else
		if(machine_stat & BROKEN)
			icon_state = "deep_core_drill-broken"
		else
			icon_state = "deep_core_drill"

/obj/machinery/deepcore/drill/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	//Cool beam of light ignores shadows.
	if(active && deployed)
		set_light(1, 1, "99FFFF")
		SSvis_overlays.add_vis_overlay(src, icon, "mining_beam-particles", layer, plane, dir)
		SSvis_overlays.add_vis_overlay(src, icon, "mining_beam-particles", layer, EMISSIVE_PLANE, dir)
	else
		set_light(0)

/obj/machinery/deepcore/drill/obj_break(damage_flag)
	. = ..()
	if(.)
		active = FALSE
		set_light(0)
		update_overlays()

/obj/machinery/deepcore/drill/can_be_unfasten_wrench(mob/user, silent)
	to_chat(user, "<span class='warning'>You don't need a wrench to deploy [src]!</span>")
	return CANT_UNFASTEN

