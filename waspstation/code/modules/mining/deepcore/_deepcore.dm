/obj/machinery/deepcore
	icon = 'waspstation/icons/obj/machines/deepcore.dmi'

	var/type_flags //Check _DEFINES/DCM.dm
	var/datum/component/remote_mining/network

/obj/machinery/deepcore/Initialize(mapload)
	. = ..()
	network = AddComponent(/datum/component/remote_mining, type_flags, mapload)

