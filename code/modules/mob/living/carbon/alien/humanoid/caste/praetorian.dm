/mob/living/carbon/alien/humanoid/big/praetorian
	name = "alien praetorian"
	caste = "praetorian"
	maxHealth = 200
	health = 200
	icon_state = "alienpraetorian"
	melee_protection = 2
	caste_desc = "The queen's bodyguards, those aliens are tasked to protect the hive with their defensive power."

/mob/living/carbon/alien/humanoid/big/praetorian/New()

	internal_organs += new /obj/item/organ/alien/plasmavessel/large/praetorian
	internal_organs += new /obj/item/organ/alien/resinspinner
	internal_organs += new /obj/item/organ/alien/acid(acidpower = ACID)
	internal_organs += new /obj/item/organ/alien/neurotoxin/spitter
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))
	..()
