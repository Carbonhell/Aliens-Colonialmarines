//Areas
/area/wasteland
	name = "Wasteland"
	icon_state = "cave"

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

/area/sulaco/tcomms
	name = "Comms"
	icon_state = "tcommsatcomp"

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

/area/bridge/sulaco

/area/crew_quarters/sulaco

/area/medical/medbay/sulaco

/area/crew_quarters/cafeteria/sulaco

/area/security/armory/sulaco

/area/shuttle/marine/sulaco

/area/quartermaster/storage/sulaco

/area/storage/tools/sulaco

/area/janitor/sulaco

//Turfs
/turf/open/floor/plating/desert
	name = "Desert"
	baseturf = /turf/open/floor/plating/desert
	icon = 'icons/turf/desert.dmi'
	icon_state = "desert"
	icon_plating = "desert"
	broken_states = list("desert")
	burnt_states = list("desert")

/turf/open/floor/plating/desert/New()
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

/turf/open/floor/plating/grass/New()
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
	autolinkers = list("mprocessor1", "alpha", "science", "medical")

/obj/machinery/telecomms/bus/preset_bravo
	id = "Bus 2"
	network = "sulaconet"
	freq_listening = list(BRAVO_FREQ, SUPP_FREQ, SEC_FREQ)
	autolinkers = list("mprocessor2", "bravo", "supply", "security")

/obj/machinery/telecomms/bus/preset_charlie
	id = "Bus 3"
	network = "sulaconet"
	freq_listening = list(CHARLIE_FREQ, COMM_FREQ, ENG_FREQ)
	autolinkers = list("mprocessor3", "charlie", "command", "engineering")

/obj/machinery/telecomms/bus/preset_delta
	id = "Bus 4"
	network = "sulaconet"
	freq_listening = list(DELTA_FREQ)
	autolinkers = list("mprocessor4", "delta", "common")

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
	freq_listening = list(MED_FREQ, ENG_FREQ, SEC_FREQ, COMM_FREQ, SUPP_FREQ, SCI_FREQ, 1459)//1459 is common


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
	"msupply", "mcommon", "mcommand", "mengineering", "mpolice",
	"mreceiverA", "mreceiverB", "mbroadcasterA", "mbroadcasterB")

//Servers
/obj/machinery/telecomms/server/presets/mcommand
	id = "Command Server"
	freq_listening = list(COMM_FREQ)
	autolinkers = list("mcommand")

/obj/machinery/telecomms/server/presets/mpolice
	id = "Police Server"
	freq_listening = list(SEC_FREQ)
	autolinkers = list("mpolice")

/obj/machinery/telecomms/server/presets/mengi
	id = "Engineering Server"
	freq_listening = list(ENG_FREQ)
	autolinkers = list("mengineering")

/obj/machinery/telecomms/server/presets/msupply
	id = "Supply Server"
	freq_listening = list(SUPP_FREQ)
	autolinkers = list("msupply")

/obj/machinery/telecomms/server/presets/mmedical
	id = "Medical Server"
	freq_listening = list(MED_FREQ)
	autolinkers = list("mmedical")

/obj/machinery/telecomms/server/presets/mscience
	id = "Research Server"
	freq_listening = list(SCI_FREQ)
	autolinkers = list("mscience")

/obj/machinery/telecomms/server/presets/common/mcommon
	id = "Common Server"
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
	var/occupied

/obj/structure/displaycase/alien/New()
	..()
	if(prob(99))
		switch(rand(1,3))
			if(1)
				occupied = "alien"
			if(2)
				occupied = "hugger"
			if(3)
				occupied = "larva"
	else
		destroyed = 1
	update_icon()

/obj/structure/displaycase/alien/update_icon()
	if(destroyed)
		src.icon_state = "tank_broken"
	else
		icon_state = "tank_[occupied]"
	return

/obj/structure/displaycase/alien/proc/Break()
	if(occupied)
		if(occupied == "alien")
			if(prob(1))
				new /mob/living/simple_animal/hostile/alien/queen( src.loc )
			else
				switch(rand(1,3))
					if(1)
						new /mob/living/simple_animal/hostile/alien/drone( src.loc )
					if(2)
						new /mob/living/simple_animal/hostile/alien/sentinel( src.loc )
					if(3)
						new /mob/living/simple_animal/hostile/alien( src.loc )
		else if(occupied == "hugger")
			var/obj/item/clothing/mask/facehugger/A = new /obj/item/clothing/mask/facehugger( src.loc )
			A.name = "Lamarr" //Don't ask >_<
		else if(occupied == "larva")
			new /mob/living/carbon/alien/larva( src.loc )
		occupied = 0
	update_icon()
	return

/obj/structure/displaycase/alien/dump()
	Break()

