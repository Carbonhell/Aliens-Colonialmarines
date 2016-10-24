#define HEAT_DAMAGE_LEVEL_1 2 //Amount of damage applied when your body temperature just passes the 360.15k safety point
#define HEAT_DAMAGE_LEVEL_2 3 //Amount of damage applied when your body temperature passes the 400K point
#define HEAT_DAMAGE_LEVEL_3 8 //Amount of damage applied when your body temperature passes the 460K point and you are on fire
var/list/aliens = list()
var/queen_died_recently = FALSE

/mob/living/carbon/alien
	name = "alien"
	voice_name = "alien"
	icon = 'icons/mob/alien.dmi'
	gender = FEMALE //All xenos are girls!!
	dna = null
	faction = list("alien")
	ventcrawler = 2
	languages_spoken = ALIEN
	languages_understood = ALIEN
	sight = SEE_MOBS
	see_in_dark = 8
	verb_say = "hisses"
	bubble_icon = "alien"
	type_of_meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/xeno
	status_flags = CANPARALYSE|CANPUSH
	var/nightvision = 1

	var/list/evolves_to = list() //This is where you add castes to evolve into. "Seperated", "by", "commas"
	var/is_intelligent = 0
	var/list/active_pheromones = list()

	var/obj/item/weapon/card/id/wear_id = null // Fix for station bounced radios -- Skie
	var/has_fine_manipulation = 0
	var/move_delay_add = -2 // movement delay to add

	var/heat_protection = 1.5//x1.5 heat dmg
	var/melee_protection = 1 // default, pratically does nothing. formula is amount/melee_protection, so the higher this is,the lower amt will be
	var/tier = 0 //used in can_evolve()

	var/timerGrow = 0
	var/timerMax = 0
	var/leaping = 0

	var/caste = ""

	gib_type = /obj/effect/decal/cleanable/xenoblood/xgibs
	unique_name = 1

	var/static/hive_orders = "" //What orders should the hive have
	var/static/slashing_allowed = 2

/mob/living/carbon/alien/New()
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down

	internal_organs += new /obj/item/organ/brain/alien
	internal_organs += new /obj/item/organ/alien/hivenode
	internal_organs += new /obj/item/organ/tongue/alien

	for(var/obj/item/organ/I in internal_organs)
		I.Insert(src)

	AddAbility(new/obj/effect/proc_holder/alien/nightvisiontoggle())
	AddAbility(new/obj/effect/proc_holder/alien/hive_status())
	if(evolves_to.len)
		AddAbility(new/obj/effect/proc_holder/alien/evolve())
	..()
	if(mob_size < MOB_SIZE_HUMAN) //tiny/small
		pass_flags = PASSTABLE
	if(mob_size == MOB_SIZE_LARGE)
		ventcrawler = 0
		pressure_resistance = 200 //Because big, stompy xenos should not be blown around like paper.
	aliens += src
	var/random_name = pick(alien_names)
	name = "[random_name] [caste]"
	real_name = name
	if(queen_died_recently)
		throw_alert("alien_noqueen", /obj/screen/alert/alien_vulnerable)

/mob/living/carbon/alien/movement_delay()
	. = ..()
	if("frenzy" in active_pheromones)
		. = round(. /FRENZYPOWERUP)
	. += mob_size+1
	. += move_delay_add

/mob/living/carbon/alien/assess_threat() // beepsky won't hunt aliums
	return -10

/mob/living/carbon/alien/adjustBruteLoss(amount)
	var/actual_melee_prot = melee_protection
	if("guard" in active_pheromones)
		actual_melee_prot *= GUARDPOWERUP
	return ..(amount/actual_melee_prot)

/mob/living/carbon/alien/adjustToxLoss(amount)
	return 0

/mob/living/carbon/alien/adjustFireLoss(amount) // Weak to Fire
	if(amount > 0)
		..(round(amount * heat_protection))
	else
		..(amount)
	return

/mob/living/carbon/alien/check_eye_prot()
	return ..() + 2

/mob/living/carbon/alien/getToxLoss()
	return 0

