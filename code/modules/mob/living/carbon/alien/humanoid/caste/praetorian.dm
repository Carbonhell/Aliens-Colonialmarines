/mob/living/carbon/alien/humanoid/big/praetorian
	name = "alien praetorian"
	desc = "A huge alien that guards the Queen."
	caste = "praetorian"
	maxHealth = 300
	health = 300
	icon_state = "alienpraetorian"
	evolves_to = list("queen")
	melee_protection = 1.5
	move_delay_add = -3.25

/mob/living/carbon/alien/humanoid/big/praetorian/New()

	internal_organs += new /obj/item/organ/alien/plasmavessel/large/praetorian
	internal_organs += new /obj/item/organ/alien/resinspinner
	internal_organs += new /obj/item/organ/alien/acid(acidpower = ACID)
	internal_organs += new /obj/item/organ/alien/neurotoxin/spitter
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))
	..()
