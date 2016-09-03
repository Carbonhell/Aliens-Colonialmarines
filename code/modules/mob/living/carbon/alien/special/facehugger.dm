//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

//TODO: Make these simple_animals

var/const/MIN_IMPREGNATION_TIME = 300 //time it takes to impregnate someone
var/const/MAX_IMPREGNATION_TIME = 450

var/const/MIN_ACTIVE_TIME = 150 //time between being dropped and going idle
var/const/MAX_ACTIVE_TIME = 200

/obj/item/clothing/mask/facehugger
	name = "alien"
	desc = "It has some sort of a tube at the end of its tail."
	icon = 'icons/mob/alien.dmi'
	icon_state = "facehugger"
	item_state = "facehugger"
	w_class = 1 //note: can be picked up by aliens unlike most other items of w_class below 4
	flags = MASKINTERNALS
	throw_range = 1
	tint = 3
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH
	layer = MOB_LAYER

	var/stat = CONSCIOUS //UNCONSCIOUS is the idle state in this case

	var/sterile = 0
	var/real = 1 //0 for the toy, 1 for real. Sure I could istype, but fuck that.
	var/strength = 5
	var/walk_speed = 1
	var/mob/living/carbon/target

	var/attached = 0

/obj/item/clothing/mask/facehugger/New()
	..()
	START_PROCESSING(SSobj, src)
//<vg>
/obj/item/clothing/mask/facehugger/process()
	followtarget()

/obj/item/clothing/mask/facehugger/proc/findtarget()
	if(!real)
		return
	for(var/mob/living/carbon/T in hearers(4, src))
		if(!ishuman(T) && !ismonkey(T))
			continue
		if(!CanHug(T))
			continue
		if(T && (T.stat != DEAD && T.stat != UNCONSCIOUS) )

			if(get_dist(loc, T.loc) <= 4)
				target = T


/obj/item/clothing/mask/facehugger/proc/followtarget()
	if(!real)
		return // Why are you trying to path stupid toy
	if(!target || target.stat == DEAD || target.stat == UNCONSCIOUS || target.status_flags & XENO_HOST)
		findtarget()
		return
	if(loc && loc == get_turf(src) && attached == 0 && stat == 0 && nextwalk <= world.time)
		nextwalk = world.time + walk_speed
		var/dist = get_dist(loc, target.loc)
		if(dist > 4)
			return //We'll let the facehugger do nothing for a bit, since it's fucking up.
		if(target.wear_mask && istype(target.wear_mask, /obj/item/clothing/mask/facehugger))
			var/obj/item/clothing/mask/facehugger/F = target.wear_mask
			if(F.sterile) // Toy's won't prevent real huggers
				findtarget()
				return
		else
			step_towards(src, target, 0)
			if(dist <= 1)
				if(CanHug(target))
					Attach(target)
					return
				else
					target = null
					walk(src,0)
					findtarget()
					return

//</vg>

/obj/item/clothing/mask/facehugger/Destroy()
	Die()
	..()

/obj/item/clothing/mask/facehugger/ex_act(severity)
	Die()

/obj/item/clothing/mask/facehugger/lamarr
	name = "Lamarr"
	sterile = 1

/obj/item/clothing/mask/facehugger/dropped()
	var/obj/item/clothing/mask/facehugger/F
	var/count = 0
	for(F in get_turf(src))
		if(F.stat == CONSCIOUS) count++
	if(count > 5)
		visible_message("<span class='danger'>The facehugger is furiously cannibalized by the nearby horde of other ones!</span>")
		qdel(src)
		return

/obj/item/clothing/mask/facehugger/attack_alien(mob/user) //can be picked up by aliens
	if(istype(user, /mob/living/carbon/alien/humanoid/carrier))
		var/mob/living/carbon/alien/humanoid/carrier/C = user
		if(C.huggers_cur < C.huggers_max)
			if(stat == CONSCIOUS)
				C.huggers_cur++
				user << "<span class='notice'>You scoop up the facehugger and carry it for safekeeping. Now sheltering: [C.huggers_cur] / [C.huggers_max].</span>"
				qdel(src)
	attack_hand(user)
	return

