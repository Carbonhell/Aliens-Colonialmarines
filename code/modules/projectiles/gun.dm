/obj/item/weapon/gun
	name = "gun"
	desc = "It's a gun. It's pretty terrible, though."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "detective"
	item_state = "gun"
	flags =  CONDUCT
	slot_flags = SLOT_BELT
	materials = list(MAT_METAL=2000)
	w_class = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	force = 5
	origin_tech = "combat=1"
	needs_permit = 1
	attack_verb = list("struck", "hit", "bashed")

	var/fire_sound = "gunshot"
	var/suppressed = 0					//whether or not a message is displayed when fired
	var/can_suppress = 0
	var/can_unsuppress = 1
	var/recoil = 0						//boom boom shake the room
	var/clumsy_check = 1
	var/obj/item/ammo_casing/chambered = null
	var/trigger_guard = TRIGGER_GUARD_NORMAL	//trigger guard on the weapon, hulks can't fire them with their big meaty fingers
	var/sawn_desc = null				//description change if weapon is sawn-off
	var/sawn_state = SAWN_INTACT
	var/burst_size = 1					//how large a burst is
	var/fire_delay = 0					//rate of fire for burst firing and semi auto
	var/firing_burst = 0				//Prevent the weapon from firing again while already firing
	var/semicd = 0						//cooldown handler
	var/weapon_weight = WEAPON_LIGHT

	var/spread = 0						//Spread induced by the gun itself.
	var/randomspread = 1				//Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.

	var/unique_rename = 0 //allows renaming with a pen
	var/unique_reskin = 0 //allows one-time reskinning
	var/current_skin = null //the skin choice if we had a reskin
	var/list/options = list()

	lefthand_file = 'icons/mob/inhands/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/guns_righthand.dmi'

	var/obj/item/device/firing_pin/pin = /obj/item/device/firing_pin //standard firing pin for ALL guns -Carbonhell

	var/attachments_flags = BARREL|OPTICS|UNDERBARREL|STOCK|PAINT //by default guns can accept any attachment.
	var/list/attachments = list()//list of attachments on the gun. Syntax's reference = flag, like bayonet ref = BARREL
	var/obj/item/gun_attachment/attachment_afterattack = null//if set to the attachment ref, the next afterattack will be the attachment's one and not the gun's one

	var/ammo_x_offset = 0 //used for positioning ammo count overlay on sprite
	var/ammo_y_offset = 0
	var/flight_x_offset = 0
	var/flight_y_offset = 0
	var/attachment_x_offsets = list("barrel" = 0, "optics" = 0, "underbarrel" = 0, "stock" = 0, "paint" = 0)
	var/attachment_y_offsets = list("barrel" = 0, "optics" = 0, "underbarrel" = 0, "stock" = 0, "paint" = 0)

/obj/item/weapon/gun/New()
	..()
	if(pin)
		pin = new pin(src)

/obj/item/weapon/gun/CheckParts(list/parts_list)
	..()
	var/obj/item/weapon/gun/G = locate(/obj/item/weapon/gun) in contents
	if(G)
		G.loc = loc
		qdel(G.pin)
		G.pin = null
		visible_message("[G] can now fit a new pin, but old one was destroyed in the process.")
		qdel(src)

/obj/item/weapon/gun/examine(mob/user)
	..()
	if(pin)
		user << "It has [pin] installed."
	else
		user << "It doesn't have a firing pin installed, and won't fire."
	if(unique_reskin && !current_skin)
		user << "<span class='notice'>Alt-click it to reskin it.</span>"
	if(unique_rename)
		user << "<span class='notice'>Use a pen on it to rename it.</span>"
	if(attachments.len)
		user << "<span class='notice'>You can see the following attachments:</span>"
		for(var/i in attachments)
			var/obj/item/I = i
			user << "<span class='notice'>\icon[I] \the [I.name].</span>"


/obj/item/weapon/gun/proc/process_chamber()
	return 0


