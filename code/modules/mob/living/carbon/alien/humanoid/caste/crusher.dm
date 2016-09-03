/mob/living/carbon/alien/humanoid/big/crusher
	name = "crusher"
	desc = "An huge alien with an enormous armored head crest."
	icon_state = "aliencrusher"
	caste = "crusher"
	maxHealth = 200
	health = 200
	caste_desc = "An huge alien capable of packing a bunch of lead in his head. Althrough, this makes the back defenseless."
	melee_protection = 3
	var/momentum = 0
	var/speed = 0

/mob/living/carbon/alien/humanoid/big/crusher/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel
	internal_organs += new /obj/item/organ/alien/legmuscles
	AddAbility(new/obj/effect/proc_holder/alien/togglemomentum())
	..()

/mob/living/carbon/alien/humanoid/big/crusher/Stat()
	..()
	stat(null, "Momentum: [momentum]")

/mob/living/carbon/alien/humanoid/big/crusher/movement_delay()
	. = ..()
	. -= speed

/mob/living/carbon/alien/humanoid/big/crusher/Move()
	if(!..())
		return
	if((momentum != -1) && m_intent != "walk")//if it's not disabled
		momentum = !momentum ? momentum++ : momentum*2
		momentum = min(momentum, 64)
		speed = round(momentum/16)

/mob/living/carbon/alien/humanoid/big/crusher/Bump(atom/A)
	..()
	if(momentum <= 0)//either disabled or empty
		return
	if(ismob(A))
		var/direction = prob(50) ? 90 : 270
		var/tempdir = Turn(A.dir, direction)
		A.step(A, tempdir)
		visible_message("<span class='danger'>[src] rams into [A]!</b>","<B>You ram into [A]!</span>")
	else//turf or obj
		if(AM.density)
			if("health" in AM.vars)
				AM:health -= momentum*3//colon safe to use cause we know this var exists
				if(!AM:health)
					qdel(AM)
			else if(!AM.anchored)
				var/direction = prob(50) ? 90 : 270
				var/tempdir = Turn(A.dir, direction)
				A.step(A, tempdir)
		visible_message("<B>[src] rams into [AM]!</b>","<B>You ram into [AM]!</B>")

/obj/effect/proc_holder/alien/togglemomentum
	name = "Toggle Momentum Gathering"
	desc = "Stop auto-charging when you move."
	action_icon_state = "momentum_0"

/obj/effect/proc_holder/alien/togglemomentum/update_icon()
	action.button_icon_state = "momentum_[momentum == -1 ? "-1" : "0"]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/togglemomentum/fire(mob/living/carbon/user)
	if(istype(user, /mob/living/carbon/alien/humanoid/crusher))
		momentum = momentum != -1 ? -1 : 0
		user << "<span class='notice'>You will [momentum == -1 ? "no longer" : "now"] charge when moving.</span>"