//fuck effect mines,they're horrible
/obj/item/weapon/mine
	name = "mine"
	desc = "A mine."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "claymore"
	density = 0
	anchored = 0
	throw_range = 1
	var/active = FALSE

/obj/item/weapon/mine/proc/mine_effect(mob/victim)
	victim << "<span class='danger'>*click*</span>"

/obj/item/weapon/mine/attack_self(mob/user)
	active = !active
	anchored = !anchored
	user << "<span class='notice'>You [active ? "enable" : "disable"] \the [name].</span>"

/obj/item/weapon/mine/proc/triggermine(mob/victim)
	if(!active)
		return
	visible_message("<span class='danger'>[victim] sets off \icon[src] [src]!</span>")
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	mine_effect(victim)
	qdel(src)

/obj/item/weapon/mine/Crossed(AM as obj|mob)
	if(ismob(AM) && active)
		triggermine(AM)

/obj/item/weapon/mine/claymore
	name = "claymore"
	desc = "A claymore with a similar chip of the smartguns' one, which lets them able to distinguish friends and foes, to a lesser extent."
	icon_state = "claymore"
	item_state = "flashbang"
	var/range_devastation = 0
	var/range_heavy = 1
	var/range_light = 2
	var/range_flash = 3

/obj/item/weapon/mine/claymore/Crossed(AM as mob|obj)
	if(active && isalien(AM))
		triggermine(AM)

/obj/item/weapon/mine/claymore/mine_effect(mob/victim)
	explosion(loc, range_devastation, range_heavy, range_light, range_flash)