/*NOTES:
These are general powers. Specific powers are stored under the appropriate alien creature type.
*/

/*Alien spit now works like a taser shot. It won't home in on the target but will act the same once it does hit.
Doesn't work on other aliens/AI.*/


/obj/effect/proc_holder/alien
	name = "Alien Power"
	panel = "Alien"
	var/plasma_cost = 0
	var/check_turf = 0
	var/has_action = 1
	var/charge_max = 0 //recharge time in deciseconds
	var/charge_counter = 0
	var/datum/action/spell_action/alien/action = null
	var/action_icon = 'icons/mob/actions.dmi'
	var/action_icon_state = "spell_default"
	var/action_background_icon_state = "bg_alien"
	var/list/turf_blacklist = list(
									/turf/open/space
									)

/obj/effect/proc_holder/alien/New()
	..()
	action = new(src)
	charge_counter = charge_max

/obj/effect/proc_holder/alien/Click()
	if(!istype(usr,/mob/living/carbon))
		return 1
	var/mob/living/carbon/user = usr
	if(cost_check(check_turf,user))
		if(fire(user) && user) // Second check to prevent runtimes when evolving
			user.usePlasma(plasma_cost)
	return 1

/obj/effect/proc_holder/alien/proc/start_recharge()
	charge_counter = 0
	if(action)
		action.UpdateButtonIcon()
	while(charge_counter < charge_max && !qdeleted(src))
		sleep(1)
		charge_counter++
	if(action)
		action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/proc/on_gain(mob/living/carbon/user)
	return

/obj/effect/proc_holder/alien/proc/on_lose(mob/living/carbon/user)
	return

/obj/effect/proc_holder/alien/proc/fire(mob/living/carbon/user)
	return 1

/obj/effect/proc_holder/alien/InterceptClickOn(mob/living/carbon/user, params, atom/target)
	if(..())
		return 1
	if(!cost_check(0, user, 0))
		return 1

/obj/effect/proc_holder/alien/proc/cost_check(check_turf=0,mob/living/carbon/user,silent = 0)
	if(user.stat)
		if(!silent)
			user << "<span class='noticealien'>You must be conscious to do this.</span>"
		return 0
	if(charge_max)
		if(charge_counter < charge_max)
			if(!silent)
				user << "<span class='noticealien'>You're not ready to do that yet.</span>"
			return 0
	if(user.getPlasma() < plasma_cost)
		if(!silent)
			user << "<span class='noticealien'>Not enough plasma stored.</span>"
		return 0
	if(check_turf && (!isturf(user.loc) || is_type_in_list(user.loc, turf_blacklist)))
		if(!silent)
			user << "<span class='noticealien'>Bad place for a garden!</span>"

		return 0
	return 1

/obj/effect/proc_holder/alien/plant
	name = "Plant Weeds"
	desc = "Plants some alien weeds"
	plasma_cost = 75
	check_turf = 1
	action_icon_state = "alien_plant"

/obj/effect/proc_holder/alien/plant/fire(mob/living/carbon/user)
	if(locate(/obj/structure/alien/weeds/node) in get_turf(user))
		user << "There's already a weed node here."
		return 0
	user.visible_message("<span class='alertalien'>\The [user] regurgitates a pulsating node and plants it on the ground!</span>")
	new /obj/structure/alien/weeds/node(user.loc)
	playsound(loc, 'sound/effects/splat.ogg', 30, 1)
	return 1

/obj/effect/proc_holder/alien/whisper
	name = "Whisper"
	desc = "Whisper to someone"
	plasma_cost = 10
	action_icon_state = "alien_whisper"

