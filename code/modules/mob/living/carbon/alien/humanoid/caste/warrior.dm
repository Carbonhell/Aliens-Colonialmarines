/mob/living/carbon/alien/humanoid/warrior
	name = "alien warrior"
	desc = "A fast alien with sharp claws."
	caste = "warrior"
	icon_state = "alienwarrior_s"
	maxHealth = 150
	health = 150
	timerMax = 500
	move_delay_add = -1
	tier = 1
	melee_protection = 1.5
	evolves_to = list("crusher","ravager")
	caste_desc = "The warrior, known to find his prey alone and snatching it without alarming the enemies."
	can_leap = TRUE
	leap_range = 7

/mob/living/carbon/alien/humanoid/warrior/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel/small
	AddAbility(new /obj/effect/proc_holder/alien/sneak)
	..()

/mob/living/carbon/alien/humanoid/warrior/throw_impact(atom/A)

	if(!leaping)
		return ..()

	if(A)
		if(istype(A, /mob/living))
			var/mob/living/L = A
			var/blocked = 0
			if(ishuman(A))
				var/mob/living/carbon/human/H = A
				if(H.check_shields(0, "the [name]", src, attack_type = LEAP_ATTACK))
					blocked = 1
			if(!blocked)
				L.visible_message("<span class ='danger'>[src] pounces on [L]!</span>", "<span class ='userdanger'>[src] pounces on you!</span>")
				status_flags |= FREEZED
				L.Weaken(2)
				playsound(loc, 'sound/voice/alien_pounce.ogg', 30, 1, 1)
				spawn(2)
					status_flags &= ~FREEZED
				sleep(2)//Runtime prevention (infinite bump() calls on hulks)
				step_towards(src,L)
			else
				Weaken(2, 1, 1)

		else if(A.density && !A.CanPass(src))
			visible_message("<span class ='danger'>[src] smashes into [A]!</span>", "<span class ='alertalien'>[src] smashes into [A]!</span>")
			Weaken(2, 1, 1)

		if(leaping)
			leaping = 0
			update_icons()
			update_canmove()
