/*
Chief Medical Officer
*/
/datum/job/sulcmo
	title = "Chief Medical Officer"
	flag = SULCMO
	department_head = list("Commander")
	department_flag = MEDSCI
	faction = "Marine"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the commander"
	selection_color = "#ffddf0"
	req_admin_notify = 1
	minimal_player_age = 7

	outfit = /datum/outfit/job/sulcmo

	access = list(access_sulaco_CMO, access_sulaco_medbay, access_sulaco_research, access_sulaco_bridge)
	minimal_access = list(access_sulaco_CMO, access_sulaco_medbay, access_sulaco_research, access_sulaco_bridge)

/datum/outfit/job/sulcmo
	name = "Chief Medical Officer"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/device/pda/heads/cmo
	ears = /obj/item/device/radio/headset/heads/cmo
	uniform = /obj/item/clothing/under/rank/chief_medical_officer
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/toggle/labcoat/cmo
	l_hand = /obj/item/weapon/storage/firstaid/regular
	suit_store = /obj/item/device/flashlight/pen
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/medic
	satchel = /obj/item/weapon/storage/backpack/satchel/med
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/med

/*
Medical Doctor
*/
/datum/job/doctor
	title = "Medical Doctor"
	flag = SULDOC
	department_head = list("Chief Medical Officer")
	department_flag = MEDSCI
	faction = "Marine"
	total_positions = 5
	spawn_positions = 3
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"

	outfit = /datum/outfit/job/suldoctor

	access = list(access_sulaco_medbay, access_sulaco_chemistry)
	minimal_access = list(access_sulaco_medbay, access_sulaco_chemistry)

/datum/outfit/job/suldoctor
	name = "Medical Doctor"

	belt = /obj/item/device/pda/medical
	ears = /obj/item/device/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat
	l_hand = /obj/item/weapon/storage/firstaid/regular
	suit_store = /obj/item/device/flashlight/pen

	backpack = /obj/item/weapon/storage/backpack/medic
	satchel = /obj/item/weapon/storage/backpack/satchel/med
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/med

/*
Researcher
*/
/datum/job/researcher
	title = "Researcher"
	flag = SULRES
	department_head = list("Commander")
	department_flag = MEDSCI
	faction = "Marine"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the commander"
	selection_color = "#ffeeff"

	outfit = /datum/outfit/job/researcher

	access = list(access_sulaco_medbay, access_sulaco_research, access_sulaco_chemistry)
	minimal_access = list(access_sulaco_medbay, access_sulaco_research, access_sulaco_chemistry)

/datum/outfit/job/researcher
	name = "Researcher"

	belt = /obj/item/device/pda/toxins
	ears = /obj/item/device/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/scientist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science

	backpack = /obj/item/weapon/storage/backpack/science
	satchel = /obj/item/weapon/storage/backpack/satchel/tox
