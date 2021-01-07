/obj/item/pinpointer/deepcore
	name = "deep core pinpointer"
	desc = "A handheld downsing utility for locating material deep beneath the surface."
	icon = 'waspstation/icons/obj/device.dmi'
	icon_state = "pinpointer_dcm"
	custom_price = 300
	custom_premium_price = 300

/obj/item/pinpointer/deepcore/attack_self(mob/living/user)
	if(active)
		toggle_on()
		user.visible_message("<span class='notice'>[user] deactivates [user.p_their()] pinpointer.</span>", "<span class='notice'>You deactivate your pinpointer.</span>")
		return

	var/vien = LocateVein()
	if(!vein)
		user.visible_message("<span class='notice'>[user]'s pinpointer fails to detect any material.</span>", "<span class='notice'>Your pinpointer fails to detect any material.</span>")
		return

	target = vein
	toggle_on()
	user.visible_message("<span class='notice'>[user] activates [user.p_their()] pinpointer.</span>", "<span class='notice'>You activate your pinpointer.</span>")

/obj/item/pinpointer/deepcore/scan_for_target()
	if(target)
		if(!isloc(target))
			target = null
	if(!target)
		active = FALSE
