#define GATEWAY_DEST_ANOTHER_UNIVERSE "cataclysm_another_universe"

/datum/station_goal/spatial_emmigration
	name = "Emergency Spatial Emmigration"

/datum/gateway_destination/point/another_universe
	id = GATEWAY_DEST_ANOTHER_UNIVERSE

/datum/gateway_destination/point/another_universe/New()
	if (another_universe_dest != null)
		return another_universe_dest
	another_universe_dest = src

/obj/effect/landmark/awaystart/another_universe
	id = GATEWAY_DEST_ANOTHER_UNIVERSE

/obj/effect/landmark/awaystart/another_universe/Initialize()
	var/datum/gateway_destination/point/another_universe/current
	current = another_universe_dest
	if(!current)
		current = new
	current.target_turfs += get_turf(src)

GLOBAL_DATUM(another_universe_dest, /datum/gateway_destination/point/another_universe)

/obj/machinery/gateway/bs_evac_gateway
	icon = 'waspstation/icons/obj/machines/evac_gateway.dmi'
	var/transited_players = 0
	critical_machine = TRUE
	circuit = /obj/item/circuitboard/machine/bs_evac_gateway

/obj/machinery/gateway/bs_evac_gateway/Initialize()
	use_power = NO_POWER_USE
	destination_type = /datum/gateway_destination/point/another_universe
	destination_name = "Another Universe"
	return ..()

/obj/machinery/gateway/bs_evac_gateway/generate_destination()
	destination = another_universe_dest

/obj/machinery/gateway/bs_evac_gateway/proc/check_fuel_requirements()
	return TRUE

/obj/machinery/gateway/bs_evac_gateway/activate()
	var/datum/gateway_destination/point/another_universe/AU = another_universe_dest
	if (!istype(AU))
		CRASH("Failed to configure destination for another universe!")
	target = D
	target.activate(destination)
	generate_bumper()
	update_icon()

/obj/machinery/gateway/bs_evac_gateway/deactivate()
	return // No brakes on this train!

/obj/machinery/gateway/bs_evac_gateway/process()
	return

/obj/machinery/gateway/bs_evac_gateway/Transfer()
	transited_players += 1
	..()

/obj/machinery/gateway/bs_evac_gateway/can_be_unfasten_wrench()
	return FAILED_UNFASTEN

/obj/machinery/gateway/bs_evac_gateway/update_icon_state()
	if (is_fueled && target)
		icon_state = "evac_gateway_on"
	else
		icon_state = "evac_gateway_off"

/obj/item/circuitboard/machine/bs_evac_gateway
	name = "Bluespace Evacuation Gateway (Machine Board)"
	icon_state = "command"
	build_path = /obj/machinery/gateway/bs_evac_gateway
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 20,
		/obj/item/stock_parts/subspace/filter = 30,
		/obj/item/stock_parts/subspace/crystal = 10,
		/obj/item/stock_parts/matter_bin/bluespace = 10,
		/obj/item/stock_parts/micro_laser/quadultra = 5,
		/obj/item/stock_parts/manipulator/femto = 3,
		/obj/item/stock_parts/scanning_module/triphasic = 1,
		/obj/item/stack/cable_coil = 30
	)

/datum/supply_pack/engineering/bs_evac_gateway_kit
	name = "Bluespace Evacuation Gateway Kit"
	desc = "Released as part of CASE OMEGA, contains the circuitry for the Bluepsace Evacuation Gateway"
	cost = 1000
	special = TRUE
	contains = list() // TODO
	crate_name = "bluespace evacuation gateway kit"

/datum/station_goal/spatial_emmigration/New()
	..()

/datum/station_goal/spatial_emmigration/get_report()
	return {"<b>A Catastrophic Bluespace Event has occurred within the core worlds.</b>
	 Multiple high level communiques have confirmed a cataclysmic bluespace event has begun rendering all space-time within the local galactic cluser uninhabitable to all forms of life.
	 NT Scientists have determined that this event is irreversable and will require execution of CASE OMEGA.
	 CASE OMEGA instructs all orbital stations to construct Interdimensional Escape Bridges and evacuate through them before the effects of the event reach your station.
	 This is a one way trip. Bring only what is essential to your survival. We do not know what may await you on the other side.
	 Specifications for emergency evacuation equipment is being made available to all NT/SolGov stations in the sector.
	 There will be no further evacuation shuttles. All crew-safe logistical infrastructure has been dedicated to distributing evacuation equipment to underequipped stations.
	 Syndicate Forces are guaranteed to attempt to evacuate through your gate. Ensure they do not succeed.
	 You will have an estimated <b>90 minutes</b> until the cascade event reaches your station.
	 Evacuation Gateway parts are available for shipping via cargo."}

/datum/station_goal/spatial_emmigration/on_report()
	var/datum/supply_pack/P = SSshuttle.supply_packs[/datum/supply_pack/engineering/bs_evac_gateway_kit]
	P.special_enabled = TRUE
	var/datum/game_mode/cataclysm/C = SSticker.mode
	if (!istype(C))
		CRASH("Invalid game_mode [SSticker.mode] for executing start_countdown. Aborting!")
	C.start_countdown()

/datum/station_goal/spatial_emmigration/check_completion()
	if(..())
		return TRUE
	for(var/obj/machinery/gateway/bs_evac_gateway/B in GLOB.machines)
		if(B.transited_players >= 1)
			return TRUE
	return FALSE

