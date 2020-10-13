GLOBAL_LIST_EMPTY(dcm_default)

/obj/machinery/deepcore
	var/datum/component/remote_mining/network

/obj/machinery/deepcore/Initialize(mapload)
	. = ..()
	if(mapload)
		network = AddComponent(/datum/component/remote_mining, mapload)
