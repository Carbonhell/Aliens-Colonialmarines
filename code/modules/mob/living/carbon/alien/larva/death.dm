/mob/living/carbon/alien/larva/death(gibbed)
	if(stat == DEAD)
		return
	stat = DEAD
	icon_state = "larva_dead"
	playsound(loc, 'sound/voice/alien_death2.ogg', 50, 1, 1)

	if(!gibbed)
		visible_message("<span class='name'>[src]</span> lets out a waning high-pitched cry.")

	return ..(gibbed)
