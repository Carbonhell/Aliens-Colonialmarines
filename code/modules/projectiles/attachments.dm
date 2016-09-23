//Attachments
//icon_state should start from the left side,not the center
//it'll get centered by the code for the item
//whereas overlay,based on the icon_state, moves it in the right place with x/y GUN offsets
/obj/item/gun_attachment
	name = "attachment"
	desc = "default attachment, if you see this someone fuggd up"
	icon = 'icons/obj/guns/attachments.dmi'
	w_class = 2
	pixel_x = 16
	var/obj/item/weapon/gun/gun //the gun the attachment's attached to.
	var/gun_flag//what attachment is it?BARREL, UNDERBARREL, etc. See in /__DEFINES/guns.dm
	var/special_attackby = FALSE //turn to true if your attachment has an attackby while on-gun,like underbarrel grenade launcher
	var/special_afterattack = FALSE //turn to true if your attachment has an afterattack,like the underbarrel grenade launcher shooting
	var/list/special_effects = list()//special effects, such as an underslug grenade launcher shooting its nade and the likes
//OVERLAY VARS
	var/image/overlay
	var/overlay_x_offset = 0//THOSE TWO OFFSETS SHOULD BE USED ONLY IF NECESSARY. Pratically,if you need the attachment to have a special offset instead of
	var/overlay_y_offset = 0//the default one,set those vars. Keep in mind,those vars are the last to be set with pixel_x/y += overlay_x/y_offset.

/obj/item/gun_attachment/New()
	..()
	overlay = image(icon = icon, icon_state = icon_state)
	for(var/i in special_effects)
		special_effects += new i()
		special_effects -= i

/obj/item/gun_attachment/Destroy()
	if(gun)
		gun.priority_overlays -= overlay
		gun.overlays -= overlay
	gun = null
	qdel(overlay)
	..()

/obj/item/gun_attachment/proc/on_insert(mob/user)//Special action when the attachment's inserted,such as increasing damage, accuracy, and the likes.
	for(var/i in special_effects)
		var/datum/action/A = i
		gun.actions += A
		A.target = gun
		if(gun.loc == user)
			A.Grant(user)
		A.UpdateButtonIcon()
	return

/obj/item/gun_attachment/proc/on_remove(mob/user)
	for(var/i in special_effects)
		var/datum/action/A = i
		if(A.owner)
			A.Remove(A.owner)
		gun.actions -= A
		A.target = null
	gun = null
	return

//default attachment types. Want to make a new barrel attachment? Make it a child of barrel,easy.
/obj/item/gun_attachment/barrel
	gun_flag = BARREL

/obj/item/gun_attachment/optics
	gun_flag = OPTICS
	var/zoomable = TRUE//just incase you wanna make a sight that doesn't zoom...But for what purpose?
	var/zoom_amt = 1
	var/zoomed = FALSE
	var/action_path = /datum/action/item_action/attachment/zoom

/obj/item/gun_attachment/optics/New()
	if(zoomable)
		special_effects += action_path
	..()

/obj/item/gun_attachment/underbarrel
	gun_flag = UNDERBARREL

/obj/item/gun_attachment/stock
	gun_flag = STOCK

/obj/item/gun_attachment/paint
	gun_flag = PAINT

//BARREL
/obj/item/gun_attachment/barrel/suppressor
	name = "suppressor"
	desc = "Lets you feel like a spy."
	var/oldsound = null

/obj/item/gun_attachment/barrel/suppressor/on_insert(mob/user)
	..()
	oldsound = gun.fire_sound
	gun.fire_sound = null

/obj/item/gun_attachment/barrel/suppressor/on_remove(mob/user)
	gun.fire_sound = oldsound
	oldsound = null
	..()

//OPTICS
/obj/item/gun_attachment/optics/normal
	name = "sight"
	desc = "A simple sight which gets the job done."
	icon_state = "scope"
	overlay_y_offset = -1
	zoom_amt = 3

/obj/item/gun_attachment/optics/sniper
	name = "multiple spectrum sight"
	desc = "An electronic scope that sees in the televisual, infra-red and electromagnetic spectrums."
	zoom_amt = 7
	action_path = /datum/action/item_action/attachment/zoom/mss
	var/old_seeinvisible = null
	var/old_seeindark = null
//UNDERBARREL
/obj/item/gun_attachment/underbarrel/bayonet
	name = "bayonet"
	desc = "Feels like First World War all over again."
	icon_state = "bayonet"
	force = 20

/obj/item/gun_attachment/underbarrel/bayonet/on_insert(mob/user)
	..()
	gun.force += force

/obj/item/gun_attachment/underbarrel/bayonet/on_remove(mob/user)
	gun.force -= force
	..()


/obj/item/gun_attachment/underbarrel/forwardgrip
	name = "forward grip"
	desc = "Makes the gun easier to handle, effectively reducing the recoil."
	var/oldrecoil = 0

/obj/item/gun_attachment/underbarrel/forwardgrip/on_insert(mob/user)
	..()
	oldrecoil = gun.recoil
	gun.recoil--

