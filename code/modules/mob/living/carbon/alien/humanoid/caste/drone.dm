/mob/living/carbon/alien/humanoid/drone
	name = "alien drone"
	desc = "An alien capable of shaping resin in several different ways."
	icon_state = "aliendrone_s"
	caste = "drone"
	maxHealth = 220
	health = 220
	timerMax = 200
	tier = 1
	evolves_to = list("praetorian", "queen")//can evolve to queen directly
	mob_size = MOB_SIZE_HUMAN
	move_delay_add = -3.1

/mob/living/carbon/alien/humanoid/drone/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel/large
	internal_organs += new /obj/item/organ/alien/resinspinner
	internal_organs += new /obj/item/organ/alien/acid
	internal_organs += new /obj/item/organ/alien/pheromone
	..()
