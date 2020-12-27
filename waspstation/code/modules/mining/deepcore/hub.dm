// /obj/machinery/computer/dcm_hub
// 	name = "Deepcore Mining Control Hub"
// 	desc = "Houses the server which processes all connected mining equipment."
// 	icon = 'waspstation/icons/obj/machines/deepcore.dmi'
// 	icon_state = "hub"
// 	var/list/datum/dcm_net/connected = list()

// /obj/machinery/computer/dcm_hub/Initialize(mapload)
// 	if(mapload && is_station_level(z))
// 		connected += GLOB.dcm_net_default

// /obj/machinery/computer/dcm_hub/Destroy()
// 	connected = null

// 	return ..()

// /obj/machinery/computer/dcm_hub/examine(mob/user)
// 	. = ..()
// 	. += "<span class='info'>Linked to [connected.len] networks.</span>"
// 	. += "<span class='notice'>Deep core mining equipment can be linked to [src] with a multitool.</span>"

// /obj/machinery/computer/dcm_hub/multitool_act(mob/living/user, obj/item/multitool/I)
// 	. = ..()
// 	if (istype(I) && istype(I.buffer, /datum/dcm_net))
// 		to_chat(user, "<span class='notice'>You load the network data on the multitool to [src] and gain remote access...</span>")
// 		connected += I.buffer
// 		return TRUE

// /obj/machinery/computer/dcm_hub/ui_interact(mob/user, datum/tgui/ui)
// 	user.set_machine(src)
// 	var/datum/browser/popup = new(user, "dcm_hub", null, 600, 550)
// 	popup.set_content(generate_ui())
// 	popup.open()

// // DCM NETWORK LOGIC

// /obj/machinery/computer/dcm_hub/proc/generate_ui()
// 	return "TODO: HUB UI"
