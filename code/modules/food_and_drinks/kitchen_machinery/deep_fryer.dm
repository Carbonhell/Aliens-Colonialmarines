/obj/machinery/deepfryer
	name = "deep fryer"
	desc = "Deep fried <i>everything</i>."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "fryer_off"
	layer = BELOW_OBJ_LAYER
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 5
	active_power_usage = 100
	var/on = FALSE	//Is it deep frying already?
	var/efficiency = 1

/obj/machinery/deepfryer/New()
	..()
	var/obj/item/weapon/circuitboard/machine/B = new /obj/item/weapon/circuitboard/machine/deepfryer(null)
	B.apply_default_parts(src)

/obj/item/weapon/circuitboard/machine/deepfryer
	name = "circuit board (Deep Fryer)"
	build_path = /obj/machinery/deepfryer
	origin_tech = "engineering=2;materials=2"
	req_components = list(/obj/item/weapon/stock_parts/micro_laser = 2, /obj/item/weapon/stock_parts/matter_bin = 2)

/obj/machinery/deepfryer/RefreshParts()
	for(var/obj/item/weapon/stock_parts/C in component_parts)
		efficiency = C.rating

/obj/machinery/deepfryer/examine(mob/user)
	..()
	if(contents.len)
		var/list/frying = jointext(contents, ", ")
		user << "You can make out [frying] in the oil."

/obj/machinery/deepfryer/proc/mob_fry(mob/living/F, mob/user)
	if(contents.len) return
	if(F == user) F.visible_message("<span class='warning'>[user] starts squeezing into [src]!</span>", "<span class='userdanger'>You start squeezing into [src]!</span>")
	else F.visible_message("<span class='warning'>[user] starts putting [F] into [src]!</span>", "<span class='userdanger'>[user] starts shoving you into [src]!</span>")
	if(!do_mob(user, F, 120)) return
	if(contents.len) return //to prevent spam/queing up attacks
	on = TRUE
	F.loc = src
	user.stop_pulling()
	user.drop_item()
	icon_state = "fryer_on"
	spawn(0)
		for(var/i in 1 to 4)
			if(!F) //if mob got deleted for some reasons
				visible_message("<span class='warning'>The deep fryer contents dissolve in the oil! Fuck!</span>")
				icon_state = "fryer_off"
				on = FALSE
				playsound(loc, 'sound/machines/ding.ogg', 50, 1, -7)
				return
			if(F.loc != src) return // if we ejected the mob, can't process anything
			F.emote("scream")
			F.adjustFireLoss(12.5)
			sleep(round(50/efficiency))
		F.loc = loc
		for(var/obj/item/O in F.contents)//not gonna use itemfry because we just want the overlay
			if(isorgan(O))
				continue
			if("itemfry" in O.priority_overlays)
				continue
			var/image/iemge = image('icons/effects/overlays.dmi', "itemfry")
			var/icon/fryingoverlay = icon('icons/effects/overlays.dmi', "itemfry")
			var/icon/imgicon = getFlatIcon(O)
			imgicon.Blend(fryingoverlay, ICON_MULTIPLY)
			iemge.icon = imgicon
			iemge.tag = "itemfry"
			O.add_overlay(iemge, 1)
			if(!(findtext(O.name, "deep fried"))) O.name = "deep fried [O.name]"
		add_logs(user, F, "deepfried")
		icon_state = "fryer_off"
		on = FALSE
		playsound(loc, 'sound/machines/ding.ogg', 50, 1, -7)

