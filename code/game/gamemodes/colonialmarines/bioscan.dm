/proc/xeno_scan()
	var/pInStation = 0
	var/pInPlanet = 0
	for(var/G in humans)
		var/mob/living/carbon/human/H = G
		if(H.z == ZLEVEL_STATION)
			pInStation ++
		else if(H.z == ZLEVEL_PLANET)
			pInPlanet ++

	var/input = "The number of humans in the Sulaco is [pInStation] and the number of humans in the planet is [pInPlanet]"

	priority_announce(input, null , 'sound/voice/alien_queen_command3.ogg', "BioscanXeno")

/proc/human_scan()
	var/pInStation = 0
	var/pInPlanet = 0
	for(var/G in aliens)
		var/mob/living/carbon/alien/H = G
		if(H.z == ZLEVEL_STATION)
			pInStation ++
		else if(H.z == ZLEVEL_PLANET)
			pInPlanet ++

	var/input = "The Sulacco scanner detects [pInStation] unknows lifeforms in the Sulaco and [pInPlanet] unknows lifeforms in the planet."

	priority_announce(input, null , 'sound/misc/notice1.ogg', "BioscanHuman")





