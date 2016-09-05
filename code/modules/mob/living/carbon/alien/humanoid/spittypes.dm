//actual chems are inside the chem files

/obj/item/projectile/bullet/neurotoxin
	name = "neurotoxin"
	icon_state = "neurotoxin"
	damage = 0
	suppressed = TRUE //we don't want the "has been shot by a neurotoxin spit tbh"
	range = 7
	var/chosenchemid = "neuroacid"

/obj/item/projectile/bullet/neurotoxin/Bump(atom/A, yes)
	if(isalien(A))
		return 0
	..()

/obj/item/projectile/bullet/neurotoxin/New()
	..()
	create_reagents(50)
	reagents.add_reagent(chosenchemid, 1)

/obj/item/projectile/bullet/neurotoxin/on_hit(atom/target, blocked = 0, hit_zone)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			..()
			reagents.trans_to(M, reagents.total_volume)
			reagents.reaction(M, TOUCH)
			return 1
		else
			target.visible_message("<span class='danger'>The [name] was deflected!</span>", \
									   "<span class='userdanger'>You were protected against the [name]!</span>")
			return 0
	reagents.reaction(target, TOUCH)
	..()
	return 1

/obj/item/projectile/bullet/neurotoxin/weakacid
	name = "weak acid spit"
	chosenchemid = "weakacid"

/obj/item/projectile/bullet/neurotoxin/mediumacid
	name = "acid"
	chosenchemid = "mediumacid"

/obj/item/projectile/bullet/weakbombard //not a children of the thing up here cause it explodes on contact with anything,creating a smoke cloud.
	name = "acid glob"
	desc = "Gross!"
	icon_state = "glob"
	damage = 20//jeez don't get hit by it
	damage_type = BURN
	suppressed = TRUE
	var/chosenchemid = "neuroacid"
	range = 16

/obj/item/projectile/bullet/weakbombard/Bump(atom/A, yes)
	if(isalien(A))
		return 0
	..()

/obj/item/projectile/bullet/weakbombard/New()
	..()
	create_reagents(100)
	reagents.add_reagent(chosenchemid, 10)

/obj/item/projectile/bullet/weakbombard/on_hit(atom/target, blocked = 0, hit_zone)
	..()
	reagents.add_reagent("smoke_powder", 50, reagtemp = 4000) //Makes a big healthy cloud of smoke with your death gas of choice!
	reagents.handle_reactions()

/obj/item/projectile/bullet/weakbombard/notweak
	chosenchemid = "acidglob"

