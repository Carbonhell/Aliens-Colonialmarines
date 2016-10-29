//Shit here needs to be moved in the proper files. Consider this Carbonhell Code's Limbo (CCL®)


//Areas
/area/wasteland
	name = "Wasteland"
	icon_state = "cave"

/area/centralriver
	name = "Central River"
	icon_state = "centralriver"
/area/westriver
	name = "Western River"
	icon_state = "westriver"
/area/eastriver
	name = "Eastern River"
	icon_state = "eastriver"
/area/southwestriver
	name = "Southwestern River"
	icon_state = "southwestriver"
/area/southeastriver
	name = "Southeastern River"
	icon_state = "southeastriver"
/area/ruins
	name = "Ruins"
	icon_state = "ruins"

/area/holodeck/alphadeck
	name = "Alpha deck"

/area/planet/emergency/smes1
	name = "Smes room"
	icon_state = "engine_storage"

/area/planet/emergency/smes2
	name = "Smes room 2"
	icon_state = "engine_smes"

/area/planet/storage/tech1
	name = "Tech storage"
	icon_state = "auxstorage"

/area/planet/construction/area1
	name = "Construction"
	icon_state = "construction"

/area/planet/xenolab
	name = "Xenobiology"
	icon_state = "toxmisc"

/area/sulaco/art_store_star
	name = "Storage"
	icon_state = "emergencystorage"

/area/sulaco/alpha
	name = "Alpha"
	icon_state = "alpha"

/area/sulaco/bravo
	name = "Bravo"
	icon_state = "bravo"

/area/sulaco/charlie
	name = "Charlie"
	icon_state = "charlie"

/area/sulaco/delta
	name = "Delta"
	icon_state = "delta"

/area/sulaco/fitness
	name = "Fitness"
	icon_state = "fitness"

/area/sulaco/tcomms
	name = "Comms"
	icon_state = "tcommsatcham"

/area/sulaco/containment
	name = "Containment"
	icon_state = "ass_line"

/area/sulaco/fore_hall
	name = "Fore hall"
	icon_state = "hallC"

/area/sulaco/aft_hall
	name = "Aft Hall"
	icon_state = "hallA"

/area/sulaco/brig
	name = "Brig"
	icon_state = "security"

/area/sulaco/hangar
	name = "Hangar"
	icon_state = "exit"

/area/sulaco/commander
	name = "Commander"
	icon_state = "captain"

/area/sulaco/conference
	name = "Conference"
	icon_state = "conference"

/area/sulaco/research
	name = "R&D"
	icon_state = "medresearch"

/area/sulaco/secure_storage
	name = "Secure Storage"
	icon_state = "storage"

/area/sulaco/cafeteria
	name = "Cafeteria"
	icon_state = "cafeteria"

/area/sulaco/vault
	name = "Vault"
	icon_state = "nuke_storage"

/area/bridge/sulaco

/area/crew_quarters/sulaco

/area/medical/medbay/sulaco

/area/crew_quarters/cafeteria/sulaco

/area/security/armory/sulaco

/area/shuttle/marine/sulaco

/area/quartermaster/storage/sulaco

/area/storage/tools/sulaco

/area/janitor/sulaco

/area/sulaco/engineering
	name = "Engineering"
	icon_state = "engine"

/area/sulaco/engineering/control
	name = "Engineering Control"
	icon_state = "engine_control"

/area/sulaco/engineering/storage
	name = "Engineering Storage"
	icon_state = "engine_storage"

/area/sulaco/engineering/engine
	name = "Supermatter Engine"

/area/sulaco/engineering/chief
	name = "Chief Engineer's Office"
	icon_state = "engine_control"

/area/sulaco/engineering/power
	name = "Power Storage"
	icon_state = "engine_smes"

/area/sulaco/engineering/atmospherics
	name = "Atmospherics"
	icon_state = "atmos"

//Turfs
/turf/open/floor/plating/desert
	name = "Desert"
	baseturf = /turf/open/floor/plating/desert
	icon = 'icons/turf/desert.dmi'
	icon_state = "desert"
	icon_plating = "desert"
	broken_states = list("desert")
	burnt_states = list("desert")
	planetary_atmos = TRUE

/turf/open/floor/plating/desert/initialize()
	..()
	if(prob(85))
		icon_state = "desert"
	else
		if(prob(99))
			icon_state = "desert[rand(1,5)]"
		else
			icon_state = "desert_dug"


	if(prob(1))
		if(prob(50))
			new /obj/effect/overlay/palmtree_l(src)
		else
			new /obj/effect/overlay/palmtree_r(src)

