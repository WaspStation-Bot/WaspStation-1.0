/datum/component/remote_mining
	var/obj/machinery/deepcore/machines = list()
	var/datum/material_container/mat_container
	var/allow_standalone

/datum/component/remote_mining/Initialize(mapload)
	if (!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ATOM_MULTITOOL_ACT, .proc/OnMultitool)

	var/turf/T = get_turf(parent)
	if ((mapload && is_station_level(T.z)))
		addtimer(CALLBACK(src, .proc/LateInitialize))

/datum/component/remote_materials/proc/LateInitialize()
	for (var/obj/machinery/deepcore/M in GLOB.dcm_default)
		machines += M
		M.network = src

/datum/component/remote_materials/Destroy()
	for (var/obj/machinery/deepcore/M in machines)
		M.network -= src
		M.updateUsrDialog()
	machines = null
	mat_container = null
	return ..()

/datum/component/remote_mining/proc/OnMultitool(datum/source, mob/user, obj/item/I)
	if(!I.multitool_check_buffer(user, I))
		return COMPONENT_BLOCK_TOOL_ATTACK
	var/obj/item/multitool/M = I
	if (!QDELETED(M.buffer) && istype(M.buffer, /obj/machinery/deepcore))
		if (M.buffer in machines) //Buffer is already on the network
			to_chat(user, "<span class='warning'>[parent] is already connected to the same network!</span>")
			return COMPONENT_BLOCK_TOOL_ATTACK
		if (M.buffer.network != null) //Buffer is on a different network
			var/prompt = alert(user, "Merge networks or move [M.buffer] to the new network?", "Deep Core Network", "Merge", "Move", "Cancel")
			switch(prompt)
				if("Merge") //TODO: MERGE NETWORKS
					to_chat(user, "<span class='userdanger'>Feature incomplete, scree at AsciiSquid.</span>")
				if("Move")
					M.buffer.network.machines -= M.buffer
					M.buffer.network = src
					to_chat(user, "<span class='notice'>[M.buffer] has been moved to the new network.</span>")
					return COMPONENT_BLOCK_TOOL_ATTACK
				if("Cancel")
					return COMPONENT_BLOCK_TOOL_ATTACK
		else //Buffer needs a network
			M.buffer.network = src
			to_chat(user, "<span class='notice'>You connect the [M.buffer] to the network.</span>")
		return COMPONENT_BLOCK_TOOL_ATTACK
