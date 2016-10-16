/mob/living/carbon/alien/humanoid/big/praetorian
	name = "alien praetorian"
	desc = "A huge alien that guards the Queen."
	caste = "praetorian"
	maxHealth = 200
	health = 200
	icon_state = "alienpraetorian"
	evolves_to = list("queen")
	melee_protection = 1.5

/mob/living/carbon/alien/humanoid/big/praetorian/New()

	internal_organs += new /obj/item/organ/alien/plasmavessel/large/praetorian
	internal_organs += new /obj/item/organ/alien/resinspinner
	internal_organs += new /obj/item/organ/alien/acid(acidpower = ACID)
	internal_organs += new /obj/item/organ/alien/neurotoxin/spitter
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))
	..()