/obj/item/clothing/mask/facehugger/attack_hand(mob/user)
	if((stat == CONSCIOUS && !sterile) && !isalien(user))
		if(Attach(user))
			return
	..()

/obj/item/clothing/mask/facehugger/attack(mob/living/M, mob/user)
	..()
	user.unEquip(src)
	Attach(M)

/obj/item/clothing/mask/facehugger/examine(mob/user)
	..()
	if(!real)//So that giant red text about probisci doesn't show up.
		return
	switch(stat)
		if(DEAD,UNCONSCIOUS)
			user << "<span class='boldannounce'>[src] is not moving.</span>"
		if(CONSCIOUS)
			user << "<span class='boldannounce'>[src] seems to be active!</span>"
	if (sterile)
		user << "<span class='boldannounce'>It looks like the proboscis has been removed.</span>"

/obj/item/clothing/mask/facehugger/attackby(obj/item/O,mob/M, params)
	if(O.force)
		Die()
	return

/obj/item/clothing/mask/facehugger/bullet_act(obj/item/projectile/P)
	if(P.damage)
		Die()
	return

/obj/item/clothing/mask/facehugger/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		Die()
	return

/obj/item/clothing/mask/facehugger/equipped(mob/M)
	Attach(M)

/obj/item/clothing/mask/facehugger/Crossed(atom/target)
	HasProximity(target)
	return

/obj/item/clothing/mask/facehugger/on_found(mob/finder)
	return 0 //can only be abused tbh

/obj/item/clothing/mask/facehugger/HasProximity(atom/movable/AM as mob|obj)
	if(CanHug(AM) && Adjacent(AM))
		return Attach(AM)
	return 0

/obj/item/clothing/mask/facehugger/throw_at(atom/target, range, speed, mob/thrower, spin)
	var/reset = FALSE
	if(istype(thrower, /mob/living/carbon/alien/humanoid/carrier))
		throw_range += 4
		reset = TRUE
	if(!..())
		return
	if(reset)
		throw_range = initial(throw_range)
	if(stat == CONSCIOUS)
		icon_state = "[initial(icon_state)]_thrown"
		spawn(15)
			if(icon_state == "[initial(icon_state)]_thrown")
				icon_state = "[initial(icon_state)]"

/obj/item/clothing/mask/facehugger/throw_impact(atom/hit_atom)
	..()
	if(stat == CONSCIOUS)
		icon_state = "[initial(icon_state)]"
		Attach(hit_atom)

/obj/item/clothing/mask/facehugger/proc/Attach(mob/living/M)
	if(!isliving(M))
		return 0
	if((!iscorgi(M) && !iscarbon(M)) || isalien(M))
		return 0
	if(attached)
		return 0
	else
		attached++
		spawn(MAX_IMPREGNATION_TIME)
			attached = 0
	if(M.getorgan(/obj/item/organ/alien/hivenode))
		return 0
	if(M.getorgan(/obj/item/organ/body_egg/alien_embryo))
		return 0
	if(stat != CONSCIOUS)
		return 0
	if(!sterile) M.take_organ_damage(strength,0) //done here so that even borgs and humans in helmets take damage
	M.visible_message("<span class='danger'>[src] leaps at [M]'s face!</span>", \
						"<span class='userdanger'>[src] leaps at [M]'s face!</span>")
	if(iscarbon(M))
		var/mob/living/carbon/H = M
		var/obj/item/clothing/D = H.head
		if(!D)
			D = H.wear_mask
		if(D)
			if(D.flags & NODROP)
				return 0
			if(istype(D))
				if(D.anti_hug)
					H.visible_message("<span class='userdanger'>[src] smashes against [H]'s [D] and [D.antihug == 1 ? "rips it off!" : "bounces off!"]</span>")
					D.anti_hug--
					if(prob(50))
						Die()
					else
						GoIdle()
					if(!D.anti_hug)
						H.unEquip(D)
						if(istype(D,/obj/item/clothing/head/helmet/marine))
							var/obj/item/clothing/head/helmet/marine/Marine = D
							Marine.add_hugger_damage()
							Marine.update_icons()
					return 0
			H.visible_message("<span class='danger'>[src] smashes against [H]'s [D]!</span>", \
								"<span class='userdanger'>[src] smashes against [H]'s [D]!</span>")
			Die()
			return 0

		loc = H
		H.equip_to_slot(src, slot_wear_mask)
		if(!sterile)
			M.Paralyse(MAX_IMPREGNATION_TIME/12)
		if(ishuman(H))
			if(H.gender == MALE)
				playsound(loc, 'sound/misc/facehugged_male.ogg', 50, 0)
			if(H.gender == FEMALE)
				playsound(loc, 'sound/misc/facehugged_female.ogg', 50, 0)
	else if (iscorgi(M))
		var/mob/living/simple_animal/pet/dog/corgi/C = M
		loc = C
		C.facehugger = src
		C.regenerate_icons()

	GoIdle() //so it doesn't jump the people that tear it off

	spawn(rand(MIN_IMPREGNATION_TIME,MAX_IMPREGNATION_TIME))
		Impregnate(M)

	return 1