/obj/effect/proc_holder/alien/whisper/fire(mob/living/carbon/user)
	var/list/options = list()
	for(var/mob/living/Ms in oview(user))
		options += Ms
	var/mob/living/M = input("Select who to whisper to:","Whisper to?",null) as null|mob in options
	if(!M)
		return 0
	var/msg = sanitize(input("Message:", "Alien Whisper") as text|null)
	if(msg)
		log_say("AlienWhisper: [key_name(user)]->[M.key] : [msg]")
		M << "<span class='noticealien'>You hear a strange, alien voice in your head...</span>[msg]"
		user << "<span class='noticealien'>You said: \"[msg]\" to [M]</span>"
		for(var/ded in dead_mob_list)
			if(!isobserver(ded))
				continue
			var/follow_link_user = FOLLOW_LINK(ded, user)
			var/follow_link_whispee = FOLLOW_LINK(ded, M)
			ded << "[follow_link_user] \
				<span class='name'>[user]</span> \
				<span class='alertalien'>Alien Whisper --> </span> \
				[follow_link_whispee] \
				<span class='name'>[M]</span> \
				<span class='noticealien'>[msg]</span>"
	else
		return 0
	return 1

/obj/effect/proc_holder/alien/transfer
	name = "Transfer Plasma"
	desc = "Transfer Plasma to another alien"
	action_icon_state = "alien_transfer"

/obj/effect/proc_holder/alien/transfer/fire(mob/living/carbon/user)
	var/list/mob/living/carbon/aliens_around = list()
	for(var/mob/living/carbon/A  in oview(user))
		if(A.getorgan(/obj/item/organ/alien/plasmavessel))
			aliens_around.Add(A)
	var/mob/living/carbon/M = input("Select who to transfer to:","Transfer plasma to?",null) as mob in aliens_around
	if(!M)
		return 0
	var/amount = input("Amount:", "Transfer Plasma to [M]") as num
	if (amount)
		amount = min(abs(round(amount)), user.getPlasma())
		if (get_dist(user,M) <= 1)
			M.adjustPlasma(amount)
			user.adjustPlasma(-amount)
			M << "<span class='noticealien'>[user] has transfered [amount] plasma to you.</span>"
			user << "<span class='noticealien'>You trasfer [amount] plasma to [M]</span>"
		else
			user << "<span class='noticealien'>You need to be closer!</span>"
	return

/obj/effect/proc_holder/alien/acid
	name = "Corrossive Acid"
	desc = "Drench an object in acid, destroying it over time."
	plasma_cost = 200
	action_icon_state = "alien_acid"

/obj/effect/proc_holder/alien/acid/proc/corrode(target,mob/living/carbon/user = usr)
	var/obj/item/organ/alien/acid/A = user.getorgan(/obj/item/organ/alien/acid)
	if(!A)
		return
	if(target in oview(1,user))
		// OBJ CHECK
		if(isobj(target))
			var/obj/I = target
			if(I.unacidable)	//So the aliens don't destroy energy fields/singularies/other aliens/etc with their acid.
				user << "<span class='noticealien'>You cannot dissolve this object.</span>"
				return 0
		// TURF CHECK
		else if(istype(target, /turf))
			var/turf/T = target
			// R WALL
			if(istype(T, /turf/closed/wall/r_wall))
				user << "<span class='noticealien'>You cannot dissolve this object.</span>"
				return 0
			// FLOOR
			if(istype(T, /turf/open))
				user << "<span class='noticealien'>You cannot dissolve this object.</span>"
				return 0
		else// Not a type we can acid.
			return 0
		var/path = A.power
		new path(get_turf(target), target)
		user.visible_message("<span class='alertalien'>[user] vomits globs of vile stuff all over [target]. It begins to sizzle and melt under the bubbling mess of acid!</span>")
		return 1
	else
		src << "<span class='noticealien'>Target is too far away.</span>"
		return 0


/obj/effect/proc_holder/alien/acid/fire(mob/living/carbon/alien/user)
	var/message
	var/obj/item/organ/alien/acid/B = user.getorgan(/obj/item/organ/alien/acid)

	if(active)
		message = "<span class='notice'>You empty your [B].</span>"
		remove_ranged_ability(user, message)
	else
		message = "<span class='notice'>You prepare your [B]. <B>Left-click to fire at a target!</B></span>"
		add_ranged_ability(user, message)

