/* Alien shit!
 * Contains:
 *		effect/acid
 */


/*
 * Acid
 */
/obj/effect/acid
	gender = PLURAL
	name = "acid"
	desc = "Burbling corrossive stuff."
	icon_state = "acid"
	density = 0
	opacity = 0
	anchored = 1
	unacidable = 1
	var/atom/target
	var/ticks = 0
	var/target_strength = 0
	var/strength = 1


/obj/effect/acid/New(loc, targ)
	..(loc)
	target = targ

	//handle APCs and newscasters and stuff nicely
	pixel_x = target.pixel_x
	pixel_y = target.pixel_y

	target_strength = 600
	target_strength /= strength
	ticks = target_strength
	tick()


/obj/effect/acid/proc/tick()
	if(!target)
		qdel(src)
	if(!src)
		return

	ticks--

	if(!ticks)
		target.visible_message("<span class='warning'>[target] collapses under its own weight into a puddle of goop and undigested debris!</span>")

		if(istype(target, /obj/structure/closet))
			var/obj/structure/closet/T = target
			T.dump_contents()
			qdel(target)

		if(istype(target, /turf/closed/mineral))
			var/turf/closed/mineral/M = target
			M.ChangeTurf(M.baseturf)

		if(istype(target, /turf/open/floor))
			var/turf/open/floor/F = target
			F.ChangeTurf(F.baseturf)

		if(istype(target, /turf/closed/wall))
			var/turf/closed/wall/W = target
			W.dismantle_wall(1)

		else
			qdel(target)

		qdel(src)
		return

	x = target.x
	y = target.y
	z = target.z

	if(ticks == target_strength/5)
		visible_message("<span class='warning'>[target] is holding up against the acid!</span>")
	else if(ticks == target_strength/4)
		visible_message("<span class='warning'>[target] is being melted by the acid!</span>")
	else if(ticks == target_strength/3)
		visible_message("<span class='warning'>[target] is struggling to withstand the acid!</span>")
	else if(ticks ==target_strength/2)
		visible_message("<span class='warning'>[target] starts to fall apart!</span>")

	spawn(1)
		if(src)
			tick()

/obj/effect/acid/weak
	name = "weak acid"
	strength = 0.75

/obj/effect/acid/strong
	name = "strong acid"
	strength = 1.25


/obj/effect/sprayed_acid//different than the thing up here cause it doesn't actually melt stuff.
	gender = PLURAL
	name = "acid"
	desc = "Burbling corrossive stuff."
	icon_state = "acid"
	density = 0
	opacity = 0
	anchored = 1
	unacidable = 1
	var/damage = 20

/obj/effect/sprayed_acid/New()
	..()
	QDEL_IN(src, 100+rand(0,30))

/obj/effect/sprayed_acid/Crossed(atom/A)
	if(isliving(A))
		if(!isalien(A))
			var/mob/living/M = A
			M.adjustFireLoss(damage)