/obj/machinery/deepfryer/proc/item_fry(obj/item/I, mob/user, make_useless = TRUE)
	user.drop_item()
	I.loc = src
	user << "<span class='notice'>You put [I] into [src].</span>"
	on = TRUE
	icon_state = "fryer_on"
	spawn(round(200/efficiency))
		var/existing_overlays = 1
		for(var/i in I.priority_overlays)
			var/image/image = i
			if(image.tag == "itemfry")
				existing_overlays++
		icon_state = "fryer_off"
		on = FALSE
		playsound(loc, 'sound/machines/ding.ogg', 50, 1, -7)
		if(existing_overlays == 4)
			visible_message("<span class='warning'>The deep fryer contents dissolve in the oil! Fuck!</span>")
			qdel(I)
			return//can't deepfry more!
		if(I && I.loc == src)

			var/obj/item/S = I
			if(!istype(I, /obj/item/weapon/reagent_containers/food/snacks/deepfryholder) && make_useless)
				S = new /obj/item/weapon/reagent_containers/food/snacks/deepfryholder(get_turf(src))
				var/icon/IC = getFlatIcon(I)
				S.icon = IC
				if(I.reagents)
					if(I.reagents.total_volume)
						var/amount = I.reagents.get_reagent_amount("nutriment")
						if(I.reagents.has_reagent("nutriment") && amount > 1)  // special check to only transfer half of the nutriment the fried object had, if it has 2 nutriments or more
							I.reagents.trans_id_to(S, "nutriment", amount/2)
							I.reagents.del_reagent("nutriment") // so the rest won't be added with I.reagents.trans_to(S, I.reagents.total_volume)
						else
							S.reagents.add_reagent("nutriment", 1) // otherwise just give 1 nutriment
						I.reagents.trans_to(S, I.reagents.total_volume)
				else S.reagents.add_reagent("nutriment", 1) // if old item had no chems,just give 1 nutriment

			var/image/iemge = image('icons/effects/overlays.dmi', "itemfry")
			var/icon/fryingoverlay = icon('icons/effects/overlays.dmi', "itemfry")
			var/icon/imgicon = getFlatIcon(I)
			imgicon.Blend(fryingoverlay, ICON_MULTIPLY)
			iemge.icon = imgicon
			iemge.tag = "itemfry"
			S.add_overlay(iemge, 1)
			S.name = I.name //In case the if check for length fails so we don't name it "Deep Fried Food Holder Obj"
			S.name = "deep fried [I.name]"
			S.desc = I.desc
			S.forceMove(loc)
			if(istype(I, /obj/item/weapon/disk/nuclear) && make_useless)
				S.desc = "Welp. I guess Centcomm will have to bluespace ANOTHER nuke disk now."
			if(!istype(I, /obj/item/weapon/reagent_containers/food/snacks/deepfryholder) && make_useless)
				qdel(I)

/obj/machinery/deepfryer/attackby(obj/item/I, mob/user)
	if(on)
		user << "<span class='notice'>[src] is still active!</span>"
		return
	if(istype(I,/obj/item/weapon/wrench))
		default_unfasten_wrench(user, I)
		return
	if(istype(I,/obj/item/weapon/screwdriver))
		default_deconstruction_screwdriver(user, "fryer_panel", "fryer_off", I)
		return
	if(istype(I, /obj/item/weapon/crowbar))
		default_deconstruction_crowbar(I)
		return
	if(!anchored)
		user << "<span class='notice'>The machine must be anchored to be usable!</span>"
		return
	if(panel_open)
		user << "<span class='notice'>Close the panel first!</span>"
		return
	if(istype(I, /obj/item/tk_grab))
		user << "<span class='warning'>That isn't going to fit.</span>"
		return
	if(istype(I, /obj/item/weapon/reagent_containers/glass))
		user << "<span class='warning'>That would probably break [I].</span>"
		return
	else item_fry(I, user)

/obj/machinery/deepfryer/MouseDrop_T(mob/living/M, mob/user)
	if(!istype(M)) return
	if (user.stat != 0) return
	if(on)
		user << "<span class='notice'>[src] is still active!</span>"
		return
	if(!anchored)
		user << "<span class='notice'>The machine must be anchored to be usable!</span>"
		return
	if(panel_open)
		user << "<span class='notice'>Close the panel first!</span>"
		return
	mob_fry(M, user)

/obj/machinery/deepfryer/attack_hand(mob/user)
	if(on && contents.len)
		var/atom/O = pop(contents)
		if(O == user)
			return//can't pull yourself out,burn bitch
		if(ismob(O))
			var/mob/M = O
			user << "<span class='warning'>You pull [M] out!</span>"
			M.loc = get_turf(src)
			icon_state = "fryer_off"
			on = FALSE
			return
		else
			var/obj/item/item = O
			user << "<span class='notice'>You pull [item] from [src]! It looks like you were just in time!</span>"
			item.loc = get_turf(src)
			icon_state = "fryer_off"
			on = FALSE
		return
	else if(!on)
		if(user.pulling && isliving(user.pulling) && user.grab_state >= GRAB_AGGRESSIVE)
			mob_fry(user.pulling, user)
			return
	..()
