//Chief Engineer
/datum/job/sulaco_chief_engineer
	title = "Chief Engineer"
	flag = SULCE
	department_head = list("Commander")
	department_flag = ENGI
	faction = "Marine"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Commander"
	selection_color = "#fff5cc"
	req_admin_notify = 1
	minimal_player_age = 7

	outfit = /datum/outfit/job/sulce

	access = list(access_sulaco_CE, access_sulaco_engineering, access_sulaco_bridge, access_sulaco_maint)
	minimal_access = list(access_sulaco_CE, access_sulaco_engineering, access_sulaco_bridge, access_sulaco_maint)

/datum/outfit/job/sulce
	name = "Chief Engineer"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/weapon/storage/belt/utility/full
	ears = /obj/item/device/radio/headset/mcom
	uniform = /obj/item/clothing/under/marine/officer/ce
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hardhat/white
	gloves = /obj/item/clothing/gloves/color/black/ce
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/industrial
	satchel = /obj/item/weapon/storage/backpack/satchel/eng
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/engineering
	box = /obj/item/weapon/storage/box/engineer



//Engineer
/datum/job/sulaco_engineer
	title = "Engineer"
	flag = SULENG
	department_head = list("Chief Engineer")
	department_flag = ENGI
	faction = "Marine"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Chief Engineer"
	selection_color = "#ffeeaa"
	req_admin_notify = 1
	minimal_player_age = 7

	outfit = /datum/outfit/job/sulengi

	access = list(access_sulaco_engineering, access_sulaco_maint)
	minimal_access = list(access_sulaco_engineering, access_sulaco_maint)

/datum/outfit/job/sulengi
	name = "Engineer"

	belt = /obj/item/weapon/storage/belt/utility/full
	ears = /obj/item/device/radio/headset/mcom
	uniform = /obj/item/clothing/under/rank/engineer
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat
	gloves = /obj/item/clothing/gloves/color/black/ce
	l_pocket = /obj/item/device/pda/engineering

	backpack = /obj/item/weapon/storage/backpack/industrial
	satchel = /obj/item/weapon/storage/backpack/satchel/eng
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/engineering
	box = /obj/item/weapon/storage/box/engineer
	pda_slot = slot_l_store