/turf/open/floor/plating/desert/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/open/floor/plating/grass
	name = "Grass"
	baseturf = /turf/open/floor/plating/desert
	icon = 'icons/turf/desert2.dmi'
	icon_state = "grass0"
	icon_plating = "grass0"
	planetary_atmos = TRUE

/turf/open/floor/plating/grass/initialize()
	..()
	if(icon_state == "grass0")
		if(prob(50))
			icon_state = "grass1"

		for(var/obj/O in contents)
			if(O.density)
				return
		if(prob(2))
			var/choice = pick(typesof(/obj/structure/flora/ausbushes))
			new choice(src)
		else if(prob(4))
			var/choice = pick(/obj/structure/flora/rock,/obj/structure/flora/rock/pile)
			new choice(src)
		else if(prob(1))
			overlays += image('icons/turf/desert2.dmi', "misc1", pixel_x = rand(-8,8), pixel_y = rand(-8,8))

/turf/open/floor/plating/grass/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/open/floor/plating/grass/grasscorners
	name = "Grass"
	baseturf = /turf/open/floor/plating/desert
	icon = 'icons/turf/desert2.dmi'
	icon_state = "grasscorners"
	icon_plating = "grass0"

/turf/open/floor/plating/grass/grassdiag
	name = "Grass"
	baseturf = /turf/open/floor/plating/desert
	icon = 'icons/turf/desert2.dmi'
	icon_state = "grassdiag"
	icon_plating = "grass0"

/turf/open/floor/plating/asteroid/snow/gravsnow
	icon_state = "snow_dug"
	icon_plating = "snow_dug"

/turf/open/floor/plating/asteroid/snow/gravsnow/surround
	icon_state = "gravsnow_surround"
	icon_plating = "gravsnow_surround"

/turf/open/floor/plating/asteroid/snow/gravsnow/corner
	icon_state = "gravsnow_corner"
	icon_plating = "gravsnow_corner"

/turf/open/floor/plating/asteroid/snow/gravsnow/corners
	icon_state = "gravsnow_corners"
	icon_plating = "gravsnow_corners"

/turf/open/floor/plating/asteroid/snow/surround
	icon_state = "snow_surround"
	icon_plating = "snow_surround"

/turf/open/floor/plating/asteroid/snow/corner
	icon_state = "snow_corner"
	icon_plating = "snow_corner"

/turf/open/floor/plating/asteroid/snow/corners
	icon_state = "snow_corners"
	icon_plating = "snow_corners"

/turf/open/floor/plating/asteroid/snow/platingdrift
	icon_state = "platingdrift"
	icon_plating = "platingdrift"

/turf/open/floor/plating/beach/beach
	icon_state = "beach"

/turf/open/floor/plating/beach/corner
	icon_state = "beachcorner"

/turf/open/floor/plating/beach/sea
	icon_state = "seashallow"

/turf/closed/mineral/planet
	baseturf = /turf/open/floor/plating/desert
	turf_type = /turf/open/floor/plating/desert

//SERVER
/obj/machinery/telecomms/server/presets/alpha
	id = "Alpha Server"
	network = "sulaconet"
	freq_listening = list(ALPHA_FREQ)
	autolinkers = list("alpha")

/obj/machinery/telecomms/server/presets/bravo
	id = "Bravo Server"
	network = "sulaconet"
	freq_listening = list(BRAVO_FREQ)
	autolinkers = list("bravo")

/obj/machinery/telecomms/server/presets/charlie
	id = "Charlie Server"
	network = "sulaconet"
	freq_listening = list(CHARLIE_FREQ)
	autolinkers = list("charlie")

/obj/machinery/telecomms/server/presets/delta
	id = "Delta Server"
	network = "sulaconet"
	freq_listening = list(DELTA_FREQ)
	autolinkers = list("delta")

//BUS
/obj/machinery/telecomms/bus/preset_alpha
	id = "Bus 1"
	network = "sulaconet"
	freq_listening = list(ALPHA_FREQ, SCI_FREQ, MED_FREQ)
	autolinkers = list("mprocessor1", "alpha", "mscience", "mmedical")

/obj/machinery/telecomms/bus/preset_bravo
	id = "Bus 2"
	network = "sulaconet"
	freq_listening = list(BRAVO_FREQ, SUPP_FREQ, SEC_FREQ)
	autolinkers = list("mprocessor2", "bravo", "msupply", "mpolice")

/obj/machinery/telecomms/bus/preset_charlie
	id = "Bus 3"
	network = "sulaconet"
	freq_listening = list(CHARLIE_FREQ, COMM_FREQ, ENG_FREQ)
	autolinkers = list("mprocessor3", "charlie", "mcommand", "mengineering")

/obj/machinery/telecomms/bus/preset_delta
	id = "Bus 4"
	network = "sulaconet"
	freq_listening = list(DELTA_FREQ)
	autolinkers = list("mprocessor4", "delta", "mcommon")

