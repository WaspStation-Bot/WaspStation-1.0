/datum/dcm_net
	/* List of connected machines

	*/
	var/list/obj/machinery/deepcore/connected = list()
	/* Ores available for system output
	*/
	var/list/ores //Key = item/stack/ore ref | Value = Stack amount


/datum/dcm_net/New(obj/machinery/deepcore/source)
	connected += source

/datum/dcm_net/Destroy()
	if(connected)
		for (obj/machinery/deepcore/M in connected)
			M.network = null
	return ..()

/datum/dcm_net/proc/AddMachine(obj/machinery/deepcore/M)
	if(!M in connected)
		connected =+ M
		M.network = src
		return TRUE

/datum/dcm_net/proc/RemoveMachine(obj/machinery/deepcore/M)
	if(M in connected)
		connected -= M
		M.network = null
		//Destroys the network if there's no more machines attached
		if(!length(connected))
			connected = null
			qdel(src)
		return TRUE

/datum/dcm_net/proc/MergeWith(datum/dcm_net/net)
	for (var/obj/machinery/deepcore/M in net)
		AddMachine(M)
	qdel(net)

