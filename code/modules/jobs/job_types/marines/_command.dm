//Commander
/datum/job/commander
	title = "Commander"
	flag = COMMANDER
	department_head = list("USCM")
	department_flag = COMMAND
	faction = "Marine"
	total_positions = 1
	spawn_positions = 1
	supervisors = "USCM and Weyland-Yutani"
	selection_color = "#ccccff"
	req_admin_notify = 1
	minimal_player_age = 14

	outfit = /datum/outfit/job/commander

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

/datum/job/commander/get_access()
	return get_all_marine_accesses()


/datum/outfit/job/commander
	name = "Commander"

	id = /obj/item/weapon/card/id/gold
	belt = /obj/item/weapon/storage/belt/military/army
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/device/radio/headset/heads/captain/alt
	gloves = /obj/item/clothing/gloves/color/captain
	uniform =  /obj/item/clothing/under/rank/captain
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/caphat
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/captain
	satchel = /obj/item/weapon/storage/backpack/satchel/cap
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/captain

/datum/outfit/job/commander/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	var/obj/item/clothing/under/U = H.w_uniform
	U.attachTie(new /obj/item/clothing/tie/medal/gold/captain())

	if(visualsOnly)
		return

	var/obj/item/weapon/implant/mindshield/L = new/obj/item/weapon/implant/mindshield(H)
	L.imp_in = H
	L.implanted = 1
	H.sec_hud_set_implants()

	minor_announce("Commander [H.real_name] on deck!")


//Executive Officer
/datum/job/xo
	title = "Executive Officer"
	flag = EXECUTIVE
	department_head = list("Commander")
	department_flag = COMMAND
	faction = "Marine"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Commander"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 14

	outfit = /datum/outfit/job/xo

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

/datum/job/xo/get_access()
	return get_all_marine_accesses() - access_sulaco_commander


/datum/outfit/job/xo
	name = "Executive Officer"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/device/pda/heads/hop
	ears = /obj/item/device/radio/headset/heads/hop
	uniform = /obj/item/clothing/under/rank/head_of_personnel
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hopcap
	backpack_contents = list(/obj/item/weapon/storage/box/ids=1,\
		/obj/item/weapon/melee/classic_baton/telescopic=1, /obj/item/device/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/xo/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/weapon/implant/mindshield/L = new/obj/item/weapon/implant/mindshield(H)
	L.imp_in = H
	L.implanted = 1
	H.sec_hud_set_implants()


//Bridge Officers
/datum/job/bo
	title = "Bridge Officer"
	flag = BRIDGE
	department_head = list("Commander")
	department_flag = COMMAND
	faction = "Marine"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Commander"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 14

	outfit = /datum/outfit/job/bo

	access = list(access_sulaco_change_ids, access_sulaco_bridge, access_sulaco_brig)
	minimal_access = list(access_change_ids, access_sulaco_bridge, access_sulaco_brig)

/datum/outfit/job/bo
	name = "Bridge Officer"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/device/pda/heads/hop
	ears = /obj/item/device/radio/headset/heads/hop
	uniform = /obj/item/clothing/under/bo
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hopcap
	backpack_contents = list(/obj/item/weapon/storage/box/ids=1,\
		/obj/item/weapon/melee/classic_baton/telescopic=1, /obj/item/device/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/bo/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/weapon/implant/mindshield/L = new/obj/item/weapon/implant/mindshield(H)
	L.imp_in = H
	L.implanted = 1
	H.sec_hud_set_implants()


//Liaison
/datum/job/liaison
	title = "Corporate Liaison"
	flag = LIAISON
	department_head = list("Commander")
	department_flag = COMMAND
	faction = "Marine"
	total_positions = 1
	spawn_positions = 1
	supervisors = "your Corporate Overlords"
	selection_color = "#ffeedd"
	req_admin_notify = 1
	minimal_player_age = 14

	outfit = /datum/outfit/job/liaison

	access = list(access_sulaco_bridge, access_sulaco_change_ids, access_sulaco_research, access_sulaco_maint)
	minimal_access = list(access_sulaco_bridge, access_sulaco_change_ids, access_sulaco_research, access_sulaco_maint)


/datum/outfit/job/liaison
	name = "Corporate Liaison"

	uniform = /obj/item/clothing/under/rank/centcom_officer
	shoes = /obj/item/clothing/shoes/sneakers/black
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/device/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/weapon/pen
	back = /obj/item/weapon/storage/backpack/satchel
	r_pocket = /obj/item/device/pda/heads
	l_hand = /obj/item/weapon/clipboard

/datum/outfit/job/liaison/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/weapon/implant/mindshield/L = new/obj/item/weapon/implant/mindshield(H)
	L.imp_in = H
	L.implanted = 1
	H.sec_hud_set_implants()

/obj/item/clothing/under/bo//PLACEHOLDER
	name = "bridge officer's uniform"
	desc = "A nice uniform, which appears to be kept pretty clean."
	icon = 'icons/uniformmarine.dmi'
	lefthand_file = 'icons/uniformmarine.dmi'
	righthand_file = 'icons/uniformmarine.dmi'
	icon_state = "BO_jumpsuit_s"