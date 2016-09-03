/mob/living/carbon/alien/humanoid/carrier
	name = "carrier"
	desc = "A strange-looking alien creature. It carries a number of scuttling jointed crablike creatures."
	caste = "carrier"
	icon_state = "aliencarrier_s"
	maxHealth = 175
	health = 175
	caste_desc = "The carrier can carry up to 6 facehuggers normally, along with two more if you consider the claws, along with being able to throw them up to 5 tiles away."
	tier = 3
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles

/mob/living/carbon/alien/humanoid/carrier/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel
	internal_organs += new /obj/item/organ/alien/storage
	..()

//throwing facehuggers code is in facehugger.dm at line 114
//I am sorry for the snowflakey way to do it but making a new organ for a thing only used by this alien seems eh -Carbon