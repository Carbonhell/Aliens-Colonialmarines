/datum/computer_file/program/squadeditor
	filename = "squadeditor"
	filedesc = "Squad Database Access Panel"
	program_icon_state = "hostile"
	extended_desc = "This program connects to the station's protected database and lets you change the squad of the marines listed in the crew roaster."
	required_access = access_sulaco_change_ids
	requires_ntnet = 0
	size = 5
	var/jobs_whitelist = list("Squad Marine", "Squad Engineer", "Squad Medic", "Squad Specialist", "Squad Leader")
	var/list/squad_list = list()

/datum/computer_file/program/squadeditor/New()
	..()
	for(var/S in subtypesof(/datum/squad))
		var/datum/squad/sqd = S
		if(initial(sqd.start_squad))
			squad_list += initial(sqd.name)

/datum/computer_file/program/squadeditor/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, \
									datum/tgui/master_ui = null, datum/ui_state/state = default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "squad_editor", "Squad Database Access Panel", 1000, 400, master_ui, state)
		ui.open()

/datum/computer_file/program/squadeditor/ui_data(mob/user)
	var/list/data = get_header_data()
	var/list/crewmembers = list()
	crewmembers["Unassigned"] = list()//list of unassigned muhreens
	for(var/i in squad_list)
		crewmembers["[i]"] = list()//a list for each squad containing the marines of that squad
	for(var/V in data_core.locked)
		var/datum/data/record/R = V
		var/mob/M = R.fields["reference"]
		if(!M)
			continue
		if(M.mind)
			var/datum/mind/marinemind = M.mind
			if(!(marinemind.assigned_role in jobs_whitelist))
				continue
			var/list/person = list("name", "ref")
			person["name"] = M.real_name
			person["ref"] = "\ref[M]"
			if(marinemind.squad)
				var/datum/squad/marinesquad = marinemind.squad
				crewmembers[marinesquad.name] += list(person)
			else
				crewmembers["Unassigned"] += list(person)


	data["crewmembers"] = crewmembers
	return data

/datum/computer_file/program/squadeditor/ui_act(action, params)
	if(..())
		return 1
	var/mob/M = locate(params["ref"])
	if(!M || !M.mind)
		return
	var/datum/mind/mobmind = M.mind
	var/datum/squad/mobsquad = mobmind.squad
	var/increment = (action == "squadleft") ? -1 : 1
	var/listloc = squad_list.Find(mobsquad ? mobsquad.name : "unassigned")
	var/new_listloc = listloc+increment
	if(new_listloc > squad_list.len)
		new_listloc = 0
	else if(new_listloc < 0)
		new_listloc = squad_list.len-1
	var/newsquad = !new_listloc ? null : squad_list[new_listloc]
	add_to_squad(M, newsquad)
	return 1