/obj/effect/proc_holder/alien/acid/update_icon()
	action.button_icon_state = "alien_acid_[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/acid/InterceptClickOn(mob/living/carbon/user, params, atom/target)
	if(..())
		return
	var/obj/item/organ/alien/acid/N = user.getorgan(/obj/item/organ/alien/acid)
	if(!N || !target)
		return
	if(isobj(target) || istype(target, /turf/closed))
		remove_ranged_ability(user)
		if(corrode(target, user))
			user.usePlasma(plasma_cost)//checking in ..() if the guy has enough plasma.
			return 1

/obj/effect/proc_holder/alien/neurotoxin
	name = "Spit Neurotoxin"
	desc = "Spits neurotoxin at someone, with an effect varying based on the acid concentration."
	action_icon_state = "alien_neurotoxin_0"
	active = FALSE
	charge_max = 50
	var/p_cost = 50

/obj/effect/proc_holder/alien/neurotoxin/fire(mob/living/carbon/user)
	var/message
	var/obj/item/organ/alien/neurotoxin/B = user.getorgan(/obj/item/organ/alien/neurotoxin)

	if(active)
		message = "<span class='notice'>You empty your [B].</span>"
		remove_ranged_ability(user, message)
	else
		message = "<span class='notice'>You prepare your [B]. <B>Left-click to fire at a target!</B></span>"
		add_ranged_ability(user, message)

/obj/effect/proc_holder/alien/neurotoxin/update_icon()
	action.button_icon_state = "alien_neurotoxin_[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/neurotoxin/InterceptClickOn(mob/living/carbon/user, params, atom/target)
	if(..())
		return 1
	var/obj/item/organ/alien/neurotoxin/N = user.getorgan(/obj/item/organ/alien/neurotoxin)
	if(!N)
		return
	p_cost = initial(p_cost)*N.chosenammo //50 for normal neurotoxin,100 for the one that does damage
	if(!iscarbon(user) || user.lying || user.stat)
		remove_ranged_ability(user)
		return

	if(!user.usePlasma(p_cost))
		user << "<span class='warning'>You need at least [p_cost] plasma to spit.</span>"
		remove_ranged_ability(user)
		return

	var/turf/T = get_turf(user)
	var/turf/U = get_step(user, user.dir) // Get the tile infront of the move, based on their direction
	if(!isturf(U) || !isturf(T))
		return FALSE

	var/path = N.ammo_list[N.chosenammo]
	if(istext(path))
		path = text2path(path)//i want to varedit an alien neurotoxin gland and let him spit bullets ok fuck you ur not my dad
	var/obj/item/projectile/bullet/A = new path(user.loc)
	user.visible_message("<span class='danger'>[user] spits \the [A.name]!", "<span class='alertalien'>You spit \the [A.name].</span>")
	A.current = U
	A.firer = user//logging purposes
	A.preparePixelProjectile(target, get_turf(target), user, params)
	A.fire()
	var/soundspit = pick("sound/voice/alien_spitacid.ogg","sound/voice/alien_spitacid2.ogg")
	playsound(user.loc, soundspit, 50, 1, 1)
	user.newtonian_move(get_dir(U, T))
	remove_ranged_ability(user)
	spawn(0)
		charge_max = initial(charge_max) * N.chosenammo
		start_recharge()
	return

/obj/effect/proc_holder/alien/neurotoxin/on_lose(mob/living/carbon/user)
	if(user.ranged_ability == src)
		user.ranged_ability = null

/obj/effect/proc_holder/alien/neurotoxinchange
	name = "Toggle Spit Type"
	desc = "Toggles the acid concentration of the neurotoxin spit. The higher the concentration, the higher the plasma cost."
	plasma_cost = 20
	action_icon_state = "alien_spittype_0"
	active = FALSE