/obj/item/clothing/mask/facehugger/proc/Impregnate(mob/living/target)
	if(stat == DEAD)
		return

	if(!target || target.stat == DEAD) //was taken off or something
		return

	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(C.wear_mask != src)
			return

	if(!sterile)
		//target.contract_disease(new /datum/disease/alien_embryo(0)) //so infection chance is same as virus infection chance
		target.visible_message("<span class='danger'>[src] falls limp after violating [target]'s face!</span>", \
								"<span class='userdanger'>[src] falls limp after violating [target]'s face!</span>")

		Die()
		icon_state = "[initial(icon_state)]_impregnated"

		var/obj/item/bodypart/chest/LC = target.get_bodypart("chest")
		if((!LC || LC.status != ORGAN_ROBOTIC) && !target.getorgan(/obj/item/organ/body_egg/alien_embryo))
			new /obj/item/organ/body_egg/alien_embryo(target)

		if(iscorgi(target))
			var/mob/living/simple_animal/pet/dog/corgi/C = target
			src.loc = get_turf(C)
			C.facehugger = null
	else
		target.visible_message("<span class='danger'>[src] violates [target]'s face!</span>", \
								"<span class='userdanger'>[src] violates [target]'s face!</span>")

/obj/item/clothing/mask/facehugger/proc/GoActive()
	if(stat == DEAD || stat == CONSCIOUS)
		return

	stat = CONSCIOUS
	icon_state = "[initial(icon_state)]"

/obj/item/clothing/mask/facehugger/proc/GoIdle()
	if(stat == DEAD || stat == UNCONSCIOUS)
		return

	stat = UNCONSCIOUS
	icon_state = "[initial(icon_state)]_inactive"

	spawn(rand(MIN_ACTIVE_TIME,MAX_ACTIVE_TIME))
		GoActive()
	return

/obj/item/clothing/mask/facehugger/proc/Die()
	STOP_PROCESSING(SSobj, src)
	target = null
	if(stat == DEAD)
		return

	icon_state = "[initial(icon_state)]_dead"
	item_state = "facehugger_inactive"
	stat = DEAD

	visible_message("<span class='danger'>[src] curls up into a ball!</span>")
	playsound(loc, 'sound/voice/alien_facehugger_dies.ogg', 100, 1, 1)
	spawn(3000) //3 minute timer for it to decay
		visible_message("\icon[src] <span class='danger'>[src] decays into a mass of acid and chitin.</span>")
		if(ismob(loc)) //Make it fall off the person so we can update their icons. Won't update if they're in containers thou
			var/mob/M = loc
			M.unEquip(src)
			qdel(src)

/proc/CanHug(mob/living/M)
	if(!istype(M))
		return 0
	if(M.stat == DEAD)
		return 0
	if(M.getorgan(/obj/item/organ/alien/hivenode))
		return 0
	if(M.getorgan(/obj/item/organ/body_egg/alien_embryo))
		return 0

	if(iscorgi(M) || ismonkey(M))
		return 1

	return 1