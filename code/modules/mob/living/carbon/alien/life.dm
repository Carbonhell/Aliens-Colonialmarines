/mob/living/carbon/alien/Life()
	findQueen()
	checkPheromones()
	if(timerMax && timerGrow < timerMax && client)
		timerGrow++
		if(timerGrow == timerMax)
			src << "<span class='greentext'>You feel ready to evolve...</span>"
	return ..()

/mob/living/carbon/alien/check_breath(datum/gas_mixture/breath)
	if(status_flags & GODMODE)
		return

	if(!breath || (breath.total_moles() == 0))
		//Aliens breathe in vaccuum
		return 0

	var/toxins_used = 0
	var/tox_detect_threshold = 0.02
	var/breath_pressure = (breath.total_moles()*R_IDEAL_GAS_EQUATION*breath.temperature)/BREATH_VOLUME
	var/list/breath_gases = breath.gases

	breath.assert_gases("plasma", "o2")

	//Partial pressure of the toxins in our breath
	var/Toxins_pp = (breath_gases["plasma"][MOLES]/breath.total_moles())*breath_pressure

	if(Toxins_pp > tox_detect_threshold) // Detect toxins in air
		adjustPlasma(breath_gases["plasma"][MOLES]*250)
		throw_alert("alien_tox", /obj/screen/alert/alien_tox)

		toxins_used = breath_gases["plasma"][MOLES]

	else
		clear_alert("alien_tox")

	//Breathe in toxins and out oxygen
	breath_gases["plasma"][MOLES] -= toxins_used
	breath_gases["o2"][MOLES] += toxins_used

	breath.garbage_collect()

	//BREATH TEMPERATURE
	handle_breath_temperature(breath)

/mob/living/carbon/alien/handle_changeling()
	return

/mob/living/carbon/alien/proc/checkPheromones()
	active_pheromones.Cut()
	for(var/mob/living/carbon/C in range(7, src))
		if(C == src)
			continue
		var/obj/item/organ/alien/pheromone/P = C.getorgan(/obj/item/organ/alien/pheromone)
		if(!P)
			continue
		if(P.active && P.pheromone && !(P.pheromone in active_pheromones))
			active_pheromones += P.pheromone