/mob/living/carbon/alien/handle_environment(datum/gas_mixture/environment)
	if(!environment)
		return

	var/loc_temp = get_temperature(environment)

	// Aliens are now weak to fire.

	//After then, it reacts to the surrounding atmosphere based on your thermal protection
	if(!on_fire) // If you're on fire, ignore local air temperature
		if(loc_temp > bodytemperature)
			//Place is hotter than we are
			var/thermal_protection = round(1/heat_protection) //This returns a 0 - 1 value, which corresponds to the percentage of heat protection.
			if(thermal_protection < 1)
				bodytemperature += (1-thermal_protection) * ((loc_temp - bodytemperature) / BODYTEMP_HEAT_DIVISOR)
		else
			bodytemperature += 1 * ((loc_temp - bodytemperature) / BODYTEMP_HEAT_DIVISOR)

	if(bodytemperature > 360.15)
		//Body temperature is too hot.
		throw_alert("alien_fire", /obj/screen/alert/alien_fire)
		switch(bodytemperature)
			if(360 to 400)
				apply_damage(HEAT_DAMAGE_LEVEL_1, BURN)
			if(400 to 460)
				apply_damage(HEAT_DAMAGE_LEVEL_2, BURN)
			if(460 to INFINITY)
				if(on_fire)
					apply_damage(HEAT_DAMAGE_LEVEL_3, BURN)
				else
					apply_damage(HEAT_DAMAGE_LEVEL_2, BURN)
	else
		clear_alert("alien_fire")


/mob/living/carbon/alien/ex_act(severity, target)
	..()

	switch (severity)
		if (1)
			gib()
			return

		if (2)
			adjustBruteLoss(60)
			adjustFireLoss(60)
			adjustEarDamage(30,120)

		if(3)
			adjustBruteLoss(30)
			if(prob(50))
				Paralyse(1)
			adjustEarDamage(15,60)

	updatehealth()


/mob/living/carbon/alien/handle_fire()//Aliens on fire code
	if(..())
		return
	bodytemperature += BODYTEMP_HEATING_MAX //If you're on fire, you heat up!
	return

/mob/living/carbon/alien/reagent_check(datum/reagent/R) //can't metabolize any reagents for now
	return 1

/mob/living/carbon/alien/IsAdvancedToolUser()
	return has_fine_manipulation

/mob/living/carbon/alien/Stat()
	..()

	if(statpanel("Status"))
		stat(null, "Intent: [a_intent]")
		for(var/i in active_pheromones)
			stat(null, "You are affected by a pheromone of [i].")
		if(hive_orders)
			stat(null,"Hive Orders: [hive_orders]")

/mob/living/carbon/alien/getTrail()
	if(getBruteLoss() < 200)
		return pick (list("xltrails_1", "xltrails2"))
	else
		return pick (list("xttrails_1", "xttrails2"))
/*----------------------------------------
Proc: AddInfectionImages()
Des: Gives the client of the alien an image on each infected mob.
----------------------------------------*/
/mob/living/carbon/alien/proc/AddInfectionImages()
	if (client)
		for (var/mob/living/C in mob_list)
			if(C.status_flags & XENO_HOST)
				var/obj/item/organ/body_egg/alien_embryo/A = C.getorgan(/obj/item/organ/body_egg/alien_embryo)
				if(A)
					var/I = image('icons/mob/alien.dmi', loc = C, icon_state = "infected[A.stage]")
					client.images += I
	return

/*----------------------------------------
Proc: RemoveInfectionImages()
Des: Removes all infected images from the alien.
----------------------------------------*/
/mob/living/carbon/alien/proc/RemoveInfectionImages()
	if (client)
		for(var/image/I in client.images)
			if(dd_hasprefix_case(I.icon_state, "infected"))
				qdel(I)
	return

/mob/living/carbon/alien/canBeHandcuffed()
	return 1

/mob/living/carbon/alien/get_standard_pixel_y_offset(lying = 0)
	return initial(pixel_y)

#undef HEAT_DAMAGE_LEVEL_1
#undef HEAT_DAMAGE_LEVEL_2
#undef HEAT_DAMAGE_LEVEL_3


