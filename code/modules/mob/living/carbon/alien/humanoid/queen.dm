var/global/list/queenckeys = list()

/mob/living/carbon/alien/humanoid/big
	icon = 'icons/mob/alienlarge.dmi'
	jellyMax = 0
	bubble_icon = "alienroyal"
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER
	tier = 2

/mob/living/carbon/alien/humanoid/big/queen
	name = "alien queen"
	icon_state = "alienqueen_s"
	caste = "queen"
	maxHealth = 400
	health = 400
	unique_name = 0
	tier = 3
	is_intelligent = TRUE
	caste_desc = "The one, the queen, the biggest. This lady controls everything, with an iron fist. Well, claw."

/mob/living/carbon/alien/humanoid/big/queen/death()
	if(stat == DEAD)
		return
	if(!queen_died_recently)//just to be sure
		queen_died_recently = TRUE
		addTimer(GLOBAL_PROC, reset_queendeath, 3000)
		var/sounddead = "sound/voice/alien_queen_died.ogg"
		xeno_message("You hear a loud painful screech as your queen falls to the floor, limp and lifeless...", sound = sounddead)
		for(var/mob/living/carbon/alien/A in aliens)
			A.throw_alert("alien_noqueen", /obj/screen/alert/alien_vulnerable)
		for(var/mob/living/carbon/alien/B in range(10))
			B.Stun(5)
	..()

/proc/reset_queendeath()
	queen_died_recently = FALSE
	xeno_message("The queen death's event starts to fade from your mind, you feel like the hive's ready for its next queen...")
	for(var/mob/living/carbon/alien/A in aliens)
		A.clear_alert("alien_noqueen")

/mob/living/carbon/alien/humanoid/big/queen/New()
	//there should only be one queen
	for(var/mob/living/carbon/alien/humanoid/queen/Q in aliens)
		if(Q == src)
			continue
		if(Q.stat == DEAD)
			continue
		if(Q.client)
			name = "alien princess ([rand(1, 999)])"	//should never happen but let's be sure
			break

	internal_organs += new /obj/item/organ/alien/plasmavessel/large/queen
	internal_organs += new /obj/item/organ/alien/resinspinner
	internal_organs += new /obj/item/organ/alien/acid(acidpower = ACID)
	internal_organs += new /obj/item/organ/alien/neurotoxin
	internal_organs += new /obj/item/organ/alien/eggsac
	internal_organs += new /obj/item/organ/alien/pheromone
	internal_organs += new /obj/effect/proc_holder/alien/screech
//	AddAbility(new/obj/effect/proc_holder/alien/claw_toggle())   removed
	AddAbility(new/obj/effect/proc_holder/alien/queen_order())
	AddAbility(new/obj/effect/proc_holder/alien/makejelly())
	..()

//Queen verbs
/obj/effect/proc_holder/alien/lay_egg
	name = "Lay Egg"
	desc = "Lay an egg to produce huggers to impregnate prey with."
	plasma_cost = 75
	check_turf = 1
	action_icon_state = "alien_egg"

/obj/effect/proc_holder/alien/lay_egg/fire(mob/living/carbon/user)
	if(locate(/obj/structure/alien/egg) in get_turf(user))
		user << "There's already an egg here."
		return 0
	user.visible_message("<span class='alertalien'>[user] has laid an egg!</span>")
	new /obj/structure/alien/egg(user.loc)
	return 1

/obj/effect/proc_holder/alien/claw_toggle
	name = "Permit/Disallow Slashing"
	desc = "Allows you to permit the hive to harm."
	action_icon_state = "alien_clawtoggle_0"

/obj/effect/proc_holder/alien/claw_toggle/update_icon()
	action.button_icon_state = "alien_clawtoggle_[slashing_allowed ? "1" : "0"]"//can also be 2
	action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/claw_toggle/fire(mob/living/carbon/user)
	slashing_allowed++
	if(slashing_allowed > 2)
		slashing_allowed = 0
	var/queenorder = ""
	switch(slashing_allowed)
		if(0)
			queenorder = "You forbid slashing entirely."
			xeno_message("The Queen has <b>forbidden</b> the harming of hosts. You can no longer slash your enemies.",3)
		if(1)
			queenorder = "You restrict slashing."
			xeno_message("The Queen has <b>restricted</b> the harming of hosts. You will do less damage when slashing.",3)
		if(2)
			queenorder = "You allow slashing."
			xeno_message("The Queen has <b>permitted</b> the harming of hosts! Go hog wild!",3)
	user << "<span class='notice'>[queenorder]</span>"

/obj/effect/proc_holder/alien/queen_order
	name = "Set Hive Orders"
	desc = "Give some specific orders to the hive. They can see this on the status panel."
	action_icon_state = "queen_order"

/obj/effect/proc_holder/alien/queen_order/fire(mob/living/carbon/user)
	hive_orders = stripped_input(user, "What would you like the orders to be?", "Hive Orders")
	if(hive_orders)
		var/random_sound = pick("sound/voice/alien_queen_command.ogg", "sound/voice/alien_queen_command2.ogg", "sound/voice/alien_queen_command3.ogg")
		xeno_message("<span class='userdanger'>The Queen has given a new order. Check Status panel for details.</span>", sound = random_sound)