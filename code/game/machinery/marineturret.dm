/obj/machinery/porta_turret/syndicate/marine
	name = "machine gun"
	desc = "A smart machine gun capable of avoiding friendly fire and dealing huge amount of damage."
	icon = 'icons/obj/machines/turret.dmi'
	icon_state = "turret-0"
	density = 1
	anchored = 1
	unacidable = 1
	icon = 'icons/obj/structures.dmi'
	icon_state = "machinegun"
	req_one_access = list(access_sulaco_engineering,access_marine_leader)
	faction = "Marine"
	installation = null
	scan_range = 7//viewrange
	health = 200
	var/online = 0 //0=off, 1=on, -1 = empty battery.
	var/dir_lock = 0
	var/manual_override = 0
	var/burst_fire = 0
	var/ammo = 300
	var/max_ammo = 300
	var/obj/item/weapon/stock_parts/cell/cell
	var/mob/living/silicon/pai/pai

/obj/machinery/porta_turret/syndicate/marine/attack_hand(mob/user)
	if(..())
		return
	if(online == -1)
		user << "Nothing happens. It doesn't look like it's functioning - probably needs a new battery."
		return
	if(!anchored)
		user << "It must be anchored to the ground before you can use it."
		return
	var/dat = "<TT><B>Automatic Portable Turret Installation</B></TT><BR><BR>\
				Turn [online ? "<b>ON</b>" : "<A href='?src=\ref[src];op=power'>ON</a>"]/[online ? "<A href='?src=\ref[src];op=power'>OFF</a>" : "<b>OFF</b>"]<br>\
				Current rounds: [ammo]/[max_ammo]<br>\
				Structural Integrity: [round(health * 100 / initial(health))]% <BR>\
				<A href='?src=\ref[src];op=direction'>Direction Cycle Lock:</a> [dir_lock ? "ON, " : "OFF"]"
	if(dir_lock)
		switch(dir)
			if(NORTH)
				dat += "NORTH<BR>"
			if(EAST)
				dat += "EAST<BR>"
			if(SOUTH)
				dat += "SOUTH<BR>"
			if(WEST)
				dat += "WEST<BR>"
	else
		dat += "360 Degree Rotation<br>"
	if(cell)
		dat += "Power Cell: [cell.charge] / [cell.maxcharge]<BR>"
	dat += "<A href='?src=\ref[src];op=burst'>Burst Fire</a>: [burst_fire ? "<b>ON</b>/OFF" : "ON/<b>OFF</b>"]<br>"
	dat += "AI Logic: <A href='?src=\ref[src];op=manual_override'>[manual_override ? "<b>ON</b>" : "OVERRIDE"]</a>"
	user.set_machine(src)
	user << browse(dat, "window=turret;size=300x400")
	onclose(user, "turret")

/obj/machinery/porta_turret/syndicate/marine/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	add_fingerprint(usr)
	switch(href_list["op"])
		if("power")
			if(online == -1)
				return //no cell
			online = !online
			if(online)
				SetLuminosity(7)
			else
				SetLuminosity(0)
			update_icon()
			usr << "<span class='notice'>You turn \the [src] [online ? "on" : "off"].</span>"
			visible_message("<span class='notice'>[src] hums to life and emits several beeps.</span>")
			visible_message("\icon[src] [src] buzzes in a monotone: 'Default systems initiated.'")
		if("direction")
			if(!online)
				return
			dir_lock = !dir_lock
			usr << "<span class='notice'>You turn the direction lock [dir_lock ? "on" : "off"].</span>"
		if("burst")
			if(!online)
				return
			burst_fire = !burst_fire
			usr << "<span class='notice'>You turn the burst fire [burst_fire ? "on" : "off"].</span>"
		if("manual_override")
			if(!online)
				return
			manual_override = !manual_override
			dir_lock = 1//must be on
			usr << "<span class='notice'>You turn the manual override [manual_override ? "on" : "off"].</span>"
	updateUsrDialog()

/obj/machinery/porta_turret/syndicate/marine/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/wrench))
		if(!online)
			..()
		else
			user << "<span class='danger'>Turn it off first!</span>"
	else if(istype(I, /obj/item/weapon/screwdriver))
		if(!online)
			if(cell)
				cell.forceMove(get_turf(user))
				user << "<span class='notice'>You remove \the [cell] from \the [src].</span>"
				cell = null
			else
				user << "<span class='notice'>There's no cell to remove!</span>"
		else
			user << "<span class='danger'>Turn it off first!</span>"
	else if(istype(I, /obj/item/weapon/stock_parts/cell))
		user << "<span class='notice'>You begin inserting \the [I] inside \the [src]...</span>"
		if(do_after(user, 30, target = src))
			I.forceMove(src)
			cell = I
			user << "<span class='notice'>You successfully insert \the [I].</span>"
	else if(istype(I, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/W = I
		if(!W.welding || W.welding == 2)
			return
		W.remove_fuel(1)
		user << "<span class='notice'>You begin repairing \the [src]..."
		playsound(loc, 'sound/items/Welder.ogg', 40, 1)
		if(do_after(user, 20/W.toolspeed, target = src))
			user << "<span class='notice'>You fix some dents on \the [src]."
			health = min(initial(health), health+30)
	else
		..()

/obj/machinery/porta_turret/syndicate/marine/ex_act(severity, target)
	take_damage(60*severity, BRUTE, 0)//a full explosion leaves it with 20 hps

/obj/machinery/porta_turret/syndicate/marine/die()
	..()
	for(var/i in 1 to 6)
		spawn(1)
			var/list/possibledirs = list(NORTH,SOUTH,EAST,WEST) - dir
			dir = pick(possibledirs)
	explosion(get_turf(src), 1, 2, 3, 4)//nice values eh?
	if(src)
		qdel(src)

/obj/machinery/porta_turret/syndicate/marine/assess_perp(mob/living/carbon/human/perp)
	return 0 //the aliens get shot automatically,this is just for actual humans

/obj/machinery/porta_turret/syndicate/marine/target(atom/movable/target)
	if(!dir_lock)
		..()
	else
		if(abs(get_dir(src, target) - dir) in cardinal)
			..()

/obj/machinery/porta_turret/syndicate/marine/process()
	if(!online)
		return
	check_power(0.1)//should be 1 power per sec
	..()

/obj/machinery/porta_turret/syndicate/marine/proc/check_power(power)
	if(!cell || !online || stat)
		on = 0
		return 0

	if(cell.charge - power  <= 0)
		cell.charge = 0
		visible_message("\icon[src] [src] shuts down from lack of power!")
		playsound(src.loc, 'sound/weapons/smg_empty_alarm.ogg', 60, 1)
		online = 0
		update_icon()
		SetLuminosity(0)
		return 0

	cell.charge -= power
	return 1

/obj/machinery/porta_turret/syndicate/marine/update_icon()
	if(stat & BROKEN)
		icon_state = "turret_fallen"
	else if(pai)
		icon_state = "turret_pai"
	else
		icon_state = "turret_[online]"