//check if there's enough ammo/energy/whatever to shoot one time
//i.e if clicking would make it shoot
/obj/item/weapon/gun/proc/can_shoot()
	return 1


/obj/item/weapon/gun/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	user << "<span class='danger'>*click*</span>"
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)


/obj/item/weapon/gun/proc/shoot_live_shot(mob/living/user as mob|obj, pointblank = 0, mob/pbtarget = null, message = 1)
	if(recoil > 0)
		shake_camera(user, recoil + 1, recoil)

	if(suppressed)
		playsound(user, fire_sound, 10, 1)
	else
		if(fire_sound)
			playsound(user, fire_sound, 50, 1)
		if(!message)
			return
		if(pointblank)
			user.visible_message("<span class='danger'>[user] fires [src] point blank at [pbtarget]!</span>", "<span class='danger'>You fire [src] point blank at [pbtarget]!</span>", "<span class='italics'>You hear a [istype(src, /obj/item/weapon/gun/energy) ? "laser blast" : "gunshot"]!</span>")
		else
			user.visible_message("<span class='danger'>[user] fires [src]!</span>", "<span class='danger'>You fire [src]!</span>", "You hear a [istype(src, /obj/item/weapon/gun/energy) ? "laser blast" : "gunshot"]!")

	if(weapon_weight >= WEAPON_MEDIUM)
		if(user.get_inactive_hand())
			if(prob(15))
				if(user.drop_item())
					user.visible_message("<span class='danger'>[src] flies out of [user]'s hands!</span>", "<span class='userdanger'>[src] kicks out of your grip!</span>")

/obj/item/weapon/gun/emp_act(severity)
	for(var/obj/O in contents)
		O.emp_act(severity)


/obj/item/weapon/gun/afterattack(atom/target, mob/living/user, flag, params)
	if(firing_burst)
		return
	if(attachment_afterattack)
		return attachment_afterattack.afterattack(target, user, flag, params)
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target) || user.a_intent == "harm") //melee attack
			return
		if(target == user && user.zone_selected != "mouth") //so we can't shoot ourselves (unless mouth selected)
			return

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can't shoot.
		shoot_with_empty_chamber(user)
		return

	if(flag)
		if(user.zone_selected == "mouth")
			handle_suicide(user, target, params)
			return


	//Exclude lasertag guns from the CLUMSY check.
	if(clumsy_check)
		if(istype(user))
			if (user.disabilities & CLUMSY && prob(40))
				user << "<span class='userdanger'>You shoot yourself in the foot with \the [src]!</span>"
				var/shot_leg = pick("l_leg", "r_leg")
				process_fire(user,user,0,params, zone_override = shot_leg)
				user.drop_item()
				return

	if(weapon_weight == WEAPON_HEAVY && user.get_inactive_hand())
		user << "<span class='userdanger'>You need both hands free to fire \the [src]!</span>"
		return

	process_fire(target,user,1,params)



/obj/item/weapon/gun/proc/can_trigger_gun(var/mob/living/user)

	if(!handle_pins(user) || !user.can_use_guns(src))
		return 0

	return 1

/obj/item/weapon/gun/proc/handle_pins(mob/living/user)
	if(pin)
		if(pin.pin_auth(user) || pin.emagged)
			return 1
		else
			pin.auth_fail(user)
			return 0
	else
		user << "<span class='warning'>\The [src]'s trigger is locked. This weapon doesn't have a firing pin installed!</span>"
	return 0

obj/item/weapon/gun/proc/newshot()
	return

