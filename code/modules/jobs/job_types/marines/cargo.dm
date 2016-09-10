/*
Requisitions Officer
*/
/datum/job/ro
	title = "Requisitions Officer"
	flag = REQUI
	department_head = list("Bridge Officer")
	department_flag = COMMAND
	faction = "Marine"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Bridge Officers"
	selection_color = "#d7b088"

	outfit = /datum/outfit/job/ro

	access = list(access_sulaco_maint, access_sulaco_cargo, access_sulaco_bridge)
	minimal_access = list(access_sulaco_maint, access_sulaco_cargo, access_sulaco_bridge)

/datum/outfit/job/ro
	name = "Quartermaster"

	belt = /obj/item/device/pda/quartermaster
	ears = /obj/item/device/radio/headset/headset_cargo
	uniform = /obj/item/clothing/under/rank/cargo
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/weapon/clipboard


/*
Cargo Technician
*/
/datum/job/cargo_tech
	title = "Cargo Technician"
	flag = SULCARG
	department_head = list("Bridge Officer")
	department_flag = ENGI
	faction = "Marine"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the requisitions officer and the bridge officers"
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/cargo_tech

	access = list(access_sulaco_maint, access_sulaco_cargo)
	minimal_access = list(access_sulaco_maint, access_sulaco_cargo)

/datum/outfit/job/cargo_tech
	name = "Cargo Technician"

	belt = /obj/item/device/pda/cargo
	ears = /obj/item/device/radio/headset/headset_cargo
	uniform = /obj/item/clothing/under/rank/cargotech
	backpack_contents = list(/obj/item/device/modular_computer/tablet/preset/cheap=1)