/mob/living/carbon/alien/update_sight()
	if(!client)
		return
	if(stat == DEAD)
		sight |= SEE_TURFS
		sight |= SEE_MOBS
		sight |= SEE_OBJS
		see_in_dark = 8
		see_invisible = SEE_INVISIBLE_OBSERVER
		return

	sight = SEE_MOBS
	if(nightvision)
		see_in_dark = 8
		see_invisible = SEE_INVISIBLE_MINIMUM
	else
		see_in_dark = 4
		see_invisible = SEE_INVISIBLE_LIVING

	if(client.eye != src)
		var/atom/A = client.eye
		if(A.update_remote_sight(src)) //returns 1 if we override all other sight updates.
			return

	for(var/obj/item/organ/cyberimp/eyes/E in internal_organs)
		sight |= E.sight_flags
		if(E.dark_view)
			see_in_dark = max(see_in_dark, E.dark_view)
		if(E.see_invisible)
			see_invisible = min(see_invisible, E.see_invisible)

	if(see_override)
		see_invisible = see_override

/mob/living/carbon/alien/can_hold_items()
	return has_fine_manipulation


/mob/living/carbon/alien/examine(mob/user)
	if(!user)
		return
	..()

	if(stat == DEAD)
		user << "It is not moving anymore."
	else if (stat == UNCONSCIOUS)
		user << "It quivers a bit, but barely moves."
	else
		var/percent = (health / maxHealth * 100)
		switch(percent)
			if(95 to 101)
				user << "It looks quite healthy."
			if(75 to 94)
				user << "It looks slightly injured."
			if(50 to 74)
				user << "It looks injured."
			if(25 to 49)
				user << "It bleeds with sizzling wounds."
			if(1 to 24)
				user << "It is heavily injured and limping badly."

/mob/living/carbon/alien/Destroy()
	aliens -= src
	..()

/mob/living/carbon/alien/stripPanelUnequip(obj/item/what, mob/who)
	src << "<span class='warning'>You don't have the dexterity to do this!</span>"
	return

/mob/living/carbon/alien/stripPanelEquip(obj/item/what, mob/who)
	src << "<span class='warning'>You don't have the dexterity to do this!</span>"
	return

/mob/living/carbon/alien/proc/can_evolve()
	var/list/alive_aliens = aliens
	for (var/mob/m in alive_aliens)
		if (m.stat == DEAD)
			alive_aliens -= m

	switch(tier)
		if(0)//larva wants to evolve
			return 1//larvas can always evolve.
		if(1)//warrior/drone/sentinels wanna evolve.
			var/high_caste_num = 0//number of tier 2 aliens already existing
			for(var/i in alive_aliens)
				var/mob/living/carbon/alien/A = i
				if(A.tier == 2)
					high_caste_num++
			if(aliens.len/TIERTWOLIMIT >= high_caste_num)
				return 1
		if(2)//queen evolution
			if(!(locate(/mob/living/carbon/alien/humanoid/big/queen) in alive_aliens) && !queen_died_recently)//we got a queen or it died recently!
				return 1

/proc/xeno_message(message = "", size = 3, sound)
	if(!message)
		return
	if(aliens.len)
		for(var/A in aliens)
			var/mob/living/carbon/alien/M = A
			if(M && !M.stat && M.client)
				M << "<span class='danger'><font size=[size]> [message]</font></span>"
				if(sound)
					playsound(M.loc, sound, 50, 1, 1)

/obj/effect/proc_holder/alien/hive_status
	name = "Hive Status"
	desc = "Check the status of your current hive."
	plasma_cost = 0
	action_icon_state = "hive_status"

/obj/effect/proc_holder/alien/hive_status/fire(mob/living/carbon/user)
	var/dat = "<html><head><title>Hive Status</title></head><body>"
	if(aliens.len)
		dat += "<table cellspacing=4>"
		for(var/L in aliens)
			var/mob/M = L
			if(M)
				dat += "<tr><td>[M.name] [M.client ? "" : " <i>(logged out)</i>"][M.stat == DEAD ? " <b><font color=red>(DEAD)</font></b>" : ""]</td></tr>"
		dat += "</table></body>"
	usr << browse(dat, "window=roundstatus;size=400x300")

proc/get_alien_type(alienpath)
	for(var/mob/living/carbon/alien/humanoid/A in aliens)
		if(!istype(A, alienpath))
			continue
		if(!A.key || A.stat == DEAD) //Only living aliens with a ckey are valid.
			continue
		return A
	return FALSE