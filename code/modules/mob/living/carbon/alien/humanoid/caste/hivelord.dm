/mob/living/carbon/alien/humanoid/hivelord
	name = "alien hivelord"
	desc = "An alien capable of shaping resin in several different ways."
	icon_state = "alienhivelord_s"
	caste = "hivelord"
	maxHealth = 220
	health = 220
	tier = 2
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles
	caste_desc = "The ones behind the stage, those big ones suck at combat but they are the builders of the Hive."

/mob/living/carbon/alien/humanoid/hivelord/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel/large/hivelord
	internal_organs += new /obj/item/organ/alien/resinspinner
	internal_organs += new /obj/item/organ/alien/acid(acidpower = ACID)
	internal_organs += new /obj/item/organ/alien/pheromone
	..()