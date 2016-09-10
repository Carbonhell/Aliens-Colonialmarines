/datum/game_mode
	var/list/survivor_candidates = list()
	var/list/survivors = list()
	//alien list is inside alien.dm
	var/max_surv_amt = 0

/datum/game_mode/colonialmarines
	name = "colonial marines"
	config_tag = "colonial_marines"
	antag_flag = ROLE_ALIEN
	announce_span = "green"
	announce_text = "USCM has been hired by Weyland-Yutani to investigate a distress signal sent by one of their research facilities.\
					Follow your orders and find out what exactly happened down there."
	required_players = 1
	required_enemies = 1
	round_ends_with_antag_death = 1

/datum/game_mode/colonialmarines/can_start()
	var/ready_players = num_players()
	recommended_enemies = min(round(ready_players/5), 10)
	max_surv_amt = min(round(ready_players/7), 10)//might need to move some stuff to pre_setup, we'll see
	if(!..())
		return
	survivor_candidates = get_players_for_role(ROLE_SURVIVOR)//even if this is empty,it's fine.
	return 1

/datum/game_mode/colonialmarines/post_setup()
	for(var/i in antag_candidates)
		var/datum/mind/M = i//less lag than typechecking in the for loop!
		M.make_Alien()//defaults to larva
		M.current << "You are an alien! Reproduce and make a new home out of this place. Speak in the hivemind with :a (Like ':a Hello fellow sisters!')"
	for(var/survy in survivor_candidates)
		if(isemptylist(survivor_spawn))
			break
		var/datum/mind/S = survy
		var/mob/living/carbon/human/H = new(pick(survivor_spawn))
		S.transfer_to(H, 1)
		survivors += H
		survivor_candidates[survy] = H.real_name
		H.equipOutfit(pick(subtypesof(/datum/outfit/survivor)))//random outfit
	..()

/datum/game_mode/colonialmarines/check_finished()
	. = 0
	if(check_aliens())
		.++
	if(check_humans())
		. += 2

/datum/game_mode/colonialmarines/declare_completion()
	var/num_marines_survived = 0
	var/num_aliens_survived = 0
	var/num_marines_escaped = 0
	for(var/i in humans)
		var/mob/living/carbon/human/H = i
		if((H && H.mind && H.client) && !(H in survivors))
			num_marines_survived++
			if(H.onCentcom())
				num_marines_escaped++
	for(var/a in aliens)
		var/mob/living/carbon/alien/A = a
		if(A && A.mind && A.client)
			num_aliens_survived++
	var/winner = check_finished()
	switch(winner)
		if(0)//everybody died,jeez
			if(station_was_nuked)
				feedback_set_details("round_end_result","marine win - minor")
				world << "<FONT size = 3><B>Marines Minor Victory!</B></FONT>"
				world << "<B>The marines have detonated the emergency nuke, clearing out the infestation, although at a great expense.</B>"
			else//the last marine and the last aliens died at the same time,what a coincidence!
				feedback_set_details("round_end_result","marine win - minor")
				world << "<FONT size = 3><B>Marines Minor Victory!</B></FONT>"
				world << "<B>The infestation has been cleared thanks to the brave effort of the marines, who will be remembered forever.</B>"
		if(1)//aliens won
			feedback_set_details("round_end_result","alien win - major")
			world << "<FONT size = 3><B>Aliens Major Victory!</B></FONT>"
			world << "<B>The infestation continues, the human kind is definitely in danger now!</B>"
		if(2)//
			feedback_set_details("round_end_result","marine win - major")
			world << "<FONT size = 3><B>Marines Major Victory!</B></FONT>"
			world << "<B>The infestation has been cleared successfully. Marines, now you can return home!</B>"
		if(3)//both teams are still alive,aka marines evacuated
			feedback_set_details("round_end_result","alien win - minor")
			world << "<FONT size = 3><B>Aliens Minor Victory!</B></FONT>"
			world << "<B>The marines have failed to clear the infestation, the hive can live for another day.</B>"
	world << "[num_marines_survived] marines survived, [num_marines_escaped] managed to escape. [num_aliens_survived] aliens survived."

/datum/game_mode/proc/auto_declare_completion_colonialmarines()
	if(queenckeys.len)
		world << "<FONT size = 3><B>The [queenckeys.len > 1 ? "queens were" : "queen was"]:</b></font>"
		var/queens = ""
		for(var/i in 1 to queenckeys.len)
			queens += queenckeys[i]
			if(i != queenckeys.len)
				queens += " "
		world << queens
	if(survivor_candidates.len)
		world << "<FONT size = 3><B>The [survivor_candidates.len > 1 ? "survivors were" : "survivor was"]:</b></font>"
		var/thesurvies = ""
		for(var/pi in 1 to survivor_candidates.len)
			var/datum/mind/S = survivor_candidates[pi]
			thesurvies += "[S.key] was [survivor_candidates[S]]"
			if(pi != survivor_candidates.len)
				thesurvies += ", "
			else
				thesurvies += "."
		world << thesurvies

/datum/game_mode/colonialmarines/proc/check_aliens()
	. = 1
	for(var/i in aliens)
		var/mob/living/carbon/alien/A = i
		if(A && A.mind && A.client)
			. = 0
			break

/datum/game_mode/colonialmarines/proc/check_humans()
	. = 1
	for(var/i in humans)
		var/mob/living/carbon/human/A = i
		if(A && A.mind && A.client)
			. = 0
			break