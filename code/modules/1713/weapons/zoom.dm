/*
Should be used for all zoom mechanics
Parts of code courtesy of Super3222
*/

/obj/item/weapon/attachment/scope
	name = "generic scope"
	icon = 'icons/obj/device.dmi'
	icon_state = "telescope1"
	zoomdevicename = null
	var/zoom_amt = 3
	var/zoomed = FALSE
	var/datum/action/toggle_scope/azoom
	attachment_type = ATTACH_SCOPE
	slot_flags = SLOT_POCKET|SLOT_BELT
	value = 15

/obj/item/weapon/attachment/scope/Destroy()
	azoom = null
	..()

/obj/item/weapon/attachment/scope/New()
	..()
	build_zooming()

/obj/item/weapon/attachment/scope/adjustable
	name = "generic adjustable scope"
	var/min_zoom = 3
	var/max_zoom = 3
	var/looking = FALSE

/obj/item/weapon/attachment/scope/adjustable/New()
	..()
	zoom_amt = max_zoom // this really makes more sense IMO, 95% of people will just set it to the max - Kachnov

//Not actually an attachment
/obj/item/weapon/attachment/scope/adjustable/binoculars
	name = "telescope"
	desc = "A naval telescope."
	max_zoom = ZOOM_CONSTANT*3
	attachable = FALSE
	value = 15

/obj/item/weapon/attachment/scope/adjustable/binoculars/small
	name = "telescope"
	desc = "A small telescope."
	max_zoom = 10
	attachable = FALSE
	value = 15

/obj/item/weapon/attachment/scope/adjustable/binoculars/binoculars
	name = "binoculars"
	desc = "A pair of binoculars."
	icon_state = "binoculars"
	max_zoom = ZOOM_CONSTANT*3
	attachable = FALSE
	value = 15

/obj/item/weapon/attachment/scope/adjustable/binoculars/periscope
	name = "periscope"
	desc = "A solid metal periscope."
	icon_state = "periscope"
	max_zoom = ZOOM_CONSTANT*3
	attachable = FALSE
	value = 15
	var/obj/structure/bed/chair/commander/commanderchair = null
	anchored = FALSE
	flammable = FALSE
	nothrow = TRUE
	nodrop = TRUE
	w_class = 5
	var/checking = FALSE

/obj/item/weapon/attachment/scope/adjustable/binoculars/periscope/naval
	name = "periscope"
	desc = "A solid metal periscope."
	icon_state = "periscope"
	max_zoom = ZOOM_CONSTANT*4

/obj/item/weapon/attachment/scope/adjustable/binoculars/periscope/proc/rangecheck(var/mob/living/human/H, var/atom/target)
	if (checking)
		return

	checking = TRUE
	var/dist1 = abs(H.x-target.x)
	var/dist2 = abs(H.y-target.y)
	var/distcon = max(dist1,dist2)
	var/gdir = get_dir(H, target)
	H << "You start checking the range..."
	if (do_after(H, 25, src, can_move = TRUE))
		H << "<big><b><font color='#ADD8E6'>Range: about [max(0,distcon+rand(-1,1))] meters [dir2text(gdir)].</font></b></big>"
		checking = FALSE
	else
		checking = FALSE
/obj/item/weapon/attachment/scope/adjustable/verb/adjust_scope_verb()
	set name = "Adjust Zoom"
	set category = null
	var/mob/living/human/user = usr
	if (istype(src, /obj/item/weapon/gun))
		var/obj/item/weapon/gun/G = src
		for (var/obj/item/weapon/attachment/scope/adjustable/A in G.attachments)
			src = A
	adjust_scope(user)

/obj/item/weapon/attachment/scope/adjustable/proc/adjust_scope(mob/living/human/user)

	if (!Adjacent(user))
		return

	if (looking)
		return

	if (user.looking)
		user.look_into_distance(user, 0)

	looking = TRUE

	if (do_after(user, 7, src))

		looking = FALSE

		var/input = input(user, "Set the zoom amount.", "Zoom" , "") as num
		if (input == zoom_amt)
			return

		var/dial_check = FALSE

		if (input > max_zoom)
			if (zoom_amt == max_zoom)
				user << "<span class='warning'>You can't adjust it any further.</span>"
				return
			else
				zoom_amt = max_zoom
				dial_check = TRUE
		else if (input < min_zoom)
			if (zoom_amt == min_zoom)
				user << "<span class='warning'>You can't adjust it any further.</span>"
				return
			else
				zoom_amt = min_zoom
		else
			if (input > zoom_amt)
				dial_check = TRUE
			zoom_amt = input

		user << "<span class='notice'>You twist the dial on [src] [dial_check ? "clockwise, increasing" : "counterclockwise, decreasing"] the zoom range to [zoom_amt].</span>"

//Proc, so that gun accessories/scopes/etc. can easily add zooming.
/obj/item/weapon/attachment/scope/proc/build_zooming()
	azoom = new()
	azoom.scope = src
	actions += azoom

/obj/item/weapon/attachment/scope/on_enter_storage(S)
	..(S)
	if (azoom)
		azoom.Remove(azoom.owner)

/obj/item/weapon/attachment/scope/on_changed_slot()
	..()

	if (azoom)

		if (istype(loc, /obj/item))
			var/mob/M = loc.loc
			if (M && istype(M))
				azoom.Remove(M)
				if(loc == M.r_hand || loc == M.l_hand)
					azoom.Grant(M)

		else if (istype(loc, /mob))
			var/mob/M = loc
			if (istype(M))
				azoom.Remove(M)
				if (src == M.r_hand || src == M.l_hand)
					azoom.Grant(M)

/obj/item/weapon/attachment/scope/dropped(mob/user)
	..()
	if (azoom)
		azoom.Remove(user)