/obj/machinery/telecomms/bus/preset_delta/New()
	for(var/i in 1441 to 1489 step 2)
		freq_listening |= i
	..()

//Receivers
//--PRESET LEFT--//

/obj/machinery/telecomms/receiver/marine_left
	id = "Receiver A"
	network = "sulaconet"
	autolinkers = list("mreceiverA") // link to relay
	freq_listening = list(ALPHA_FREQ, BRAVO_FREQ, CHARLIE_FREQ, DELTA_FREQ)


//--PRESET RIGHT--//

/obj/machinery/telecomms/receiver/marine_right
	id = "Receiver B"
	network = "sulaconet"
	autolinkers = list("mreceiverB") // link to relay
	freq_listening = list(MED_FREQ, ENG_FREQ, SEC_FREQ, COMM_FREQ, SUPP_FREQ, SCI_FREQ)

/obj/machinery/telecomms/receiver/marine_right/New()
	for(var/i in 1441 to 1489 step 2)
		freq_listening |= i
	..()

//Processor
/obj/machinery/telecomms/processor/preset_one/marine
	id = "Processor 1"
	network = "sulaconet"
	autolinkers = list("mprocessor1")

/obj/machinery/telecomms/processor/preset_two/marine
	id = "Processor 2"
	network = "sulaconet"
	autolinkers = list("mprocessor2")

/obj/machinery/telecomms/processor/preset_three/marine
	id = "Processor 3"
	network = "sulaconet"
	autolinkers = list("mprocessor3")

/obj/machinery/telecomms/processor/preset_four/marine
	id = "Processor 4"
	network = "sulaconet"
	autolinkers = list("mprocessor4")

//Broadcaster
/obj/machinery/telecomms/broadcaster/preset_left/marine
	id = "Marine Broadcaster A"
	network = "sulaconet"
	autolinkers = list("mbroadcasterA")

/obj/machinery/telecomms/broadcaster/preset_right/marine
	id = "Marine Broadcaster A"
	network = "sulaconet"
	autolinkers = list("mbroadcasterA")

//Relay
/obj/machinery/telecomms/relay/preset/marine
	id = "Marine Relay"
	network = "sulaconet"
	listening_level = 1
	autolinkers = list("marine_relay")

/obj/machinery/telecomms/relay/preset/marine/support
	id = "Support Relay"
	autolinkers = list("marine_support_relay")

//Hub
/obj/machinery/telecomms/hub/preset/marine
	id = "Marine Hub"
	network = "sulaconet"
	autolinkers = list("marine_relay", "marine_support_relay", "mscience", "mmedical",
	"alpha", "bravo", "charlie", "delta",
	"msupply", "mcommon", "mcommand", "mengineering", "mpolice",
	"mreceiverA", "mreceiverB", "mbroadcasterA", "mbroadcasterB")

//Servers
/obj/machinery/telecomms/server/presets/mcommand
	id = "Command Server"
	network = "sulaconet"
	freq_listening = list(COMM_FREQ)
	autolinkers = list("mcommand")

/obj/machinery/telecomms/server/presets/mpolice
	id = "Police Server"
	network = "sulaconet"
	freq_listening = list(SEC_FREQ)
	autolinkers = list("mpolice")

/obj/machinery/telecomms/server/presets/mengi
	id = "Engineering Server"
	network = "sulaconet"
	freq_listening = list(ENG_FREQ)
	autolinkers = list("mengineering")

/obj/machinery/telecomms/server/presets/msupply
	id = "Supply Server"
	network = "sulaconet"
	freq_listening = list(SUPP_FREQ)
	autolinkers = list("msupply")

/obj/machinery/telecomms/server/presets/mmedical
	id = "Medical Server"
	network = "sulaconet"
	freq_listening = list(MED_FREQ)
	autolinkers = list("mmedical")

/obj/machinery/telecomms/server/presets/mscience
	id = "Research Server"
	network = "sulaconet"
	freq_listening = list(SCI_FREQ)
	autolinkers = list("mscience")

/obj/machinery/telecomms/server/presets/common/mcommon
	id = "Common Server"
	network = "sulaconet"
	autolinkers = list("mcommon")

//Objects
/obj/structure/displaycase/alien
	name = "Tank"
	icon = 'icons/obj/alien1.dmi'
	icon_state = "tank_empty"
	desc = "A glass lab container for storing interesting creatures."
	density = 1
	anchored = 1
	unacidable = 1
	var/obj/item/clothing/mask/facehugger/occupied

/obj/structure/displaycase/alien/New()
	..()
	if(prob(70))
		occupied = new(src)
	else
		destroyed = 1
	update_icon()