/obj/effect/proc_holder/alien/neurotoxinchange/update_icon()
	action.button_icon_state = "alien_spittype_[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/neurotoxinchange/fire(mob/living/carbon/user)
	var/obj/item/organ/alien/neurotoxin/N = user.getorgan(/obj/item/organ/alien/neurotoxin)
	if(!N)
		return 0
	N.chosenammo++
	if(N.chosenammo > N.ammo_list.len)
		N.chosenammo = 1
	var/obj/item/projectile/path = N.ammo_list[N.chosenammo]
	user << "<span class='notice'>You modified the concentration of your spit. It will now spit [initial(path.name)]s."
	var/obj/effect/proc_holder/alien/neurotoxin/action = locate() in user.actions
	if(action)
		action.charge_max = initial(action.charge_max) * N.chosenammo
	update_icon()
	return 1

/obj/effect/proc_holder/alien/resin
	name = "Secrete Resin"
	desc = "Secrete tough malleable resin."
	plasma_cost = 55
	check_turf = 1
	var/list/structures = list(
		"resin wall" = /obj/structure/alien/resin/wall,
		"resin membrane" = /obj/structure/alien/resin/membrane,
		"resin nest" = /obj/structure/bed/nest,
		"resin door" = /obj/structure/alien/resin/door)

	action_icon_state = "alien_resin"

/obj/effect/proc_holder/alien/resin/fire(mob/living/carbon/user)
	if(locate(/obj/structure/alien/resin) in user.loc)
		user << "<span class='danger'>There is already a resin structure there.</span>"
		return 0
	if(!locate(/obj/structure/alien/weeds) in user.loc)
		user << "<span class='danger'>You must plant some weeds first!</span>"
		return 0
	var/choice = input("Choose what you wish to shape.","Resin building") as null|anything in structures
	if(!choice)
		return 0
	if (!cost_check(check_turf,user))
		return 0
	if(locate(structures[choice]) in user.loc)
		user << "<span class='warning'>There's already \a [choice] here!</span>"
		return 0
	user << "<span class='notice'>You shape a [choice].</span>"
	user.visible_message("<span class='notice'>[user] vomits up a thick purple substance and begins to shape it.</span>")

	choice = structures[choice]
	new choice(user.loc)
	return 1

/obj/effect/proc_holder/alien/regurgitate
	name = "Regurgitate"
	desc = "Empties the contents of your stomach"
	action_icon_state = "alien_barf"

/obj/effect/proc_holder/alien/regurgitate/fire(mob/living/carbon/user)
	if(user.stomach_contents.len)
		for(var/atom/movable/A in user.stomach_contents)
			user.stomach_contents.Remove(A)
			A.loc = user.loc
			if(isliving(A))
				var/mob/M = A
				M.reset_perspective()
		user.visible_message("<span class='alertealien'>[user] hurls out the contents of their stomach!</span>")
	return

/obj/effect/proc_holder/alien/nightvisiontoggle
	name = "Toggle Night Vision"
	desc = "Toggles Night Vision"
	has_action = 0 // Has dedicated GUI button already

/obj/effect/proc_holder/alien/nightvisiontoggle/fire(mob/living/carbon/alien/user)
	if(!user.nightvision)
		user.see_in_dark = 8
		user.see_invisible = SEE_INVISIBLE_MINIMUM
		user.nightvision = 1
		user.hud_used.nightvisionicon.icon_state = "nightvision1"
	else if(user.nightvision == 1)
		user.see_in_dark = 4
		user.see_invisible = 45
		user.nightvision = 0
		user.hud_used.nightvisionicon.icon_state = "nightvision0"

	return 1

/obj/effect/proc_holder/alien/sneak
	name = "Sneak"
	desc = "Blend into the shadows to stalk your prey."
	active = 0

	action_icon_state = "alien_sneak"

/obj/effect/proc_holder/alien/sneak/fire(mob/living/carbon/alien/humanoid/user)
	if(!active)
		user.alpha = 75 //Still easy to see in lit areas with bright tiles, almost invisible on resin.
		user.sneaking = 1
		active = 1
		user << "<span class='noticealien'>You blend into the shadows...</span>"
	else
		user.alpha = initial(user.alpha)
		user.sneaking = 0
		active = 0
		user << "<span class='noticealien'>You reveal yourself!</span>"