/obj/item/gun_attachment/underbarrel/forwardgrip/on_remove(mob/user)
	gun.recoil = oldrecoil
	oldrecoil = 0
	..()


/obj/item/gun_attachment/underbarrel/nadelauncher
	name = "underslung grenade launcher"
	desc = "All the perks of a grenade launcher on your primary gun!What else would you ask for?"
	icon_state = "grenade"
	special_effects = list(/datum/action/item_action/attachment/nadelauncher)
	special_attackby = TRUE
	var/obj/item/weapon/gun/projectile/revolver/grenadelauncher/G

/obj/item/gun_attachment/underbarrel/nadelauncher/New()
	G = new(src)
	..()

/obj/item/gun_attachment/underbarrel/nadelauncher/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/ammo_casing))
		G.attack_self(user)
		G.attackby(I, user, params)
		return G.chambered

/obj/item/gun_attachment/underbarrel/nadelauncher/afterattack(atom/target, mob/living/user, flag, params)
	if(gun)
		return G.afterattack(target, user, flag, params)

//STOCK
//PAINT

//ACTIONS

//Attachments' special actions. Put 'em in the special_effects list of your attachment.
/datum/action/item_action/attachment
	name = "Default attachment action"

/datum/action/item_action/attachment/IsAvailable()
	if(!..())
		return 0
	if(target && (owner.l_hand == target || owner.r_hand == target))
		return 1
	return 0

/datum/action/item_action/attachment/nadelauncher
	name = "Toggle underbarrel grenade launcher"

/datum/action/item_action/attachment/zoom
	name = "Zoom"
	button_icon_state = "sniper_zoom"

/datum/action/item_action/attachment/zoom/IsAvailable()
	if(!..())
		return 0
	var/obj/item/weapon/gun/G = target
	if(!istype(G))
		return 0
	var/obj/item/gun_attachment/optics/Z = locate() in G.attachments
	if(!istype(Z))
		return 0
	if(Z.zoomed)
		zoom(owner, FALSE)
	return 1

/datum/action/item_action/attachment/zoom/Trigger()
	if(!..())
		return
	var/obj/item/weapon/gun/G = target
	if(!istype(G))
		return
	var/obj/item/gun_attachment/optics/Z = locate() in G.attachments
	if(!istype(Z))
		return
	var/diditzoom = zoom(owner)
	owner << "<span class='notice'>You [diditzoom ? "start" : "stop"] aiming with \the [Z.name].</span>"
	return 1

/datum/action/item_action/attachment/zoom/Remove()
	zoom(owner, FALSE)
	..()

/datum/action/item_action/attachment/zoom/proc/zoom(mob/living/user, forced_zoom)
	if(!user || !user.client)
		return
	var/obj/item/weapon/gun/G = target
	if(!istype(G))
		return
	var/obj/item/gun_attachment/optics/Z = locate() in G.attachments
	if(!istype(Z))
		return

	switch(forced_zoom)
		if(FALSE)
			Z.zoomed = FALSE
		if(TRUE)
			Z.zoomed = TRUE
		else
			Z.zoomed = !Z.zoomed

	if(Z.zoomed)
		var/_x = 0
		var/_y = 0
		switch(user.dir)
			if(NORTH)
				_y = Z.zoom_amt
			if(EAST)
				_x = Z.zoom_amt
			if(SOUTH)
				_y = -Z.zoom_amt
			if(WEST)
				_x = -Z.zoom_amt

		user.client.pixel_x = world.icon_size*_x
		user.client.pixel_y = world.icon_size*_y
	else
		user.client.pixel_x = 0
		user.client.pixel_y = 0
	return Z.zoomed

/datum/action/item_action/attachment/zoom/mss

/datum/action/item_action/attachment/zoom/mss/Trigger()
	if(!..())
		return
	var/obj/item/weapon/gun/G = target
	if(!istype(G))
		return
	var/obj/item/gun_attachment/optics/sniper/Z = locate() in G.attachments
	if(!istype(Z))
		return
	if(isnull(Z.old_seeinvisible))
		Z.old_seeinvisible = owner.see_invisible
		Z.old_seeindark = owner.see_in_dark
		owner.see_invisible = SEE_INVISIBLE_MINIMUM
		owner.see_in_dark += 15
	else
		owner.see_invisible = Z.old_seeinvisible
		owner.see_in_dark = Z.old_seeindark
		Z.old_seeinvisible = null
		Z.old_seeindark = null
		owner.update_sight()

/datum/action/item_action/attachment/zoom/mss/Remove()
	var/obj/item/weapon/gun/G = target
	if(!istype(G))
		return ..()
	var/obj/item/gun_attachment/optics/sniper/Z = locate() in G.attachments
	if(!istype(Z))
		return ..()
	if(!isnull(Z.old_seeinvisible))
		owner.see_invisible = Z.old_seeinvisible
		owner.see_in_dark = Z.old_seeindark
		Z.old_seeinvisible = null
		Z.old_seeindark = null
		owner.update_sight()
	..()