/obj/item/weapon/gun/proc/process_fire(atom/target as mob|obj|turf, mob/living/user as mob|obj, message = 1, params, zone_override)
	add_fingerprint(user)

	if(semicd)
		return

	if(weapon_weight)
		if(user.get_inactive_hand())
			recoil = 4 //one-handed kick
		else
			recoil = initial(recoil)

	if(burst_size > 1)
		firing_burst = 1
		for(var/i = 1 to burst_size)
			if(!user)
				break
			if(!issilicon(user))
				if( i>1 && !(src in get_both_hands(user))) //for burst firing
					break
			if(chambered)
				var/sprd = 0
				if(randomspread)
					sprd = round((rand() - 0.5) * spread)
				else //Smart spread
					sprd = round((i / burst_size - 0.5) * spread)
				if(!chambered.fire(target, user, params, ,suppressed, zone_override, sprd))
					shoot_with_empty_chamber(user)
					break
				else
					if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
						shoot_live_shot(user, 1, target, message)
					else
						shoot_live_shot(user, 0, target, message)
			else
				shoot_with_empty_chamber(user)
				break
			process_chamber()
			update_icon()
			sleep(fire_delay)
		firing_burst = 0
	else
		if(chambered)
			if(!chambered.fire(target, user, params, , suppressed, zone_override, spread))
				shoot_with_empty_chamber(user)
				return
			else
				if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
					shoot_live_shot(user, 1, target, message)
				else
					shoot_live_shot(user, 0, target, message)
		else
			shoot_with_empty_chamber(user)
			return
		process_chamber()
		update_icon()
		semicd = 1
		spawn(fire_delay)
			semicd = 0

	if(user)
		if(user.hand)
			user.update_inv_l_hand()
		else
			user.update_inv_r_hand()
	feedback_add_details("gun_fired","[src.type]")

/obj/item/weapon/gun/attack(mob/M as mob, mob/user)
	if(user.a_intent == "harm") //Flogging
		..()
	else if(user.zone_selected == "groin" && user.a_intent == "grab")
		..()
	else
		return

/obj/item/weapon/gun/attackby(obj/item/I, mob/user, params)
	for(var/i in attachments)
		var/obj/item/gun_attachment/G = i
		if(G.special_attackby)
			if(G.attackby(I, user, params))
				return
	if(unique_rename)
		if(istype(I, /obj/item/weapon/pen))
			rename_gun(user)
	if(istype(I, /obj/item/gun_attachment))
		switch(can_be_attached(I))
			if(0)
				return//what happened?
			if(-1)
				user << "<span class='notice'>\The [I] won't fit!</span>"
				return
			if(-2)
				user << "<span class='notice'>There's already an attachment of that type on \the [name]!</span>"
				return
			else
				user << "<span class='notice'>You start attaching \the [I] to \the [name]...</span>"
				if(do_after(user, 20, target = src))
					user << "<span class='notice'>You attach \the [I] to \the [name].</span>"
					attach_attachment(I, user)
					return
	if(istype(I, /obj/item/weapon/screwdriver))
		var/choice = input(user, "Remove attachment", "Choose the attachment to remove:") in attachments as obj|null
		if(choice && choice in attachments)
			user << "<span class='notice'>You remove \the [choice] from \the [name].</span>"
			remove_attachment(choice, user)
			return
	..()

/obj/item/weapon/gun/equipped(mob/user, slot)
	..()
	for(var/i in actions)
		var/datum/action/A = i
		A.UpdateButtonIcon()

/obj/item/weapon/gun/AltClick(mob/user)
	..()
	if(user.incapacitated())
		user << "<span class='warning'>You can't do that right now!</span>"
		return
	if(unique_reskin && !current_skin && loc == user)
		reskin_gun(user)

/obj/item/weapon/gun/ui_action_click(mob/user, actiontype)
	if(actiontype == /datum/action/item_action/attachment/nadelauncher)
		if(attachment_afterattack)
			attachment_afterattack = null
		else
			attachment_afterattack = locate(/obj/item/gun_attachment/underbarrel/nadelauncher) in attachments
		user << "<span class='notice'>You will now use the [attachment_afterattack ? "grenade launcher" : "gun"] when shooting.</span>"

/obj/item/weapon/gun/proc/reskin_gun(mob/M)
	var/choice = input(M,"Warning, you can only reskin your weapon once!","Reskin Gun") in options

	if(src && choice && !current_skin && !M.incapacitated() && in_range(M,src))
		if(options[choice] == null)
			return
		current_skin = options[choice]
		M << "Your gun is now skinned as [choice]. Say hello to your new friend."
		update_icon()