/obj/structure/displaycase/alien/update_icon()
	if(destroyed)
		icon_state = "tank_broken"
	else
		icon_state = "tank_[occupied]"

/obj/structure/displaycase/alien/dump()
	if(occupied)
		occupied.forceMove(get_turf(src))
		occupied = null
	update_icon()

/obj/machinery/vending/marine/ammunition
	name = "weapon rack"
	desc = "Weapons for weapons."
	icon_state = "marinevend"
	req_access_txt = "218"
	products = list(/obj/item/weapon/gun/projectile/automatic/m41a = 4, /obj/item/ammo_box/magazine/m41a = 20,
					/obj/item/weapon/gun/projectile/automatic/m39 = 4, /obj/item/ammo_box/magazine/m39 = 30,
					/obj/item/weapon/gun/projectile/shotgun/automatic/combat/mk221 = 4, /obj/item/ammo_box/magazine/m12g/slug = 10,
					/obj/item/device/flashlight/flare = 6)
	refill_canister = /obj/item/weapon/vending_refill/weapons
	icon_vend = "marinevend-vend"
	icon_deny = "marinevend-deny"

/obj/item/weapon/vending_refill/weapons
	machine_name = "weapon rack"
	icon_state = "refill_weap"
	charges = list(26, 0, 0)
	init_charges = list(26, 0, 0)

/obj/machinery/vending/snack/marine
	name = "MRE storage unit"
	desc = "A food vendor. The food tastes like shit, but it's something, I guess."
	req_access_txt = "218"

/obj/machinery/vending/special//Todo: make an actual different machine to dispense a single specialist kit instead of this coin bs
	name = "specialist vendor"
	desc = "For the real men."
	req_access_txt = "222"
	products = list(/obj/item/weapon/grenade/smokebomb  = 6)
	premium = list(/obj/item/weapon/storage/lockbox/speckit/sadar = 1, /obj/item/weapon/storage/lockbox/speckit/smartgun = 1,
					/obj/item/weapon/storage/lockbox/speckit/sniper = 1)//to be changed with kits filled with ammo aswell.
	refill_canister = /obj/item/weapon/vending_refill/spec

/obj/item/weapon/vending_refill/spec
	machine_name = "specialist vendor"
	icon_state = "refill_spec"
	charges = list(2, 0, 1)
	init_charges = list(2, 0, 1)

/obj/item/weapon/storage/lockbox/speckit
	name = "specialist kit"
	icon_state = "uscmbox-deny"
	req_access = list(access_marine_specprep)
	icon_locked = "uscmbox-deny"
	icon_closed = "uscmbox-allow"
	icon_broken = "uscmbox-emag"

/obj/item/weapon/storage/lockbox/speckit/sadar
	name = "SADAR kit"
	desc = "An huge lockbox containing a SADAR, along with some rockets."

