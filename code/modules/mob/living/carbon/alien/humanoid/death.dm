/mob/living/carbon/alien/humanoid/death(gibbed)
	if(stat == DEAD)
		return

	stat = DEAD

	if(!gibbed)
		playsound(loc, 'sound/voice/hiss6.ogg', 80, 1, 1)
		visible_message("<span class='name'>[src]</span> lets out a waning guttural screech, green blood bubbling from its maw...")
		update_canmove()
		update_icons()
		status_flags |= CANPUSH

		for (var/mob/living/carbon/alien/a in aliens)
			a << "<span class='alertalien'>[src] has been slain at [src.loc.loc ? src.loc.loc : src.loc ? src.loc : "the void"]!</span>"

	aliens -= src

	return ..()