/obj/machinery/vending/marine/ammunition
	name = "weapon rack"
	desc = "Weapons for weapons."
	icon_state = "liberationstation"
	req_access_txt = "218"
	products = list(/obj/item/weapon/gun/projectile/automatic/wt550 = 4, /obj/item/ammo_box/magazine/wt550m9 = 10,
					/obj/item/weapon/gun/projectile/automatic/pistol = 4, /obj/item/ammo_box/magazine/m10mm = 10,
					/obj/item/weapon/gun/projectile/shotgun/automatic/combat = 4, /obj/item/ammo_box/magazine/m12g/slug = 10)

/obj/machinery/vending/snack/marine
	name = "MRE storage unit"
	desc = "A food vendor. The food tastes like shit, but it's something, I guess."
	req_access_txt = "218"

/obj/machinery/vending/special
	name = "specialist vendor"
	desc = "For the real men."
	req_access_txt = "222"
	products = list()
	premium = list(/obj/item/weapon/gun/projectile/automatic/shotgun/bulldog = 1, /obj/item/weapon/gun/projectile/automatic/l6_saw = 1,
					/obj/item/weapon/gun/projectile/automatic/sniper_rifle = 1)//to be changed with kits filled with ammo aswell.

/obj/structure/closet/secure_closet/security/alpha
	name = "alpha locker"
	req_access = list(access_squad_alpha)
	icon_state = "squad_alpha"

/obj/structure/closet/secure_closet/security/bravo
	name = "bravo locker"
	req_access = list(access_squad_bravo)
	icon_state = "squad_bravo"

/obj/structure/closet/secure_closet/security/charlie
	name = "charlie locker"
	req_access = list(access_squad_charlie)
	icon_state = "squad_charlie"

/obj/structure/closet/secure_closet/security/delta
	name = "delta locker"
	req_access = list(access_squad_delta)
	icon_state = "squad_delta"

/obj/structure/closet/secure_closet/security/marine
	name = "standard marine locker"
	req_access = list(access_marine_prep)
	icon_state = "squad_alpha"

/obj/structure/closet/secure_closet/CMO/marine
	name = "combat medic locker"
	desc = "Tear and heal, tear and heal."

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
	desc = "An encryption key for a radio headset.  To access the bravo channel, use :r."
	icon_state = "ce_cypherkey"
	channels = list("Bravo" = 1)

/obj/item/device/encryptionkey/bravo/leader
	channels = list("Bravo" = 1, "Command" = 1)
	desc = "An encryption key for a radio headset.  To access the bravo channel, use :r. For command, :c."

/obj/item/device/encryptionkey/charlie
	name = "charlie encryption key"
	desc = "An encryption key for a radio headset.  To access the charlie channel, use :t."
	icon_state = "sci_cypherkey"
	channels = list("Charlie" = 1)

/obj/item/device/encryptionkey/charlie/leader
	channels = list("Charlie" = 1, "Command" = 1)
	desc = "An encryption key for a radio headset.  To access the charlie channel, use :t. For command, :c."

/obj/item/device/encryptionkey/delta
	name = "delta encryption key"
	desc = "An encryption key for a radio headset.  To access the delta channel, use :w."
	icon_state = "srv_cypherkey"
	channels = list("Delta" = 1)

/obj/item/device/encryptionkey/delta/leader
	channels = list("Delta" = 1, "Command" = 1)
	desc = "An encryption key for a radio headset.  To access the delta channel, use :w. For command, :c."

/obj/item/device/radio/headset/alpha
	name = "alpha radio headset"
	desc = "A headset used by the Alpha team. \nTo access the alpha channel, use :q."
	icon_state = "sec_headset"
	keyslot = new /obj/item/device/encryptionkey/alpha

/obj/item/device/radio/headset/alpha/leader
	desc = "A headset used by the Alpha team. \nTo access the alpha channel, use :q. For command, :c."
	keyslot = new /obj/item/device/encryptionkey/alpha/leader

/obj/item/device/radio/headset/bravo
	name = "bravo radio headset"
	desc = "A headset used by the Bravo team. \nTo access the bravo channel, use :r"
	icon_state = "eng_headset"
	keyslot = new /obj/item/device/encryptionkey/bravo

/obj/item/device/radio/headset/bravo/leader
	desc = "A headset used by the Bravo team. \nTo access the bravo channel, use :r. For command, :c."
	keyslot = new /obj/item/device/encryptionkey/bravo/leader

/obj/item/device/radio/headset/charlie
	name = "charlie radio headset"
	desc = "A headset used by the Charlie team. \nTo access the charlie channel, use :t."
	icon_state = "sci_headset"
	keyslot = new /obj/item/device/encryptionkey/charlie

/obj/item/device/radio/headset/charlie/leader
	desc = "A headset used by the Charlie team. \nTo access the charlie channel, use :t. For command, :c."
	keyslot = new /obj/item/device/encryptionkey/charlie/leader

/obj/item/device/radio/headset/delta
	name = "delta radio headset"
	desc = "A headset used by the Delta team. \nTo access the delta channel, use :w."
	icon_state = "headset"
	keyslot = new /obj/item/device/encryptionkey/delta

/obj/item/device/radio/headset/delta/leader
	desc = "A headset used by the Delta team. \nTo access the delta channel, use :w. For command, :c."
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