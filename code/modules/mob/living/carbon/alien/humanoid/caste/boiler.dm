/mob/living/carbon/alien/humanoid/big/corroder
	name = "corroder"
	desc = "A huge, grotesque xenomorph covered in glowing, oozing acid slime."
	caste = "corroder"
	icon_state = "aliencorroder"
	maxHealth = 180
	health = 180
	caste_desc = "The xenomorph's mortar, it can defeat its enemies from behind the lines and can melt things extremely quickly."
	luminosity = 3

/mob/living/carbon/alien/humanoid/big/boiler/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel/large/boiler
	internal_organs += new /obj/item/organ/alien/acid(acidpower = STRONGACID)
	internal_organs += new /obj/item/organ/alien/neurotoxin/bombard
	internal_organs += new /obj/item/organ/alien/acidspray

	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))

	..()