/obj/item/weapon/storage/lockbox/speckit/sadar/New()
	..()
	new /obj/item/weapon/gun/projectile/sadar(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_casing/caseless/rocket(src)

/obj/item/weapon/storage/lockbox/speckit/sniper
	name = "WY102 kit"
	desc = "An huge lockbox containing a WY102 sniper rifle, along with some ammo."

/obj/item/weapon/storage/lockbox/speckit/sniper/New()
	..()
	new /obj/item/weapon/gun/projectile/automatic/sniper_rifle/wy102(src)
	new /obj/item/clothing/suit/armor/vest/marine/sniper(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_box/magazine/sniper_rounds(src)

/obj/item/weapon/storage/lockbox/speckit/smartgun
	name = "M56 smartgun kit"
	desc = "An huge lockbox containing a M56 smartgun system."

/obj/item/weapon/storage/lockbox/speckit/smartgun/New()
	..()
	new /obj/item/weapon/minigunpack/smartgun(src)

/obj/structure/closet/pod_locker
	name = "pod locker"
	desc = "A closet generally used to send supplies at high velocity through space from a ship."
	icon_state = "dropper"

/obj/structure/closet/secure_closet/marine
	name = "standard marine locker"
	req_access = list(access_marine_prep)
	icon_state = "squad"
	var/list/armors = list(/obj/item/clothing/suit/armor/vest/marine, /obj/item/clothing/suit/armor/vest/marine/nolegs, /obj/item/clothing/suit/armor/vest/marine/noshoulders, /obj/item/clothing/suit/armor/vest/marine/nostomach)
	var/list/helmets = list(/obj/item/clothing/head/helmet/marine)
	var/headset = /obj/item/device/radio/headset

/obj/structure/closet/secure_closet/marine/New()
	..()
	new /obj/item/weapon/storage/backpack/explorer(src)
	new /obj/item/weapon/storage/backpack/satchel/explorer(src)
	new /obj/item/clothing/under/rank/marine(src)
	var/armorpath = pick(armors)
	new armorpath(src)
	var/helmetpath = pick(helmets)
	new helmetpath(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/combat(src)
	new headset(src)
	new /obj/item/weapon/storage/belt/military/assault(src)

/obj/structure/closet/secure_closet/marine/alpha
	name = "alpha locker"
	req_access = list(access_squad_alpha)
	icon_state = "squad_alpha"
	headset = /obj/item/device/radio/headset/alpha

/obj/structure/closet/secure_closet/marine/alpha/New()
	..()
	new /obj/item/clothing/tie/armband/squad/alpha(src)

/obj/structure/closet/secure_closet/marine/alpha/engineer
	armors = list(/obj/item/clothing/suit/armor/vest/marine/engineer)

/obj/structure/closet/secure_closet/marine/alpha/medic
	armors = list(/obj/item/clothing/suit/armor/vest/marine/medic)
	helmets = list(/obj/item/clothing/head/helmet/marine/medic)

/obj/structure/closet/secure_closet/marine/alpha/specialist
	helmets = list(/obj/item/clothing/head/helmet/marine/specialist)

/obj/structure/closet/secure_closet/marine/alpha/specialist/New()
	..()
	new /obj/item/weapon/coin/mythril(src)

/obj/structure/closet/secure_closet/marine/alpha/leader
	armors = list(/obj/item/clothing/suit/armor/vest/marine/leader)
	headset = /obj/item/device/radio/headset/alpha/leader

/obj/structure/closet/secure_closet/marine/bravo
	name = "bravo locker"
	req_access = list(access_squad_bravo)
	icon_state = "squad_bravo"
	headset = /obj/item/device/radio/headset/bravo

/obj/structure/closet/secure_closet/marine/bravo/New()
	..()
	new /obj/item/clothing/tie/armband/squad/bravo(src)

/obj/structure/closet/secure_closet/marine/bravo/engineer
	armors = list(/obj/item/clothing/suit/armor/vest/marine/engineer)

/obj/structure/closet/secure_closet/marine/bravo/medic
	armors = list(/obj/item/clothing/suit/armor/vest/marine/medic)
	helmets = list(/obj/item/clothing/head/helmet/marine/medic)

/obj/structure/closet/secure_closet/marine/bravo/specialist
	helmets = list(/obj/item/clothing/head/helmet/marine/specialist)

/obj/structure/closet/secure_closet/marine/bravo/specialist/New()
	..()
	new /obj/item/weapon/coin/mythril(src)

/obj/structure/closet/secure_closet/marine/bravo/leader
	armors = list(/obj/item/clothing/suit/armor/vest/marine/leader)
	headset = /obj/item/device/radio/headset/bravo/leader

/obj/structure/closet/secure_closet/marine/charlie
	name = "charlie locker"
	req_access = list(access_squad_charlie)
	icon_state = "squad_charlie"
	headset = /obj/item/device/radio/headset/charlie

/obj/structure/closet/secure_closet/marine/charlie/New()
	..()
	new /obj/item/clothing/tie/armband/squad/charlie(src)

/obj/structure/closet/secure_closet/marine/charlie/engineer
	armors = list(/obj/item/clothing/suit/armor/vest/marine/engineer)

/obj/structure/closet/secure_closet/marine/charlie/medic
	armors = list(/obj/item/clothing/suit/armor/vest/marine/medic)
	helmets = list(/obj/item/clothing/head/helmet/marine/medic)

/obj/structure/closet/secure_closet/marine/charlie/specialist
	helmets = list(/obj/item/clothing/head/helmet/marine/specialist)

/obj/structure/closet/secure_closet/marine/charlie/specialist/New()
	..()
	new /obj/item/weapon/coin/mythril(src)

/obj/structure/closet/secure_closet/marine/charlie/leader
	armors = list(/obj/item/clothing/suit/armor/vest/marine/leader)
	headset = /obj/item/device/radio/headset/charlie/leader

/obj/structure/closet/secure_closet/marine/delta
	name = "delta locker"
	req_access = list(access_squad_delta)
	icon_state = "squad_delta"
	headset = /obj/item/device/radio/headset/delta

/obj/structure/closet/secure_closet/marine/delta/New()
	..()
	new /obj/item/clothing/tie/armband/squad/delta(src)

/obj/structure/closet/secure_closet/marine/delta/engineer
	armors = list(/obj/item/clothing/suit/armor/vest/marine/engineer)

/obj/structure/closet/secure_closet/marine/delta/medic
	armors = list(/obj/item/clothing/suit/armor/vest/marine/medic)
	helmets = list(/obj/item/clothing/head/helmet/marine/medic)

/obj/structure/closet/secure_closet/marine/delta/specialist
	helmets = list(/obj/item/clothing/head/helmet/marine/specialist)

/obj/structure/closet/secure_closet/marine/delta/specialist/New()
	..()
	new /obj/item/weapon/coin/mythril(src)

/obj/structure/closet/secure_closet/marine/delta/leader
	armors = list(/obj/item/clothing/suit/armor/vest/marine/leader)
	headset = /obj/item/device/radio/headset/delta/leader

/obj/structure/closet/secure_closet/CMO/marine
	name = "combat medic locker"
	desc = "Tear and heal, tear and heal."
	req_access = list(access_sulaco_medbay)

/obj/structure/closet/secure_closet/mp
	name = "military police locker"
	desc = "In space, noone can see you beat that fucker up..."
	req_access = list(access_sulaco_brig)
	icon_state = "sec"

/obj/structure/closet/secure_closet/mp/New()
	..()
	new /obj/item/device/radio/headset/headset_sec/alt(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/head/helmet/marine/police(src)
	new /obj/item/clothing/suit/armor/vest/alt(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/device/assembly/flash/handheld(src)
	new /obj/item/weapon/gun/energy/gun/advtaser(src)
	new /obj/item/weapon/melee/baton/loaded(src)

/obj/structure/closet/secure_closet/commander
	name = "\proper commander's locker"
	req_access = list(access_sulaco_commander)
	icon_state = "cap"

/obj/structure/closet/secure_closet/commander/New()
	..()
	new /obj/item/clothing/suit/hooded/wintercoat/captain(src)
	if(prob(50))
		new /obj/item/weapon/storage/backpack/captain(src)
	else
		new /obj/item/weapon/storage/backpack/satchel/cap(src)
	new /obj/item/clothing/suit/cloak/cap(src)
	new /obj/item/weapon/storage/backpack/dufflebag/captain(src)
	new /obj/item/clothing/head/crown/fancy(src)
	new /obj/item/clothing/suit/captunic(src)
	new /obj/item/clothing/under/captainparade(src)
	new /obj/item/clothing/head/caphat/parade(src)
	new /obj/item/clothing/under/rank/commander(src)
	new /obj/item/weapon/storage/belt/military/army(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace/alt(src)
	new /obj/item/weapon/cartridge/captain(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/weapon/storage/box/silver_ids(src)
	new /obj/item/device/radio/headset/heads/captain/alt(src)
	new /obj/item/device/radio/headset/heads/captain(src)
	new /obj/item/clothing/glasses/sunglasses/gar/supergar(src)
	new /obj/item/clothing/gloves/color/captain(src)
	new /obj/item/weapon/storage/belt/sabre(src)

/obj/item/device/encryptionkey/alpha
	name = "alpha encryption key"
	desc = "An encryption key for a radio headset.  To access the alpha channel, use :q."
	icon_state = "miner_cypherkey"
	channels = list("Alpha" = 1)

/obj/item/device/encryptionkey/alpha/leader
	channels = list("Alpha" = 1, "Command" = 1)
	desc = "An encryption key for a radio headset.  To access the alpha channel, use :q. For command, :c."

/obj/item/device/encryptionkey/bravo
	name = "bravo encryption key"
	desc = "An encryption key for a radio headset.  To access the bravo channel, use :f."
	icon_state = "ce_cypherkey"
	channels = list("Bravo" = 1)

/obj/item/device/encryptionkey/bravo/leader
	channels = list("Bravo" = 1, "Command" = 1)
	desc = "An encryption key for a radio headset.  To access the bravo channel, use :f. For command, :c."

/obj/item/device/encryptionkey/charlie
	name = "charlie encryption key"
	desc = "An encryption key for a radio headset.  To access the charlie channel, use :j."
	icon_state = "sci_cypherkey"
	channels = list("Charlie" = 1)

/obj/item/device/encryptionkey/charlie/leader
	channels = list("Charlie" = 1, "Command" = 1)
	desc = "An encryption key for a radio headset.  To access the charlie channel, use :j. For command, :c."

/obj/item/device/encryptionkey/delta
	name = "delta encryption key"
	desc = "An encryption key for a radio headset.  To access the delta channel, use :d."
	icon_state = "srv_cypherkey"
	channels = list("Delta" = 1)

/obj/item/device/encryptionkey/delta/leader
	channels = list("Delta" = 1, "Command" = 1)
	desc = "An encryption key for a radio headset.  To access the delta channel, use :d. For command, :c."

/obj/item/device/radio/headset/alpha
	name = "alpha radio headset"
	desc = "A headset used by the Alpha team. \nTo access the alpha channel, use :q."
	icon_state = "headset_alpha"
	item_state = "headset_alpha"
	keyslot = new /obj/item/device/encryptionkey/alpha

/obj/item/device/radio/headset/alpha/leader
	desc = "A headset used by the Alpha team. \nTo access the alpha channel, use :q. For command, :c."
	keyslot = new /obj/item/device/encryptionkey/alpha/leader

/obj/item/device/radio/headset/bravo
	name = "bravo radio headset"
	desc = "A headset used by the Bravo team. \nTo access the bravo channel, use :f"
	icon_state = "headset_bravo"
	item_state = "headset_bravo"
	keyslot = new /obj/item/device/encryptionkey/bravo

/obj/item/device/radio/headset/bravo/leader
	desc = "A headset used by the Bravo team. \nTo access the bravo channel, use :f. For command, :c."
	keyslot = new /obj/item/device/encryptionkey/bravo/leader

/obj/item/device/radio/headset/charlie
	name = "charlie radio headset"
	desc = "A headset used by the Charlie team. \nTo access the charlie channel, use :j."
	icon_state = "headset_charlie"
	item_state = "headset_charlie"
	keyslot = new /obj/item/device/encryptionkey/charlie

/obj/item/device/radio/headset/charlie/leader
	desc = "A headset used by the Charlie team. \nTo access the charlie channel, use :j. For command, :c."
	keyslot = new /obj/item/device/encryptionkey/charlie/leader

/obj/item/device/radio/headset/delta
	name = "delta radio headset"
	desc = "A headset used by the Delta team. \nTo access the delta channel, use :d."
	icon_state = "headset_delta"
	item_state = "headset_delta"
	keyslot = new /obj/item/device/encryptionkey/delta

/obj/item/device/radio/headset/delta/leader
	desc = "A headset used by the Delta team. \nTo access the delta channel, use :d. For command, :c."
	keyslot = new /obj/item/device/encryptionkey/delta/leader

/obj/item/weapon/storage/box/explosive_mines
	name = "box of explosive mines"
	desc = "A box filled with explosive mines. Handle with care."

/obj/item/weapon/storage/box/explosive_mines/New()
	..()
	for(var/i in 1 to 5)
		new /obj/effect/mine/explosive(src)


//Alien spawners
/obj/effect/mob_spawn/xenomorph
	mob_type = /mob/living/carbon/alien/larva
	random = TRUE//what does this even do ayyy lmao
	var/keep_organs = FALSE

/obj/effect/mob_spawn/xenomorph/special(mob/living/carbon/alien/xeno)
	if(!keep_organs && isalien(xeno))
		for(var/obj/item/organ/O in xeno.internal_organs)
			O.Remove()
			qdel(O)

/obj/effect/mob_spawn/xenomorph/crusher
	mob_type = /mob/living/carbon/alien/humanoid/big/crusher

/obj/effect/mob_spawn/xenomorph/drone
	mob_type = /mob/living/carbon/alien/humanoid/drone

/obj/effect/mob_spawn/xenomorph/praetorian
	mob_type = /mob/living/carbon/alien/humanoid/big/praetorian

/obj/effect/mob_spawn/xenomorph/ravager
	mob_type = /mob/living/carbon/alien/humanoid/big/ravager

/obj/effect/mob_spawn/xenomorph/sentinel
	mob_type = /mob/living/carbon/alien/humanoid/sentinel

/obj/effect/mob_spawn/xenomorph/warrior
	mob_type = /mob/living/carbon/alien/humanoid/warrior

/obj/effect/mob_spawn/xenomorph/queen
	mob_type = /mob/living/carbon/alien/humanoid/big/queen

/obj/effect/mob_spawn/xenomorph/queen/create(ckey, specialdeath = TRUE)
	..()

/obj/effect/mob_spawn/xenomorph/queen
	mob_type = /mob/living/carbon/alien/humanoid/big/queen

/obj/item/clothing/tie/armband/squad
	item_color = ""

/obj/item/clothing/tie/armband/squad/alpha
	name = "alpha armband"
	desc = "A red armband with the letter A on it."
	icon_state = "alpha"
	item_state = "alpha"

/obj/item/clothing/tie/armband/squad/bravo
	name = "bravo armband"
	desc = "A yellow armband with the letter B on it."
	icon_state = "bravo"
	item_state = "bravo"

/obj/item/clothing/tie/armband/squad/charlie
	name = "charlie armband"
	desc = "A purple armband with the letter C on it."
	icon_state = "charlie"
	item_state = "charlie"

/obj/item/clothing/tie/armband/squad/delta
	name = "delta armband"
	desc = "A blue armband with the letter D on it."
	icon_state = "delta"
	item_state = "delta"

/obj/item/clothing/suit/armor/vest/marine
	name = "M3 pattern personal armor"
	desc = "Standard USCM armor. It's equipped with a toggleable flashlight."
	icon_state = "marine"
	item_state = "marine"
	body_parts_covered = CHEST|GROIN|LEGS
	allowed = list(/obj/item/weapon/gun, /obj/item/ammo_box)
	actions_types = list(/datum/action/item_action/toggle_armor_lamp)
	var/on = FALSE
	var/brightness_on = 4 //luminosity when on
	var/image/lamp

/obj/item/clothing/suit/armor/vest/marine/New()
	..()
	lamp = image(icon = icon, icon_state = "lamp-0")
	add_overlay(lamp, 1)

/obj/item/clothing/suit/armor/vest/marine/ui_action_click(mob/user, actiontype)
	if(actiontype == /datum/action/item_action/toggle_armor_lamp)
		on = !on
		user << "<span class='notice'>You turn the lamp [on ? "on" : "off"].</span>"
		lamp.icon_state = "lamp-[on]"
		cut_overlays()
		add_overlay(lamp, 1)
		user.update_inv_wear_suit()
		if(on)
			user.AddLuminosity(brightness_on)
		else
			user.AddLuminosity(-brightness_on)
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()

/obj/item/clothing/suit/armor/vest/marine/worn_overlays(isinhands = FALSE)
	. = ..()
	if(lamp && !isinhands)
		var/image/tI = image("icon"='icons/mob/suit.dmi', "icon_state"=lamp.icon_state)
		. += tI

/obj/item/clothing/suit/armor/vest/marine/pickup(mob/user)
	..()
	if(on)
		user.AddLuminosity(brightness_on)
		SetLuminosity(0)

/obj/item/clothing/suit/armor/vest/marine/dropped(mob/user)
	..()
	if(on)
		user.AddLuminosity(-brightness_on)
		SetLuminosity(brightness_on)

/obj/item/clothing/suit/armor/vest/marine/item_action_slot_check(slot)
	if(slot == slot_wear_suit)
		return 1

/obj/item/clothing/suit/armor/vest/marine/nolegs
	icon_state = "marine_nolegs"
	item_state = "marine_nolegs"

/obj/item/clothing/suit/armor/vest/marine/noshoulders
	icon_state = "marine_noshoulders"
	item_state = "marine_noshoulders"

/obj/item/clothing/suit/armor/vest/marine/nostomach
	icon_state = "marine_nostomach"
	item_state = "marine_nostomach"

/obj/item/clothing/suit/armor/vest/marine/leader
	name = "M3 pattern leader armor"
	desc = "A slightly modified model of the M3 pattern personal armor. This model has golden stripes."
	icon_state = "marine_leader"
	item_state = "marine_leader"

/obj/item/clothing/suit/armor/vest/marine/engineer
	name = "M3 pattern engineer armor"
	desc = "A slightly modified model of the M3 pattern personal armor. This model has yellow-painted shoulders."
	icon_state = "marine_engineer"
	item_state = "marine_engineer"

/obj/item/clothing/suit/armor/vest/marine/medic
	name = "M3 pattern medic armor"
	desc = "A slightly modified model of the M3 pattern personal armor. This model has white-painted shoulders and a red cross on the center."
	icon_state = "marine_medic"
	item_state = "marine_medic"

/obj/item/clothing/suit/armor/vest/marine/sniper
	name = "M3 pattern sniper armor"
	desc = "A slightly modified model of the M3 pattern personal armor. This model lacks shoulder protection."
	icon_state = "marine_sniper"
	item_state = "marine_sniper"

/obj/item/clothing/suit/armor/vest/marine/police
	name = "M3 pattern police armor"
	desc = "A slightly modified model of the M3 pattern personal armor. This model has is painted in red, and is generally used between military police teams."
	icon_state = "marine_police"
	item_state = "marine_police"

/datum/action/item_action/toggle_armor_lamp
	name = "Toggle Armor Lamp"

/obj/item/clothing/head/helmet/marine
	name = "M10 pattern ballistic helmet"
	desc = "An helmet often used in conjunction with the M3 pattern personal armor."
	icon_state = "marine"
	item_state = "marine"

/obj/item/clothing/head/helmet/marine/medic
	icon_state = "marine_medic"
	item_state = "marine_medic"

/obj/item/clothing/head/helmet/marine/specialist
	icon_state = "marine_spec"
	item_state = "marine_spec"

/obj/item/clothing/head/helmet/marine/police
	name = "military beret"
	desc = "Despite its aspect, it can pack up a bunch of hits like an helmet thanks to kevlar."
	icon_state = "marine_police"
	item_state = "marine_police"

/obj/item/clothing/head/redband
	name = "red band"
	desc = "A normal red band."
	icon_state = "redband"
	item_state = "redband"