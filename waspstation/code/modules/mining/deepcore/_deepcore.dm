GLOBAL_DATUM(dcm_net_default, /datum/dcm_net)
/obj/machinery/deepcore
	icon = 'waspstation/icons/obj/machines/deepcore.dmi'
	var/datum/dcm_net/network

/obj/machinery/deepcore/Initialize(mapload)
	. = ..()
	if(mapload && !network)
		if(!GLOB.dcm_net_default)
			GLOB.dcm_net_default = new /datum/dcm_net(mapload)
		network = GLOB.dcm_net_default

/obj/machinery/deepcore/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if(!istype(I))
		return FALSE

	//Check if we would like to add a network
	if(istype(I.buffer, /datum/dcm_net))
		if(network)
			switch(alert("Merge the networks. Move [src] to the buffer network. Or replace the buffer?", "Deep Core Network", "Merge", "Move", "Replace"))
				if("Merge")
					to_chat(user, "<span class='notice'>You merge the network data and load it to [src]...</span>")
					MergeNetwork(I.buffer)
					return TRUE
				if("Move")
					to_chat(user, "<span class='notice'>You move [src] onto the network saved in the multitool's buffer...</span>")
					ClearNetwork()
					SetNetwork(I.buffer)
					return TRUE
				//Passes down to the network storage.
		else
			to_chat(user, "<span class='notice'>You load the saved network data into [src] and test the connection...</span>")
			SetNetwork(I.buffer)
			return TRUE
	//Otherwise just store this one, or make a new one
	if(network)
		to_chat(user, "<span class='notice'>You log the network data of [src] in the multitool's buffer.</span>")
		I.buffer = network
		return TRUE
	else
		to_chat(user, "<span class='notice'>You generate a network and load the information onto [src].</span>")
		network = new /datum/dcm_net(src)
		I.buffer = network
		return TRUE

/obj/machinery/deepcore/examine(mob/user)
	. = ..()
	if(network)
		. += "<span class='info'>This device is registered with a network connected to [length(network.connected)] devices.</span>"

/obj/machinery/deepcore/proc/SetNetwork(var/datum/dcm_net/net)
	return net.AddMachine(src)

/obj/machinery/deepcore/proc/ClearNetwork()
	return network.RemoveMachine(src)

/obj/machinery/deepcore/proc/MergeNetwork(var/datum/dcm_net/net)
	network.MergeWith(net)
