/mob/living/carbon/alien/spawn_gibs()
	xgibs(loc, viruses)

/mob/living/carbon/alien/gib_animation()
	PoolOrNew(/obj/effect/overlay/temp/gib_animation, list(loc, "gibbed-a"))

/mob/living/carbon/alien/spawn_dust()
	new /obj/effect/decal/remains/xeno(loc)

/mob/living/carbon/alien/dust_animation()
	PoolOrNew(/obj/effect/overlay/temp/dust_animation, list(loc, "dust-a"))

/mob/living/carbon/alien/death(gibbed)
	for (var/mob/living/carbon/alien/a in aliens)
		a << "<span class='alertalien'>[src] has been slain at [get_area(src)]!</span>"
	..(gibbed)