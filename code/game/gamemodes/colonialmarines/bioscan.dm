/proc/xeno_scan()
	var/pInStation = 0
	var/pInPlanet = 0
	for(var/mob/G in player_list)
		var/turf/playerturf = get_turf(G)
		if(playerturf.z == ZLEVEL_STATION && ishuman(G))
			pInStation ++
		else if(playerturf.z == ZLEVEL_PLANET && ishuman(G))
			pInPlanet ++

	var/input = "The number of humans in the Sulaco is [pInStation] and the number of humans in the planet is [pInPlanet]"

	priority_announce(input, null , 'sound/voice/alien_queen_command3.ogg', "BioscanXeno")

/proc/human_scan()
	var/pInStation = 0
	var/pInPlanet = 0
	for(var/mob/G in player_list)
		var/turf/playerturf = get_turf(G)
		if(playerturf.z == ZLEVEL_STATION && isalien(G))
			pInStation ++
		else if(playerturf.z == ZLEVEL_PLANET && isalien(G))
			pInPlanet ++

	var/input = "The Sulacco scanner detects [pInStation] unknows lifeforms in the Sulaco and [pInPlanet] unknow lifeforms in the planet."

	priority_announce(input, null , 'sound/misc/notice1.ogg', "BioscanHuman")



