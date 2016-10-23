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
	required_players = 2
	required_enemies = 1
	var/time_passed_noqueen = 0
	var/force_end = FALSE

/datum/game_mode/colonialmarines/can_start()
	var/ready_players = num_players()
	recommended_enemies = min(Ceiling(ready_players/5), 10)
	max_surv_amt = min(round(ready_players/7), 10)
	if(!..())
		return 0
	survivor_candidates = get_players_for_role(ROLE_SURVIVOR)//even if this is empty,it's fine.
	if(survivor_candidates.len > max_surv_amt)
		survivor_candidates.Cut(max_surv_amt+1)//remove the excess survivors
	return 1

/datum/game_mode/colonialmarines/pre_setup()
	if(isemptylist(antag_candidates))
		return 0
	shuffle(antag_candidates)
	if(antag_candidates.len > recommended_enemies)
		antag_candidates.Cut(recommended_enemies+1)//remove exceed candidates
	for(var/i in antag_candidates)
		var/datum/mind/M = i//less lag than typechecking in the for loop!
		M.make_Alien(spawnpoint = pick(xeno_spawn))//defaults to larva
		M.current << "You are an alien! Reproduce and make a new home out of this place. Speak in the hivemind with :a (Like ':a Hello fellow sisters!')"
		if(islarva(M.current))
			var/mob/living/carbon/alien/larva/L = M.current
			L.amount_grown = L.max_grown
	for(var/survy in survivor_candidates)
		if(isemptylist(survivor_spawn))
			break
		var/datum/mind/S = survy
		if(S.current && !istype(S.current, /mob/new_player))//already got spawned
			continue
		var/mob/living/carbon/human/H = new(pick(survivor_spawn))
		S.transfer_to(H, 1)
		survivors += H
		survivor_candidates[survy] = H.real_name
		H.equipOutfit(pick(subtypesof(/datum/outfit/survivor)))//random outfit
	..()
	return 1

/datum/game_mode/colonialmarines/process()
	var/mob/living/carbon/alien/humanoid/big/queen/Q = locate() in aliens
	if(!Q)
		if(!time_passed_noqueen)//let's set it
			time_passed_noqueen = world.time + 6000
		else
			if(world.time >= time_passed_noqueen)
				force_end = TRUE
	else
		if(time_passed_noqueen)
			time_passed_noqueen = 0//reset the timer

/datum/game_mode/colonialmarines/check_finished()
	. = no_aliens_left() + no_humans_left()
	if(force_end)
		return 2//humans win cause no aliums queens spawned

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

	var/winner = no_aliens_left() + no_humans_left()
	switch(winner)
		if(3)//everybody died,jeez
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
		if(2)//humans won
			feedback_set_details("round_end_result","marine win - major")
			world << "<FONT size = 3><B>Marines Major Victory!</B></FONT>"
			world << "<B>The infestation has been cleared successfully. Marines, now you can return home!</B>"
		if(0)//both teams are still alive,aka marines evacuated
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

/datum/game_mode/colonialmarines/proc/no_aliens_left()
	. = 2
	for(var/i in aliens)
		var/mob/living/carbon/alien/A = i
		if(A && A.mind && A.client)
			. = 0
			break

/datum/game_mode/colonialmarines/proc/no_humans_left()
	. = 1
	for(var/i in humans)
		var/mob/living/carbon/human/H = i
		if(H && H.mind && H.client)
			. = 0
			break

/datum/game_mode/colonialmarines/send_intercept()
	var/intercepttext = "A distress signal has been sent from a Weyland-Yutani colony and you've been sent to deal with the issue. The signal says that there are unknown lifeforms everywhere, then goes static."
	intercepttext += "That's all we know. Gear up and save any survivor, while cleaning this xenomorphic infestation, along with doing what the Liaison asks."
	priority_announce(intercepttext, "Distress signal location reached.", 'sound/AI/intercept.ogg')