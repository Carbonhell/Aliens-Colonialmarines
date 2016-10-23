/mob/living/carbon/alien/humanoid/big/corroder
	name = "corroder"
	desc = "A huge, grotesque xenomorph covered in glowing, oozing acid slime."
	caste = "corroder"
	icon_state = "aliencorroder"
	maxHealth = 280
	health = 280
	luminosity = 3
	see_in_dark = 16
	move_delay_add = -2

/mob/living/carbon/alien/humanoid/big/corroder/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel/large/corroder
	internal_organs += new /obj/item/organ/alien/acid(acidpower = STRONGACID)
	internal_organs += new /obj/item/organ/alien/neurotoxin/bombard
	internal_organs += new /obj/item/organ/alien/acidspray

	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))

	..()