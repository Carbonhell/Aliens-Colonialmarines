
/turf/open/grounddirt //Basic groundmap turf parent
	name = "ground dirt"
	icon = 'icons/turf/ground_map.dmi'
	icon_state = "desert"
	heat_capacity = 500000 //Shouldn't be possible, but you never know...
	baseturf = /turf/open/grounddirt
	planetary_atmos = TRUE

/turf/open/grounddirt/can_have_cabling() //This should fix everything else. No cables, etc
	return 0

/turf/open/grounddirt/dirt
	name = "dirt"
	icon_state = "desert"

/turf/open/grounddirt/dirt/New()
	..()
	if(rand(0,15) == 0)
		icon_state = "desert[pick("0","1","2","3")]"

/turf/open/grounddirt/grass
	name = "grass"
	icon_state = "grass1"

//Ground map walls
/turf/closed/jungle
	name = "dense jungle"
	icon = 'icons/turf/ground_map.dmi'
	icon_state = "wall2"
	desc = "Some thick jungle."
	explosion_block = 50
	baseturf = /turf/open/grounddirt/dirt


/turf/closed/jungle/dense
	name = "dense jungle wall"
	icon = 'icons/turf/ground_map.dmi'
	icon_state = "wall2"

/turf/closed/jungle/dense/New()
	..()
	icon_state = pick("wall1","wall2","wall3")


/turf/open/grounddirt/dirtgrassborder
	name = "grass"
	icon_state = "grassdirt_edge"

/turf/open/grounddirt/river
	name = "river"
	icon_state = "seashallow"
	var/overlaystate = "riverwater"

/turf/open/grounddirt/river/New()
	..()
	overlays += image("icon"='icons/turf/ground_map.dmi',"icon_state"=overlaystate,"layer"=MOB_LAYER+0.1)

/turf/open/grounddirt/river/Crossed(mob/user)
	wash_mob(user)

/turf/open/grounddirt/coast
	name = "coastline"
	icon_state = "beach"

/turf/open/grounddirt/river/deep
	name = "river"
	icon_state = "seadeep"
	overlaystate = "water"

//*********************//
// Generic undergrowth //
//*********************//

/obj/structure/jungle
	name = "jungle foliage"
	icon = 'icons/turf/ground_map.dmi'
	density = 0
	anchored = 1
	unacidable = 1 // can toggle it off anyway
	layer = MOB_LAYER+0.1

/obj/structure/jungle/shrub
	name = "jungle foliage"
	desc = "Pretty thick scrub, it'll take something sharp and a lot of determination to clear away."
	icon_state = "grass4"

/obj/structure/jungle/plantbot1
	name = "strange tree"
	desc = "Some kind of bizarre alien tree. It oozes with a sickly yellow sap."
	icon_state = "plantbot1"

/obj/structure/jungle/planttop1
	name = "strange tree"
	desc = "Some kind of bizarre alien tree. It oozes with a sickly yellow sap."
	icon_state = "planttop1"

/obj/structure/jungle/tree
	icon = 'icons/obj/flora/ground_map64.dmi'
	desc = "What an enormous tree!"

/obj/structure/jungle/tree/bigtreeTR
	name = "huge tree"
	icon_state = "bigtreeTR"

/obj/structure/jungle/tree/bigtreeTL
	name = "huge tree"
	icon_state = "bigtreeTL"

/obj/structure/jungle/tree/bigtreeBOT
	name = "huge tree"
	icon_state = "bigtreeBOT"

/obj/structure/jungle/vines_lite
	name = "vines"
	desc = "A mass of twisted vines."
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "Light1"
	layer = MOB_LAYER-0.1

/obj/structure/jungle/vines_heavy
	name = "vines"
	desc = "A thick, coiled mass of twisted vines."
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "Hvy1"
	layer = MOB_LAYER-0.1

/obj/structure/jungle/tree/grasscarpet
	name = "thick grass"
	desc = "A thick mat of dense grass."
	icon_state = "grasscarpet"
	layer = MOB_LAYER-0.1



//Sulaco walls. They use wall instead of shuttle code so they overlap and we can do fun stuff to them without using unsimulated shuttle things.
/turf/closed/wall/r_wall/sulaco
	name = "spaceship hull"
	desc = "A huge chunk of metal used to separate rooms on spaceships from the cold void of space."
	icon = 'icons/turf/walls.dmi'
	icon_state = "sulaco0"

/turf/closed/indestructible/hull
	name = "outer hull"
	desc = "A reinforced outer hull, probably to prevent breaches"
