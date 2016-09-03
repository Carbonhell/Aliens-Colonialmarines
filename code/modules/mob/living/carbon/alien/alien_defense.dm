/mob/living/carbon/alien/hitby(atom/movable/AM, skipcatch, hitpush)
	..(AM, skipcatch = 1, hitpush = 0)


/*Code for aliens attacking aliens. Because aliens act on a hivemind, I don't see them as very aggressive with each other.
As such, they can either help or harm other aliens. Help works like the human help command while harm is a simple nibble.
In all, this is a lot like the monkey code. /N
*/
/mob/living/carbon/alien/attack_alien(mob/living/carbon/alien/M)
	if(!ticker || !ticker.mode)
		M << "You cannot attack people before the game has started."
		return

	switch(M.a_intent)

		if ("help")
			if(islarva(M))
				visible_message("<span class='notice'>[M] nudges its head against [src].</span>")
				return
			visible_message("<span class='notice'>[M] caresses [src] with its scythe like arm.</span>")
		else
			if(health > 0)
				M.do_attack_animation(src)
				playsound(loc, 'sound/weapons/bite.ogg', 50, 1, -1)
				var/damage = 1
				visible_message("<span class='danger'>[M.name] bites [src]!</span>", \
						"<span class='userdanger'>[M.name] bites [src]!</span>")
				adjustBruteLoss(damage)
				add_logs(M, src, "attacked")
				updatehealth()
			else
				M << "<span class='warning'>[name] is too injured for that.</span>"
	if(M == src)//clicked on self
		if(pulling)
			var/mob/living/carbon/pulled = pulling
			if(!istype(pulled))
				return
			if(isalien(pulled))
				src << "<span class='danger'>Nice try! That wouldn't taste very good.</span>"
				return
			devour_mob(pulled, 50)
	return


/mob/living/carbon/alien/attack_larva(mob/living/carbon/alien/larva/L)
	return attack_alien(L)


/mob/living/carbon/alien/attack_hand(mob/living/carbon/human/M)
	if(..())	//to allow surgery to return properly.
		return 0

	switch(M.a_intent)
		if("help")
			if(stat == DEAD)
				M << "<span class='notice'>You poke [src] but nothing happens.</span>"
			else
				M << "<span class='notice'>You poke [src].</span>"
				src << "<span class='notice'>[M] pokes you.</span>"
		if("grab")
			grabbedby(M)
		if ("harm", "disarm")
			M.do_attack_animation(src)
			return 1
	return 0


/mob/living/carbon/alien/attack_paw(mob/living/carbon/monkey/M)
	if(..())
		if (stat != DEAD)
			adjustBruteLoss(rand(1, 3))
			updatehealth()
	return


/mob/living/carbon/alien/attack_animal(mob/living/simple_animal/M)
	if(..())
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		switch(M.melee_damage_type)
			if(BRUTE)
				adjustBruteLoss(damage)
			if(BURN)
				adjustFireLoss(damage)
			if(TOX)
				adjustToxLoss(damage)
			if(OXY)
				adjustOxyLoss(damage)
			if(CLONE)
				adjustCloneLoss(damage)
			if(STAMINA)
				adjustStaminaLoss(damage)
		updatehealth()

/mob/living/carbon/alien/attack_slime(mob/living/simple_animal/slime/M)
	if(..()) //successful slime attack
		var/damage = rand(5, 35)
		if(M.is_adult)
			damage = rand(10, 40)
		adjustBruteLoss(damage)
		add_logs(M, src, "attacked")
		updatehealth()
