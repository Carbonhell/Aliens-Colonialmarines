/mob/living/carbon/alien/humanoid
	name = "alien"
	icon_state = "alien_s"
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab/xeno = 5, /obj/item/stack/sheet/animalhide/xeno = 1)
	limb_destroyer = 1
	tier = 1
	var/obj/item/r_store = null
	var/obj/item/l_store = null
	var/alt_icon = 'icons/mob/alienleap.dmi' //used to switch between the two alien icon files.
	var/custom_pixel_x_offset = 0 //for admin fuckery.
	var/custom_pixel_y_offset = 0
	var/sneaking = 0 //For sneaky-sneaky mode and appropriate slowdown
	var/leap_on_click = 0
	var/pounce_cooldown = 0
	var/pounce_cooldown_time = 30
	var/leap_range = 0
	var/obj/screen/leap_icon = null//because not just the warrior needs it
	var/can_leap = FALSE

//This is fine right now, if we're adding organ specific damage this needs to be updated
/mob/living/carbon/alien/humanoid/New()
	AddAbility(new/obj/effect/proc_holder/alien/regurgitate())

	..()


/mob/living/carbon/alien/humanoid/movement_delay()
	. = ..()
	. += config.alien_delay + sneaking	//move_delay_add is used to slow aliens with stuns
	. += pulling ? 2 : 0

/mob/living/carbon/alien/humanoid/emp_act(severity)
	if(r_store) r_store.emp_act(severity)
	if(l_store) l_store.emp_act(severity)
	..()

/mob/living/carbon/alien/humanoid/attack_hulk(mob/living/carbon/human/user)
	if(user.a_intent == "harm")
		..(user, 1)
		adjustBruteLoss(15)
		var/hitverb = "punched"
		if(mob_size < MOB_SIZE_LARGE)
			Paralyse(1)
			step_away(src,user,15)
			sleep(1)
			step_away(src,user,15)
			hitverb = "slammed"
		playsound(loc, "punch", 25, 1, -1)
		visible_message("<span class='danger'>[user] has [hitverb] [src]!</span>", \
		"<span class='userdanger'>[user] has [hitverb] [src]!</span>")
		return 1

/mob/living/carbon/alien/humanoid/attack_hand(mob/living/carbon/human/M)
	if(..())
		switch(M.a_intent)
			if ("harm")
				var/damage = rand(1, 9)
				if (prob(90))
					playsound(loc, "punch", 25, 1, -1)
					visible_message("<span class='danger'>[M] has punched [src]!</span>", \
							"<span class='userdanger'>[M] has punched [src]!</span>")
					adjustBruteLoss(damage)
					add_logs(M, src, "punched")
					updatehealth()
				else
					playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
					visible_message("<span class='danger'>[M] has attempted to punch [src]!</span>")

/mob/living/carbon/alien/humanoid/restrained(ignore_grab)
	. = handcuffed

/mob/living/carbon/alien/humanoid/cuff_resist(obj/item/I)
	playsound(src, 'sound/voice/hiss5.ogg', 40, 1, 1)  //Alien roars when starting to break free
	..(I, cuff_break = INSTANT_CUFFBREAK)

/mob/living/carbon/alien/humanoid/resist_grab(moving_resist)
	if(pulledby.grab_state)
		visible_message("<span class='danger'>[src] has broken free of [pulledby]'s grip!</span>")
	pulledby.stop_pulling()
	. = 0

/mob/living/carbon/alien/humanoid/get_standard_pixel_y_offset(lying = 0)
	if(leaping)
		return -32
	else if(custom_pixel_y_offset)
		return custom_pixel_y_offset
	else
		return initial(pixel_y)

/mob/living/carbon/alien/humanoid/get_standard_pixel_x_offset(lying = 0)
	if(leaping)
		return -32
	else if(custom_pixel_x_offset)
		return custom_pixel_x_offset
	else
		return initial(pixel_x)

/mob/living/carbon/alien/humanoid/check_ear_prot()
	return 1

/mob/living/carbon/alien/humanoid/get_permeability_protection()
	return 0.8

/mob/living/carbon/alien/humanoid/check_breath(datum/gas_mixture/breath)
	if(breath && breath.total_moles() > 0 && !sneaking)
		playsound(get_turf(src), pick('sound/voice/lowHiss2.ogg', 'sound/voice/lowHiss3.ogg', 'sound/voice/lowHiss4.ogg'), 50, 0, -5)
	..()

/mob/living/carbon/alien/humanoid/grabbedby(mob/living/carbon/user, supress_message = 0)
	if(user == src && pulling && grab_state >= GRAB_AGGRESSIVE && !pulling.anchored && iscarbon(pulling))
		devour_mob(pulling, devour_time = 60)
	else
		..()

/mob/living/carbon/alien/humanoid/Stat()
	..()
	if(statpanel("Status"))
		if(timerMax)
			stat(null, "Evolution Progress: [timerGrow]/[timerMax]")

/mob/living/carbon/alien/humanoid/ClickOn(atom/A, params)
	face_atom(A)
	if(leap_on_click)
		leap_at(A)
	else
		..()

/mob/living/carbon/alien/humanoid/proc/leap_at(atom/A)
	if(pounce_cooldown)
		src << "<span class='alertalien'>You are too fatigued to pounce right now!</span>"
		toggle_leap(0)
		return

	if(leaping || stat || buckled || lying)
		return

	if(!has_gravity() || !A.has_gravity())
		src << "<span class='alertalien'>It is unsafe to leap without gravity!</span>"
		toggle_leap(0)
		//It's also extremely buggy visually, so it's balance+bugfix
		return
	leaping = 1
	weather_immunities += "lava"
	update_icons()
	throw_at(A,leap_range,1, spin=0, diagonals_first = 1)//this defines the effect of each leap.
	leaping = 0
	weather_immunities -= "lava"
	update_icons()
	pounce_cooldown = !pounce_cooldown
	spawn(pounce_cooldown_time) //3s by default
		pounce_cooldown = !pounce_cooldown

/mob/living/carbon/alien/humanoid/proc/toggle_leap(message = 1)
	leap_on_click = !leap_on_click
	leap_icon.icon_state = "leap_[leap_on_click ? "on":"off"]"
	update_icons()
	if(message)
		src << "<span class='noticealien'>You will now [leap_on_click ? "leap at":"slash at"] enemies!</span>"
	else
		return

/mob/living/carbon/alien/humanoid/float(on)
	if(leaping)
		return
	..()

/mob/living/carbon/alien/humanoid/update_canmove()
	. = ..()
	if(leaping || status_flags & FREEZED)
		return 0