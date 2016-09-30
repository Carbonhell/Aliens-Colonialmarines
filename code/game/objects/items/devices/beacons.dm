var/list/existing_beacons = list()//fuck you,i can't think of a better way goddamnit

/obj/item/device/beacon
	name = "standard beacon"
	desc = "A device capable of sending a signal with an internal long-lasting energy cell."
	icon_state = "powersink0"
	item_state = "electronic"
	w_class = 3
	var/on = FALSE
	var/signaltype = "none"
	var/signal = ""//can be a squad
	var/static/global_identifier = 0
	var/identifier//those 2 identifier vars are used to get the right beacon in the supply_drop.dm ui_act proc

/obj/item/device/beacon/New(location, signalvalue = "")
	..()
	global_identifier++
	identifier = global_identifier
	existing_beacons += src
	if(signalvalue)
		signal = signalvalue
	var/datum/squad/S = squadtext2datum(signal)
	if(S)
		S.beacons += src

/obj/item/device/beacon/Destroy()
	var/datum/squad/S = squadtext2datum(signal)
	if(S)
		S.beacons -= src
	existing_beacons -= src
	..()

/obj/item/device/beacon/attack_self(mob/user)
	on = TRUE
	update_icon()
	user << "<span class='notice'>You turn \the [name] [on ? "on" : "off"].</span>"
	user.unEquip(src)
	forceMove(get_turf(user))
	anchored = TRUE

/obj/item/device/beacon/attack_hand(mob/user)
	if(anchored)
		on = FALSE
		user << "<span class='notice'>You turn \the [name] [on ? "on" : "off"].</span>"
		anchored = FALSE
		update_icon()
		return
	..()

/obj/item/device/beacon/update_icon()
	icon_state = "powersink[on]"


//Actual beacons
/obj/item/device/beacon/supply
	name = "supply beacon"
	desc = "A device that sends an encrypted signal to authorized supply drops machines, similar to a GPS."
	signaltype = SUPPLYBEACON

/obj/item/device/beacon/supply/alpha
	signal = "Alpha"

/obj/item/device/beacon/supply/bravo
	signal = "Bravo"

/obj/item/device/beacon/supply/charlie
	signal = "Charlie"

/obj/item/device/beacon/supply/delta
	signal = "Delta"