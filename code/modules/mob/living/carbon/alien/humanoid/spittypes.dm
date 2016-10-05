//actual chems are inside the chem files

/obj/item/projectile/bullet/acid
	name = "acid spit"
	icon_state = "toxin"
	damage = 30
	damage_type = BURN
	suppressed = TRUE //we don't want the "has been shot by a neurotoxin spit"
	range = 7
	var/chosenchemid
	var/chem_quantity = 10

/obj/item/projectile/bullet/acid/New()
	..()
	if(chosenchemid)
		create_reagents(50)
		reagents.add_reagent(chosenchemid, chem_quantity)

/obj/item/projectile/bullet/acid/Bump(atom/A, yes)
	if(isalien(A))
		return 0
	..()

/obj/item/projectile/bullet/acid/on_hit(atom/target, blocked = 0, hit_zone)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			..()
			if(reagents)
				reagents.trans_to(M, reagents.total_volume)
				reagents.reaction(M, TOUCH)
			return 1
		else
			target.visible_message("<span class='danger'>The [name] was deflected!</span>", \
									   "<span class='userdanger'>You were protected against the [name]!</span>")
			return 0
	..()
	if(reagents)
		reagents.reaction(target, TOUCH)
	return 1


/obj/item/projectile/bullet/acid/neuro
	name = "neurotoxin"
	damage = 0
	nodamage = TRUE
	chosenchemid

/obj/item/projectile/bullet/acid/neuro/on_hit(atom/target, blocked = 0, hit_zone)
	if(..())
		if(ismob(target))
			var/mob/M = target
			M.Weaken(4)

/obj/item/projectile/bullet/acid/weak
	name = "weak acid spit"
	damage = 15

/obj/item/projectile/bullet/acid/bombard
	name = "acid glob"
	desc = "Gross!"
	icon_state = "glob"
	damage = 20//jeez don't get hit by it
	chosenchemid = "neuroacid"
	chem_quantity = 2
	range = 16

/obj/item/projectile/bullet/acid/bombard/on_hit(atom/target, blocked = 0, hit_zone)
	var/datum/reagents/R = new/datum/reagents(50)
	R.my_atom = target
	R.add_reagent(chosenchemid, chem_quantity)
	chosenchemid = null//don't want the chems to get transferred on hit too,gonna try to balance this
	..()

	var/datum/effect_system/smoke_spread/chem/smoke = new
	smoke.set_up(R, 5, target, silent = 1)
	playsound(get_turf(target), 'sound/effects/smoke.ogg', 50, 1, -3)
	smoke.start()
	qdel(R)

/obj/item/projectile/bullet/acid/bombard/lethal
	name = "concentraced acid glob"
	chosenchemid = "acidglob"
	damage = 50
