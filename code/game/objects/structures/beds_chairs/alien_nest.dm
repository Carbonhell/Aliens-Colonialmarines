//Alium nests. Essentially beds with an unbuckle delay that only aliums can buckle mobs to.

/obj/structure/bed/nest
	name = "alien nest"
	desc = "It's a gruesome pile of thick, sticky resin shaped like a nest."
	icon = 'icons/obj/smooth_structures/alien/nest.dmi'
	icon_state = "nest"
	var/health = 100
	smooth = SMOOTH_TRUE
	can_be_unanchored = 0
	canSmoothWith = null
	buildstacktype = null
	flags = NODECONSTRUCT
	var/static/list/recently_nested = list() //used to avoid shitlords de-nesting and re-nesting poor guys
	var/image/nest_overlay
	var/ready_to_free = FALSE

/obj/structure/bed/nest/New()
	nest_overlay = image('icons/mob/alien.dmi', "nestoverlay", layer=LYING_MOB_LAYER)
	return ..()

/obj/structure/bed/nest/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	if(has_buckled_mobs())
		for(var/buck in buckled_mobs) //breaking a nest releases all the buckled mobs, because the nest isn't holding them down anymore
			var/mob/living/M = buck

			if(user.getorgan(/obj/item/organ/alien/resinspinner))
				unbuckle_mob(M)
				add_fingerprint(user)
				return

			if(M != user)
				M.visible_message(\
					"[user.name] pulls [M.name] free from the sticky nest!",\
					"<span class='notice'>[user.name] pulls you free from the gelatinous resin.</span>",\
					"<span class='italics'>You hear squelching...</span>")
				recently_nested |= M
				addtimer(src, "reset_nest_delay", 300, TRUE, M)
				unbuckle_mob(M)
				add_fingerprint(user)
			else
				M.visible_message(\
					"<span class='warning'>[M.name] struggles to break free from the gelatinous resin!</span>",\
					"<span class='notice'>You struggle to break free from the gelatinous resin... (Stay still for two minutes.)</span>",\
					"<span class='italics'>You hear squelching...</span>")
				if(!do_after(M, 1200, target = src))
					if(M && M.buckled)
						M << "<span class='warning'>You fail to unbuckle yourself!</span>"
					return
				else
					M << "<span class='warning'>You are ready to break free!Resist again to do so.</span>"
					ready_to_free = TRUE
				if(ready_to_free)
					if(!M.buckled)
						return
					M.visible_message(\
						"<span class='warning'>[M.name] breaks free from the gelatinous resin!</span>",\
						"<span class='notice'>You break free from the gelatinous resin!</span>",\
						"<span class='italics'>You hear squelching...</span>")
					unbuckle_mob(M)
					add_fingerprint(user)

/obj/structure/bed/nest/proc/reset_nest_delay(mob/user)
	if(!user)
		return
	if(user in recently_nested)
		recently_nested -= user

/obj/structure/bed/nest/user_buckle_mob(mob/living/M, mob/living/user)
	if ( !ismob(M) || (get_dist(src, user) > 1) || (M.loc != src.loc) || user.incapacitated() || M.buckled )
		return

	if(isalien(M))
		return
	if(!user.getorgan(/obj/item/organ/alien/resinspinner))
		return
	if(M in recently_nested)
		user << "<span class='danger'>[M.name] was recently recently unbuckled. Wait a bit.</span>"
		return

	if(has_buckled_mobs())
		unbuckle_all_mobs()

	if(buckle_mob(M))
		M.visible_message(\
			"[user.name] secretes a thick vile goo, securing [M.name] into [src]!",\
			"<span class='danger'>[user.name] drenches you in a foul-smelling resin, trapping you in [src]!</span>",\
			"<span class='italics'>You hear squelching...</span>")

/obj/structure/bed/nest/post_buckle_mob(mob/living/M)
	if(M in buckled_mobs)
		M.pixel_y = 0
		M.pixel_x = initial(M.pixel_x) + 2
		M.layer = BELOW_MOB_LAYER
		add_overlay(nest_overlay)
	else
		M.pixel_x = M.get_standard_pixel_x_offset(M.lying)
		M.pixel_y = M.get_standard_pixel_y_offset(M.lying)
		M.layer = initial(M.layer)
		overlays -= nest_overlay

/obj/structure/bed/nest/attacked_by(obj/item/I, mob/user)
	..()
	take_damage(I.force, I.damtype)

/obj/structure/bed/nest/proc/take_damage(damage, damage_type = BRUTE, sound_effect = 1)
	switch(damage_type)
		if(BRUTE)
			if(sound_effect)
				playsound(loc, 'sound/effects/attackblob.ogg', 100, 1)
		if(BURN)
			if(sound_effect)
				playsound(loc, 'sound/items/Welder.ogg', 100, 1)
		else
			return
	health -= damage
	if(health <=0)
		density = 0
		qdel(src)

/obj/structure/bed/nest/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(M.a_intent == "harm")
		M << "<span class='danger'>You start clawing the [name] down...</span>"
		if(do_after(M, 50, src))
			M << "<span class='danger'>You claw the [name] down.</span>"
			qdel(src)