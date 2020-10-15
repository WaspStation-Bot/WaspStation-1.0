GLOBAL_DATUM(dcm_hub_default, /obj/machinery/computer/dcm_hub)

/obj/machinery/computer/dcm_hub
	name = "Deepcore Mining Control Hub"
	desc = "Houses the server which processes all connected mining equipment."
	icon = 'waspstation/icons/obj/machines/deepcore.dmi'
	icon_state = "hub"
	var/list/datum/component/remote_mining/connected = list()

/obj/machinery/computer/dcm_hub/Initialize(mapload)
	if(!GLOB.dcm_hub_default && mapload && is_station_level(z))
		GLOB.dcm_hub_default = src

/obj/machinery/computer/dcm_hub/Destroy()
	if(GLOB.ore_silo_default == src)
		GLOB.ore_silo_default = null

	for(var/C in connected)
		var/datum/component/remote_mining/network = C
		network.disconnect(src)

	connected = null

	return ..()

/obj/machinery/computer/dcm_hub/examine(mob/user)
	. = ..()
	. += "<span class='info'>Network linked to [connected.len] machines.</span>"
	. += "<span class='notice'>Deep core mining equipment can be linked to [src] with a multitool.</span>"

/obj/machinery/computer/dcm_hub/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I))
		to_chat(user, "<span class='notice'>You log [src] in the multitool's buffer.</span>")
		I.buffer = src
		return TRUE

/obj/machinery/computer/dcm_hub/ui_interact(mob/user, datum/tgui/ui)
	user.set_machine(src)
	var/datum/browser/popup = new(user, "dcm_hub", null, 600, 550)
	popup.set_content(generate_ui())
	popup.open()

// DCM NETWORK LOGIC

/obj/machinery/computer/dcm_hub/proc/updateDistribution()
	for(datum/component/remote_mining/C in connected)
		if(C.type_flags & DCM_TYPE_INPUT)

		if(C.type_flags & DCM_TYPE_OUTPUT)

/obj/machinery/computer/dcm_hub/proc/generate_ui()
	return "TODO: HUB UI"
