/obj/machinery/deepcore
	var/datum/component/remote_mining/network

/obj/machinery/deepcore/Initialize(mapload)
	. = ..()
	if(mapload)
		if(GLOB.dcm_network_default)
			network = GLOB.dcm_network_default
		else
			network = AddComponent(/datum/component/remote_mining, mapload)
			GLOB.dcm_network_default = network