/obj/effect/proc_holder/alien/pheromone
	name = "Emit Pheromones"
	desc = "Emit pheromones in the area around you. Nearby xenomorphs will be enhanced in some way. This drains plasma to keep active."
	action_icon_state = "alien_pheromones_0"

/obj/effect/proc_holder/alien/pheromone/fire(mob/living/carbon/user)
	var/obj/item/organ/alien/pheromone/P = user.getorgan(/obj/item/organ/alien/pheromone)
	if(!P)
		return
	if(!P.active)
		var/chosenpmone = input(user, "Which pheromone would you like to emit?", "Pheromones") as null|anything in P.pheromone_types
		if(!chosenpmone)
			return
		user.visible_message("<span class='notice'><b>[user] begins to emit strange-smelling pheromones.</b></span>","<span class='notice'><b>You begin to emit [chosenpmone] pheromones.</b></span>")
		P.pheromone = chosenpmone
		P.active = TRUE
	else
		user << "<b>You stop emitting pheromones.</b>"
		P.active = FALSE

/obj/effect/proc_holder/alien/pheromone/update_icon()
	action.button_icon_state = "alien_pheromones_[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/sprayacid
	name = "Spray Acid"
	desc = "Spray several acid globs within a small range."
	action_icon_state = "alien_sprayacid_0"
	active = FALSE
	charge_max = 50
	plasma_cost = 100
	var/range = 7

/obj/effect/proc_holder/alien/sprayacid/fire(mob/living/carbon/user)
	var/message
	var/obj/item/organ/alien/acidspray/B = user.getorgan(/obj/item/organ/alien/acidspray)

	if(active)
		message = "<span class='notice'>You empty your [B].</span>"
		remove_ranged_ability(user, message)
	else
		message = "<span class='notice'>You prepare your [B]. <B>Left-click to fire at a target!</B></span>"
		add_ranged_ability(user, message)

/obj/effect/proc_holder/alien/sprayacid/update_icon()
	action.button_icon_state = "alien_sprayacid_[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/sprayacid/InterceptClickOn(mob/living/carbon/user, params, atom/target)
	if(..())
		return
	if(!user.usePlasma(plasma_cost))
		user << "<span class='warning'>You need at least [plasma_cost] plasma to spray.</span>"
		remove_ranged_ability(user)
		return
	user << "<span class='danger'>You spray several globs of acid towards \the [target]!</span>"
	spawn(0)
		start_recharge()
	var/list/turf_list = getline(user, target)
	var/turfsleft = range
	for(var/turf/T in turf_list)
		if(T == get_turf(user))
			continue
		if(!turfsleft)
			break
		if(T.density)
			break
		turfsleft--
		new /obj/effect/sprayed_acid(T)
		sleep(2)
	remove_ranged_ability(user)
	return TRUE

/obj/effect/proc_holder/alien/zoom
	name = "Toggle Zoom"
	desc = "Lets you see far away to correctly bombard your targets."
	plasma_cost = 20
	active = FALSE
	action_icon_state = "alien_zoom"
	var/zoom_amt = 7//will this be enough?we'll know only when this shit will compile

/obj/effect/proc_holder/alien/zoom/fire(mob/living/carbon/user, zoomed)
	if(!user || !user.client)
		return

	switch(zoomed)
		if(FALSE)
			active = FALSE
		if(TRUE)
			active = TRUE
		else
			active = !active

	if(active)
		var/_x = 0
		var/_y = 0
		switch(user.dir)
			if(NORTH)
				_y = zoom_amt
			if(EAST)
				_x = zoom_amt
			if(SOUTH)
				_y = -zoom_amt
			if(WEST)
				_x = -zoom_amt

		user.client.pixel_x = world.icon_size*_x
		user.client.pixel_y = world.icon_size*_y
	else
		user.client.pixel_x = 0
		user.client.pixel_y = 0

/obj/effect/proc_holder/alien/huggerstorage
	name = "Open Facehugger Storage"
	desc = "Open your facehugger internal storage."
	action_icon_state = "huggerstorage"

