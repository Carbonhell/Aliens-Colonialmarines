/mob/living/carbon/alien/humanoid/sentinel
	name = "alien sentinel"
	caste = "s"
	maxHealth = 130
	health = 130
	jelly = 0
	tier = 1
	icon_state = "aliensentinel_s"
	evolves_to = list("corroder", "praetorian")


/mob/living/carbon/alien/humanoid/sentinel/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel
	internal_organs += new /obj/item/organ/alien/acid(acidpower = ACID)
	internal_organs += new /obj/item/organ/alien/neurotoxin/spitter
	AddAbility(new /obj/effect/proc_holder/alien/sneak())
	..()
