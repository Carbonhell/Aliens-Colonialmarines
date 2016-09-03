/mob/living/carbon/alien/humanoid/big/ravager
	name = "alien ravager"
	caste = "ravager"
	maxHealth = 180
	health = 180
	icon_state = "alienravager"
	melee_protection = 2
	caste_desc = "The core of the xenomorphic offense power. This guy can destroy defenses in a whim. Aswell as people."

/mob/living/carbon/alien/humanoid/big/ravager/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel/small
	internal_organs += new /obj/effect/proc_holder/alien/pounce/charge
	..()

/mob/living/carbon/alien/humanoid/big/ravager/throw_impact(atom/A)

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
				L.Weaken(5)
				sleep(2)//Runtime prevention (infinite bump() calls on hulks)
				step_towards(src,L)
				for(var/i in 1 to 3)
					if(!step(L, dir))
						break

		else if(A.density && !A.CanPass(src))
			visible_message("<span class ='danger'>[src] smashes into [A]!</span>", "<span class ='alertalien'>[src] smashes into [A]!</span>")
			Weaken(2, 1, 1)

		if(leaping)
			leaping = 0
			update_icons()
			update_canmove()