/obj/effect/proc_holder/alien/huggerstorage/fire(mob/living/carbon/user)
	var/obj/item/organ/alien/storage/S = user.getorgan(/obj/item/organ/alien/storage)
	if(!S)
		return
	S.huggerinv.MouseDrop(user)

/obj/effect/proc_holder/alien/stomp
	name = "Stomp"
	desc = "Stomp the floor to create a mini-earthquake and make your enemies fall on the ground."
	action_icon_state = "alien_stomp"
	var/range = 5
	plasma_cost = 50

/obj/effect/proc_holder/alien/stomp/fire(mob/living/carbon/user)
	var/obj/item/organ/alien/legmuscles/L = user.getorgan(/obj/item/organ/alien/legmuscles)
	if(!L)
		return
	user.visible_message("<span class='userdanger'>\The [user] smashes the ground!</span>","<span class='userdanger'>You smash the ground!</span>")
	for(var/mob/M in range(range, user))
		M.Weaken(rand(2,3))
		M << "<span class='userdanger'>The earth moves beneath your feet!</span>"
		if(M && M.client)
			shake_camera(M, 5, 1)

/obj/effect/proc_holder/alien/screech
	name = "Screech"
	desc = "Screech loudly to paralyse whoever's near you."
	plasma_cost = 250
	charge_max = 300//no spamming this,it's op
	action_icon_state = "alien_screech"

/obj/effect/proc_holder/alien/screech/fire(mob/living/carbon/user)
	var/obj/item/organ/alien/reinforcedvchords/R = user.getorgan(/obj/item/organ/alien/reinforcedvchords)
	if(!R)
		return
	for(var/mob/M in view())
		if(M == src || !M.client || isalien(M))
			continue
		var/stuntime = get_dist(src, M) <= 4 ? 4 : 2
		M.Stun(stuntime)
		M.Weaken(1)
		shake_camera(M, 30, 1)
		M.adjustEarDamage(stuntime*2,stuntime*2)
		playsound(user.loc, 'sound/voice/alien_queen_screech.ogg', 50, 1, 1)
		M << "<span class='danger'>An ear-splitting guttural roar shakes the ground beneath your feet!</span>"
	spawn(0)
		start_recharge()

/mob/living/carbon/proc/getPlasma()
	var/obj/item/organ/alien/plasmavessel/vessel = getorgan(/obj/item/organ/alien/plasmavessel)
	if(!vessel) return 0
	return vessel.storedPlasma


/mob/living/carbon/proc/adjustPlasma(amount)
	var/obj/item/organ/alien/plasmavessel/vessel = getorgan(/obj/item/organ/alien/plasmavessel)
	if(!vessel) return 0
	vessel.storedPlasma = Clamp(vessel.storedPlasma + amount, 0, vessel.max_plasma)
	for(var/X in abilities)
		var/obj/effect/proc_holder/alien/APH = X
		if(!APH)
			continue//this can be null because fuck you i guess
		if(APH.has_action)
			APH.action.UpdateButtonIcon()
	return 1

/mob/living/carbon/alien/adjustPlasma(amount)
	. = ..()
	updatePlasmaDisplay()

/mob/living/carbon/proc/usePlasma(amount)
	if(getPlasma() >= amount)
		adjustPlasma(-amount)
		return 1

	return 0


/proc/cmp_abilities_cost(obj/effect/proc_holder/alien/a, obj/effect/proc_holder/alien/b)
	return b.plasma_cost - a.plasma_cost


//items related to powers
/obj/item/weapon/storage/internal/alien
	name = "hugger sac"
	max_w_class = 1
	max_combined_w_class = 6 // 6 huggers
	can_hold = list(/obj/item/clothing/mask/facehugger)
	silent = 1

/obj/item/weapon/storage/internal/alien/ClickAccessible(mob/user, depth)
	if(!istype(user))
		return 0
	var/obj/item/organ/alien/storage/S = user.getorgan(/obj/item/organ/alien/storage)
	if(loc == S)
		return 1

/obj/item/weapon/storage/internal/Adjacent(A)
	return ClickAccessible(A)
