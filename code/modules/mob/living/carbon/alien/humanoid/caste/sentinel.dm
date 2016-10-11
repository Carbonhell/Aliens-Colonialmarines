/mob/living/carbon/alien/humanoid/sentinel
	name = "alien sentinel"
	desc = "An acid-spitting alien."
	caste = "sentinel"
	maxHealth = 130
	health = 130
	tier = 1
	timerMax = 400
	icon_state = "aliensentinel_s"
	evolves_to = list("corroder")


/mob/living/carbon/alien/humanoid/sentinel/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel
	internal_organs += new /obj/item/organ/alien/acid(acidpower = ACID)
	internal_organs += new /obj/item/organ/alien/neurotoxin/spitter
	AddAbility(new /obj/effect/proc_holder/alien/sneak())
	..()
