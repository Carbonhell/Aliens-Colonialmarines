/mob/living/carbon/alien/humanoid/big/crusher
	name = "crusher"
	desc = "An huge alien with an enormous armored head crest."
	icon_state = "aliencrusher"
	caste = "crusher"
	maxHealth = 200
	health = 200
	melee_protection = 2
	var/momentum = 0
	var/speed = 0
	var/olddir
	var/timeout = 0
	move_delay_add = -3.5

/mob/living/carbon/alien/humanoid/big/crusher/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel
	internal_organs += new /obj/item/organ/alien/legmuscles
	AddAbility(new/obj/effect/proc_holder/alien/togglemomentum())
	..()

/mob/living/carbon/alien/humanoid/big/crusher/Stat()
	..()
	stat(null, "Momentum: [momentum == -1 ? "OFF" : momentum]")

/mob/living/carbon/alien/humanoid/big/crusher/movement_delay()
	. = ..()
	. -= speed

/mob/living/carbon/alien/humanoid/big/crusher/Move()
	if(!..())
		return
	if(momentum != -1)//if it's not disabled
		if(olddir != dir)
			olddir = dir
			momentum = 0
			speed = 0
			return
		momentum += 6
		momentum = min(momentum, 64)
		speed = round(momentum/16)

/mob/living/carbon/alien/humanoid/big/crusher/Bump(atom/A)
	..()
	if(momentum <= 18)//either disabled, empty or too low to even matter.
		return
	if(ismob(A))
		var/direction = prob(50) ? 90 : 270
		var/tempdir = turn(A.dir, direction)
		step(A, tempdir)
		visible_message("<span class='danger'>[src] rams into [A]!</b>","<B>You ram into [A]!</span>")
	else//turf or obj
		if(A.density)
			if("health" in A.vars)
				A:health -= momentum*3//colon safe to use cause we know this var exists
				if(A:health <= 0)
					if(isturf(A))
						var/turf/T = A
						T.ChangeTurf(/turf/open/floor/plating)
					else
						qdel(A)
			else if(isobj(A))
				var/obj/O = A
				if(!O.anchored)
					var/direction = prob(50) ? 90 : 270
					var/tempdir = turn(O.dir, direction)
					step(O, tempdir)
		visible_message("<B>[src] rams into [A]!</B>","<B>You ram into [A]!</B>")
		momentum = 0
		speed = 0

/obj/effect/proc_holder/alien/togglemomentum
	name = "Toggle Momentum Gathering"
	desc = "Stop auto-charging when you move."
	action_icon_state = "momentum_0"
	active = TRUE

/obj/effect/proc_holder/alien/togglemomentum/update_icon()
	action.button_icon_state = "momentum_[active ? "1" : "0"]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/alien/togglemomentum/fire(mob/living/carbon/user)
	if(istype(user, /mob/living/carbon/alien/humanoid/big/crusher))
		var/mob/living/carbon/alien/humanoid/big/crusher/C = user
		C.momentum = C.momentum != -1 ? -1 : 0
		user << "<span class='notice'>You will [C.momentum == -1 ? "no longer" : "now"] charge when moving.</span>"
		active = !active

/mob/living/carbon/alien/humanoid/big/crusher/Life()
	..()
	if(dir == olddir)
		timeout++
	if(timeout >= 5)
		momentum = 0