/*
Military police
*/
/datum/job/police
	title = "Military Police"
	flag = MPOLICE
	department_head = list("Commander")
	department_flag = COMMAND
	faction = "Marine"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the commander"
	selection_color = "#ffeeee"
	minimal_player_age = 7

	outfit = /datum/outfit/job/mp

	access = list(access_sulaco_brig, access_sulaco_bridge, access_sulaco_maint)
	minimal_access = list(access_sulaco_brig, access_sulaco_bridge, access_sulaco_maint)

/datum/outfit/job/mp
	name = "Military Police"

	belt = /obj/item/device/pda/security
	ears = /obj/item/device/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/sec
	suit = /obj/item/clothing/suit/armor/vest/alt
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/weapon/restraints/handcuffs
	r_pocket = /obj/item/device/assembly/flash/handheld
	suit_store = /obj/item/weapon/gun/energy/gun/advtaser
	backpack_contents = list(/obj/item/weapon/melee/baton/loaded=1)

	backpack = /obj/item/weapon/storage/backpack/security
	satchel = /obj/item/weapon/storage/backpack/satchel/sec
	dufflebag = /obj/item/weapon/storage/backpack/dufflebag/sec
	box = /obj/item/weapon/storage/box/security