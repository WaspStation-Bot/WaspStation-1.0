/obj/structure/overmap/event
	name = "generic overmap event"
	integrity = 0
	///Should the affect_ship() proc be called more than once?
	var/affect_multiple_times = FALSE
	///If prob(this), call affect_ship when processed
	var/chance_to_affect = 0
	///Chance to spread to nearby tiles if spawned
	var/spread_chance = 0
	///The event to run when the station gets hit by an event
	var/datum/round_event_control/station_event

/obj/structure/overmap/event/Initialize(mapload, _id)
	. = ..()
	LAZYADD(SSovermap.events, src)

/obj/structure/overmap/event/Del()
	. = ..()
	LAZYREMOVE(SSovermap.events, src)

/obj/structure/overmap/event/proc/apply_effect()
	if(affect_multiple_times)
		for(var/obj/structure/overmap/ship/S in close_overmap_objects)
			if(prob(chance_to_affect))
				affect_ship(S)

/obj/structure/overmap/event/proc/affect_ship(obj/structure/overmap/ship/S)
	return

/obj/structure/overmap/event/proc/ship_action(obj/structure/overmap/ship/S, mob/user)
	return

/obj/structure/overmap/event/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(AM, /obj/structure/overmap/ship))
		affect_ship(AM)
	else if(istype(AM, /obj/structure/overmap/level/main))
		var/datum/round_event_control/E = new station_event()
		E.runEvent()

///METEOR STORMS - Bounces harmlessly off the shield... unless your shield is breached
/obj/structure/overmap/event/meteor
	name = "asteroid storm (moderate)"
	icon_state = "meteor1"
	affect_multiple_times = TRUE
	chance_to_affect = 5
	spread_chance = 50
	station_event = /datum/round_event_control/meteor_wave/threatening
	var/max_damage = 15
	var/min_damage = 5

/obj/structure/overmap/event/meteor/Initialize(mapload, _id)
	. = ..()
	icon_state = "meteor[rand(1, 4)]"

/obj/structure/overmap/event/meteor/affect_ship(obj/structure/overmap/ship/S)
	var/area/source_area = pick(S.shuttle.shuttle_areas)
	source_area.set_fire_alarm_effect()
	if(S.integrity <= 0)
		var/source_object = pick(source_area.contents)
		dyn_explosion(source_object, rand(min_damage, max_damage) / 2)
	else
		S.recieve_damage(rand(min_damage, max_damage))
		for(var/MN in GLOB.player_list)
			var/mob/M = MN
			if(S.shuttle.is_in_shuttle_bounds(M))
				var/strength = abs(S.integrity - initial(S.integrity))
				M.playsound_local(S.shuttle, 'sound/effects/explosionfar.ogg', strength)
				shake_camera(M, 10, strength / 10)

/obj/structure/overmap/event/meteor/minor
	name = "asteroid storm (minor)"
	station_event = /datum/round_event_control/meteor_wave
	max_damage = 10
	min_damage = 3

/obj/structure/overmap/event/meteor/major
	name = "asteroid storm (major)"
	spread_chance = 25
	station_event = /datum/round_event_control/meteor_wave/catastrophic
	max_damage = 25
	min_damage = 10

///ION STORM - Causes EMP pulses on the shuttle, wreaking havoc on the shields
/obj/structure/overmap/event/emp
	name = "ion storm (moderate)"
	icon_state = "ion1"
	spread_chance = 20
	station_event = /datum/round_event_control/ion_storm
	var/strength = 3

/obj/structure/overmap/event/emp/Initialize(mapload, _id)
	. = ..()
	icon_state = "ion[rand(1, 4)]"

/obj/structure/overmap/event/emp/affect_ship(obj/structure/overmap/ship/S)
	var/area/source_area = pick(S.shuttle.shuttle_areas)
	var/source_object = pick(source_area.contents)
	S.recieve_damage(strength * 2)
	source_area.set_fire_alarm_effect()
	empulse(get_turf(source_object), round(rand(strength / 2, strength)), rand(strength, strength * 2))

/obj/structure/overmap/event/emp/minor
	name = "ion storm (minor)"
	strength = 1

/obj/structure/overmap/event/emp/major
	name = "ion storm (major)"
	strength = 5

///ELECTRICAL STORM - Zaps places in the shuttle
/obj/structure/overmap/event/electric
	name = "electrical storm (moderate)"
	icon_state = "electrical1"
	spread_chance = 30
	station_event = /datum/round_event_control/grid_check
	var/max_damage = 15
	var/min_damage = 5

/obj/structure/overmap/event/electric/Initialize(mapload, _id)
	. = ..()
	icon_state = "electrical[rand(1, 4)]"

/obj/structure/overmap/event/electric/affect_ship(obj/structure/overmap/ship/S)
	var/area/source_area = pick(S.shuttle.shuttle_areas)
	source_area.set_fire_alarm_effect()
	if(S.integrity <= 0)
		var/source_object = pick(source_area.contents)
		tesla_zap(source_object, rand(min_damage, max_damage) / 2)
	else
		S.recieve_damage(rand(min_damage, max_damage))
		for(var/MN in GLOB.player_list)
			var/mob/M = MN
			if(S.shuttle.is_in_shuttle_bounds(M))
				var/strength = abs(S.integrity - initial(S.integrity))
				M.playsound_local(S.shuttle, 'sound/magic/lightningshock.ogg', strength)
				shake_camera(M, 10, strength / 10)

/obj/structure/overmap/event/electric/minor
	name = "electrical storm (minor)"
	spread_chance = 40
	max_damage = 10
	min_damage = 3

/obj/structure/overmap/event/electric/major
	name = "electrical storm (major)"
	spread_chance = 15
	max_damage = 20
	min_damage = 10

/obj/structure/overmap/event/nebula
	name = "nebula"
	icon_state = "nebula"
	spread_chance = 75
	opacity = TRUE

/obj/structure/overmap/event/wormhole
	name = "wormhole"
	icon_state = "wormhole"
	spread_chance = 0
	///The currently linked wormhole
	var/obj/structure/overmap/event/wormhole/other_wormhole
	///Amount of times a ship can pass through before it collapses
	var/stability

/obj/structure/overmap/event/wormhole/Initialize(mapload, _id, _other_wormhole)
	. = ..()
	if(_other_wormhole)
		other_wormhole = _other_wormhole
	if(!other_wormhole)
		other_wormhole = new(SSovermap.get_unused_overmap_square(), "[id]_exit", src)

/obj/structure/overmap/event/wormhole/affect_ship(obj/structure/overmap/ship/S)
	if(--stability <= 0)
		S.recieve_damage(rand(20, 30))
		S.Move(SSovermap.get_unused_overmap_square())
		QDEL_NULL(other_wormhole)
		return qdel(src)
	other_wormhole.stability = stability
	S.Move(get_step(other_wormhole, S.dir))
