/mob/living/carbon/alien/humanoid/drone
	name = "alien drone"
	desc = "An alien capable of shaping resin in several different ways."
	icon_state = "aliendrone_s"
	caste = "drone"
	maxHealth = 120
	health = 120
	timerMax = 200
	tier = 1
	evolves_to = list("praetorian")//can evolve to queen directly
	caste_desc = "The ones behind the stage, these little ones suck at combat but they are the builders of the Hive."
	mob_size = MOB_SIZE_HUMAN

/mob/living/carbon/alien/humanoid/drone/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel/large
	internal_organs += new /obj/item/organ/alien/resinspinner
	internal_organs += new /obj/item/organ/alien/acid
	internal_organs += new /obj/item/organ/alien/pheromone
	..()
