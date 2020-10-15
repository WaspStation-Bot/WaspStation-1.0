/datum/component/remote_mining
	var/obj/machinery/computer/dcm_hub/hub
	var/type_flags

/datum/component/remote_mining/Initialize(type, mapload, force_connect = FALSE)
	if (!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	src.type_flags = type
	RegisterSignal(parent, COMSIG_ATOM_MULTITOOL_ACT, .proc/OnMultitool)
	RegisterSignal(parent, COMSIG_MACHINERY_POWER_LOST, .proc/powerOff)
	RegisterSignal(parent, COMSIG_MACHINERY_POWER_ON, .proc/powerOn)

	var/turf/T = get_turf(parent)
	if (force_connect || (mapload && is_station_level(T.z)))
		addtimer(CALLBACK(src, .proc/LateInitialize))

/datum/component/remote_mining/proc/LateInitialize()
	hub = GLOB.dcm_hub_default
	if (hub)
		hub.connected += src

/datum/component/remote_mining/Destroy()
	if (hub)
		hub.connected -= src
		hub.updateUsrDialog()
		hub = null
	return ..()

/datum/component/remote_mining/proc/disconnect(obj/machinery/computer/dcm_hub/old_hub)
	if(!old_hub || hub != old_hub)
		return
	hub = null

/datum/component/remote_mining/proc/OnMultitool(datum/source, mob/user, obj/item/I)
	if(!I.multitool_check_buffer(user, I))
		return COMPONENT_BLOCK_TOOL_ATTACK
	var/obj/item/multitool/M = I
	if (!QDELETED(M.buffer) && istype(M.buffer, /obj/machinery/computer/dcm_hub))
		if (hub == M.buffer)
			to_chat(user, "<span class='warning'>[parent] is already connected to [hub]!</span>")
			return COMPONENT_BLOCK_TOOL_ATTACK
		if (hub)
			hub.connected -= src
			hub.updateUsrDialog()
		hub = M.buffer
		hub.connected += src
		hub.updateUsrDialog()
		to_chat(user, "<span class='notice'>You connect [parent] to [hub] from the multitool's buffer.</span>")
		return COMPONENT_BLOCK_TOOL_ATTACK

/datum/component/remote_mining/proc/powerOff()
	return

/datum/component/remote_mining/proc/powerOn()
	return
