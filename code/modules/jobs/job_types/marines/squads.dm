//Datumized squads, linked to the mobs mind. 1 squad per squadtype, and minds get a reference to them
var/list/existing_squads = list()

/datum/squad
	var/name = "Squad name"
	var/list/squad_comrades = list()							//list of the current squad members minds, should not be edited
	var/list/special_access = list()							//eventual extra access, such as the main four squad's prep rooms
	var/radio_frequency	    = 1491								//radio frequency
	var/list/orders			= list()							//list of orders given by Command. There can be as many as command wants.
	var/start_squad 		= FALSE								//Is this a roundstart squad(alpha,bravo,charlie,delta)
	var/list/beacons		= list()							//list of supply beacons. May include other types of beacons such as orbital strike ones in the future.
	var/list/rank_limits	= list("Squad Leader" = 1,			//list of rank limits. for example,this squad can have only 1 specialist, etc.
									"Squad Engineer" = 2,
									"Squad Medic" = 2,
									"Squad Specialist" = 1)

/datum/squad/New()
	..()
	existing_squads += src

/datum/squad/Destroy()//shouldn't happen
	existing_squads -= src
	..()

/datum/squad/alpha
	name = "Alpha"
	special_access = list(access_squad_alpha)
	radio_frequency = 1235
	start_squad = TRUE

/datum/squad/bravo
	name = "Bravo"
	special_access = list(access_squad_bravo)
	radio_frequency = 1245
	start_squad = TRUE

/datum/squad/charlie
	name = "Charlie"
	special_access = list(access_squad_charlie)
	radio_frequency = 1255
	start_squad = TRUE

/datum/squad/delta
	name = "Delta"
	special_access = list(access_squad_delta)
	radio_frequency = 1265
	start_squad = TRUE

/datum/squad/proc/set_special_vars(mob/living/carbon/human/user)
	if(!istype(user))//why are you passing a nonhuman to this proc?
		return
	user.job = "[name] [user.job]"//adds the squadname to the start of the job
	var/obj/item/device/radio/headset/radio = user.ears
	if(radio)
		radio.frequency = radio_frequency
	var/obj/item/weapon/card/id/C = user.wear_id
	if(C)
		C.access += special_access
		C.assignment = user.job//adds the squad bit to the id
		C.update_label()

/proc/assign_to_weakest_squad(mob/user)
	var/datum/squad/S
	for(var/i in existing_squads)
		var/datum/squad/check = i
		if(S)
			if(S.squad_comrades.len > check.squad_comrades.len)
				if(user.job in check.rank_limits)
					if(check.rank_limits[user.job] <= 0)
						continue
					check.rank_limits[user.job]--
				S = check
		else
			if(user.job in check.rank_limits)
				if(check.rank_limits[user.job] <= 0)
					continue
			S = check
	if(S)
		add_to_squad(user, S.name)
		return 1
	else
		return 0//Okay,this shouldn't happen if you set the jobs limits correctly,but if this even happens,you'll just lack a squad.

/proc/add_to_squad(mob/user, squadname)//squad is the squad name
	if(user.mind)
		var/datum/mind/M = user.mind
		if(M.squad)
			var/datum/squad/oldsquad = M.squad
			oldsquad.squad_comrades -= M
		var/datum/squad/newsquad = squadtext2datum(squadname)
		if(!newsquad)
			M.squad = null
			return
		newsquad.squad_comrades += M
		M.squad = newsquad

/proc/squadtext2datum(name)
	for(var/i in existing_squads)
		var/datum/squad/S = i
		if(S.name == name)
			return S