/obj/item/weapon/gun/proc/rename_gun(mob/M)
	var/input = stripped_input(M,"What do you want to name the gun?", ,"", MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(M,src) && !M.restrained() && M.canmove)
		name = input
		M << "You name the gun [input]. Say hello to your new friend."
		return


/obj/item/weapon/gun/proc/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params)
	if(!ishuman(user) || !ishuman(target))
		return

	if(semicd)
		return

	if(user == target)
		target.visible_message("<span class='warning'>[user] sticks [src] in their mouth, ready to pull the trigger...</span>", \
			"<span class='userdanger'>You stick [src] in your mouth, ready to pull the trigger...</span>")
	else
		target.visible_message("<span class='warning'>[user] points [src] at [target]'s head, ready to pull the trigger...</span>", \
			"<span class='userdanger'>[user] points [src] at your head, ready to pull the trigger...</span>")

	semicd = 1

	if(!do_mob(user, target, 120) || user.zone_selected != "mouth")
		if(user)
			if(user == target)
				user.visible_message("<span class='notice'>[user] decided life was worth living.</span>")
			else if(target && target.Adjacent(user))
				target.visible_message("<span class='notice'>[user] has decided to spare [target]'s life.</span>", "<span class='notice'>[user] has decided to spare your life!</span>")
		semicd = 0
		return

	semicd = 0

	target.visible_message("<span class='warning'>[user] pulls the trigger!</span>", "<span class='userdanger'>[user] pulls the trigger!</span>")

	if(chambered && chambered.BB)
		chambered.BB.damage *= 5

	process_fire(target, user, 1, params)

/obj/item/weapon/gun/proc/unlock() //used in summon guns and as a convience for admins
	if(pin)
		qdel(pin)
	pin = new /obj/item/device/firing_pin

/obj/item/weapon/gun/burn()
	if(pin)
		qdel(pin)
	.=..()

//attachment procs.

//can_be_attached(attachment)
//Returns 0 if the attachment doesn't exist anymore
//Returns -1 if the attachment's not compatible to the gun
//Returns -2 if there's already an attachment of the same type
//Otherwise it returns 1
/obj/item/weapon/gun/proc/can_be_attached(obj/item/gun_attachment/A)
	if(!A)
		return 0
	if(!(A.gun_flag & attachments_flags))//gun doesn't support this attachment,sorry lad
		return -1
	for(var/i in attachments)
		var/obj/item/gun_attachment/G = i
		if(A.gun_flag & G.gun_flag)//slot's already occupied.
			return -2
	return 1

/obj/item/weapon/gun/proc/attach_attachment(obj/item/gun_attachment/A, mob/user)//This proc handles putting the attachment on the gun.Does NOT handle checks.
	attachments += A
	A.gun = src
	if(A.loc == user)
		user.unEquip(A)
	A.forceMove(src)
	A.on_insert(user)
	//first offset, aka the gun offsets
	A.overlay.pixel_x = attachment_x_offsets[gunflag2text(A.gun_flag)]
	A.overlay.pixel_y = attachment_y_offsets[gunflag2text(A.gun_flag)]
	//second offset, aka the attachment offset(default is 0 so nothing happens
	A.overlay.pixel_x += A.overlay_x_offset
	A.overlay.pixel_y += A.overlay_y_offset
	add_overlay(A.overlay, priority = 1)

/obj/item/weapon/gun/proc/remove_attachment(obj/item/gun_attachment/A, mob/user)
	if(!A)
		return 0
	attachments -= A
	A.on_remove()
	A.gun = null
	A.forceMove(get_turf(src))
	attachment_afterattack = null
	priority_overlays -= A.overlay
	overlays.Cut()
	update_icon()

/proc/gunflag2text(flag)
	switch(flag)
		if(BARREL)
			return "barrel"
		if(OPTICS)
			return "optics"
		if(UNDERBARREL)
			return "underbarrel"
		if(STOCK)
			return "stock"
		if(PAINT)
			return "paint"