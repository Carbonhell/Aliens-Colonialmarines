/obj/machinery/supply_drop
	name = "supply dropper"
	desc = "A modified mass driver used to shoot crates in a secure shell to make them land on planets without destroying the crate itself, along with its contents."
	icon = 'icons/obj/machines/supply_drop.dmi'
	icon_state = "dropper_open"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER//so you can see closets/crates without altclicking
	speed_process = TRUE//for tgui ui-bar purposes so it's accurate
	var/obj/structure/closet/supply //Yes,not a crate subtype,you can send lockers too...Hehe.
	var/current_delay = 0 //last time a supply drop was sent, a world.time value
	var/delay = 1800 //countdown in deciseconds.
	var/obj/item/device/beacon/current_beacon // current beacon selected for supply drop

/obj/machinery/supply_drop/process()
	if(current_delay < delay)
		current_delay++
	if(current_beacon)
		if(!current_beacon.on)
			current_beacon = null

/obj/machinery/supply_drop/MouseDrop_T(atom/dropping, mob/user)
	if(supply)
		return//already loaded
	if(istype(dropping, /obj/structure/closet))
		load_supply(dropping)
		user << "<span class='notice'>You load \the [dropping.name] inside \the [name].</span>"

/obj/machinery/supply_drop/proc/eject_supply()
	if(!supply)
		return
	supply.forceMove(get_turf(src))
	supply = null
	spawn()
		flick("dropper_opening", src)
	update_icon()

/obj/machinery/supply_drop/proc/load_supply(obj/load)
	if(!istype(load))
		return
	supply = load
	load.forceMove(src)
	spawn()
		flick("dropper_closing", src)
	update_icon()

/obj/machinery/supply_drop/update_icon()
	if(supply)
		icon_state = "dropper_closed"
	else
		icon_state = "dropper_open"

/obj/machinery/supply_drop/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, \
									datum/tgui/master_ui = null, datum/ui_state/state = default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "supply_drop", "Supply Drop", 1000, 400, master_ui, state)
		ui.open()

/obj/machinery/supply_drop/ui_data()
	var/list/data = list()
	if(current_beacon)
		data["current_beacon"] = current_beacon.identifier
	data["squads"] = list()//change this to list squad beacons too bye
	for(var/s in existing_squads)
		var/datum/squad/S = s
		var/list/squadlist = list()
		squadlist["name"] = list(S.name)
		squadlist["beacons"] = list()
		for(var/i in S.beacons)
			var/obj/item/device/beacon/B = i
			if(B.signaltype == SUPPLYBEACON && B.on)
				var/list/beacon_info = list()
				beacon_info["name"] = list(B.name)
				beacon_info["identifier"] = list(B.identifier)
				beacon_info["x"] = list(B.x)
				beacon_info["y"] = list(B.y)
				beacon_info["z"] = list(B.z)
				squadlist["beacons"] += list(beacon_info)
		data["squads"] += list(squadlist)
	data["timer"] = current_delay
	data["max_timer"] = delay
	if(supply)
		data["supply"] = list()
		data["supply"]["name"] = list(supply.name)
		data["supply"]["contents"] = list()
		for(var/i in supply)
			var/obj/item/I = i
			data["supply"]["contents"] += list(I.name)
	return data

/obj/machinery/supply_drop/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("fire")
			if(!supply)
				usr << "<span class='danger'>No supply loaded!</span>"
				return
			if(!current_beacon)
				usr << "<span class='danger'>No beacon found!</span>"
				return
			if(current_delay < delay)
				return//shouldn't even be able to call this,but y'know,exploits man
			var/turf/T = get_turf(current_beacon)
			flick("launching", src)
			current_beacon.visible_message()
			spawn(32)//launching movie time in deciseconds
				supply.forceMove(T)
				for(var/mob/living/L in T)
					L.take_overall_damage(50)
					L.visible_message("<span class='danger'>\The [supply.name] hits [L] at full speed!</span>", "<span class='userdanger'>\The [supply.name] hits you at full speed!</span>")
					L.Weaken(10)
				supply = null
				flick("recharging", src)
				update_icon()
				current_delay = 0
		if("setbeacon")
			for(var/i in existing_beacons)
				var/obj/item/device/beacon/B = i
				if(B.identifier == text2num(params["identifier"]))//why it's a text by default is beyond me. shrug.
					current_beacon = B
					break
		if("eject")
			eject_supply()