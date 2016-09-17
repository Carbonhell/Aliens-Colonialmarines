/*
Squad leader
*/
/datum/job/marine/sqleader
	title = "Squad Leader"
	flag = SQUADLE
	department_head = list("Commander")
	total_positions = 4
	spawn_positions = 4
	supervisors = "the commander and the bridge officers"
	selection_color = "#ffeeee"

	access = list(access_marine_prep, access_marine_leader)
	minimal_access = list(access_marine_prep, access_marine_leader)

/*
Squad engineer
*/
/datum/job/marine/sqengie
	title = "Squad Engineer"
	flag = SQUADEN
	total_positions = 8
	spawn_positions = 8

	access = list(access_marine_prep, access_marine_engprep, access_sulaco_engineering)
	minimal_access = list(access_marine_prep, access_marine_engprep, access_sulaco_engineering)

/*
Squad medic
*/
/datum/job/marine/sqmedic
	title = "Squad Medic"
	flag = SQUADME
	total_positions = 8
	spawn_positions = 8

	access = list(access_marine_prep, access_marine_medprep, access_sulaco_medbay)
	minimal_access = list(access_marine_prep, access_marine_medprep, access_sulaco_medbay)

/*
Squad specialist
*/
/datum/job/marine/sqspc
	title = "Squad Specialist"
	flag = SQUADSP
	total_positions = 8
	spawn_positions = 8

	access = list(access_marine_prep, access_marine_specprep)
	minimal_access = list(access_marine_prep, access_marine_specprep)

/*
Squad marine
*/
/datum/job/marine
	title = "Squad Marine"
	flag = SQUADMA
	department_head = list("Squad Leader")
	department_flag = MARINES
	faction = "Marine"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the squad leader"
	selection_color = "#ffeeee"

	outfit = /datum/outfit/job/marine

	access = list(access_marine_prep)
	minimal_access = list(access_marine_prep)

/datum/outfit/job/marine
	name = "Squad Marine"

/datum/outfit/job/marine/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	assign_to_weakest_squad(H)

/datum/outfit/job/marine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	var/datum/mind/M = H.mind
	if(M)
		var/datum/squad/S = M.squad
		if(S)
			S.set_special_vars(H)