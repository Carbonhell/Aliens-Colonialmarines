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

/datum/job/captain/get_access()
	return get_all_marine_accesses()


/datum/outfit/job/commander
	name = "Commander"

	id = /obj/item/weapon/card/id/gold
	belt = /obj/item/weapon/storage/belt/marine
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/device/radio/headset/mcom
	gloves = /obj/item/clothing/gloves/marine/techofficer/commander
	uniform =  /obj/item/clothing/under/marine/officer/command
	shoes = /obj/item/clothing/shoes/marinechief/commander
	head = /obj/item/clothing/head/cmberet/tan
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/marinesatchel
	satchel = /obj/item/weapon/storage/backpack/marinesatchel
	dufflebag = /obj/item/weapon/storage/backpack/marinesatchel

/datum/outfit/job/captain/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
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
	return get_all_marine_accesses()


/datum/outfit/job/xo
	name = "Executive Officer"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/weapon/storage/belt/marine/full
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/device/radio/headset/mcom
	uniform =  /obj/item/clothing/under/marine/officer/exec
	shoes = /obj/item/clothing/shoes/marinechief/commander
	head = /obj/item/clothing/head/cmcap
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/marinesatchel
	satchel = /obj/item/weapon/storage/backpack/marinesatchel
	dufflebag = /obj/item/weapon/storage/backpack/marinesatchel

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
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Commander"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 14

	outfit = /datum/outfit/job/bo

	access = list(access_change_ids, access_sulaco_bridge, access_sulaco_brig)
	minimal_access = list(access_change_ids, access_sulaco_bridge, access_sulaco_brig)


/datum/outfit/job/bo
	name = "Bridge Officer"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/weapon/storage/belt/marine/full
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/device/radio/headset/mcom
	uniform =  /obj/item/clothing/under/marine/officer/logistics
	shoes = /obj/item/clothing/shoes/marinechief/commander
	head = /obj/item/clothing/head/cmcap/ro
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/marinesatchel
	satchel = /obj/item/weapon/storage/backpack/marinesatchel
	dufflebag = /obj/item/weapon/storage/backpack/marinesatchel

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

	access = list(access_sulaco_bridge, access_change_ids, access_sulaco_research, access_sulaco_maint)
	minimal_access = list(access_sulaco_bridge, access_change_ids, access_sulaco_research, access_sulaco_maint)


/datum/outfit/job/liaison
	name = "Corporate Liaison"

	id = /obj/item/weapon/card/id/silver
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/device/radio/headset/mcom
	uniform =  /obj/item/clothing/under/liaison_suit
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/satchel
	satchel = /obj/item/weapon/storage/backpack/satchel
	dufflebag = /obj/item/weapon/storage/backpack/satchel

/datum/outfit/job/liaison/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/weapon/implant/mindshield/L = new/obj/item/weapon/implant/mindshield(H)
	L.imp_in = H
	L.implanted = 1
	H.sec_hud_set_implants()