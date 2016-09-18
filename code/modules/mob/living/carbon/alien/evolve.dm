//All castes need an evolves_to list in their defines
//Such as evolves_to = list("queen", "sentinel", "corroder")

/obj/effect/proc_holder/alien/evolve
	name = "Evolve"
	desc = "Evolve into a higher form."
	action_icon_state = "alien_evolve"

/obj/effect/proc_holder/alien/evolve/fire(mob/living/carbon/alien/user)
	if(!isalien(user))
		user << "You shouldn't have this."
		return
	if(jobban_isbanned(user, ROLE_ALIEN))
		user << "<span class='danger'>You are jobbanned from Aliens and cannot evolve. How did you even become an alien?</span>"
		return
	if(!check_stuff(user))
		return

	var/chosen_caste = input("You are growing into a beautiful alien! It is time to choose a caste.") as null|anything in user.evolves_to
	if(!chosen_caste)
		return
	if(!check_stuff(user))
		return


	var/alien_path

	var/list/castepaths = subtypesof(/mob/living/carbon/alien/humanoid)
	for(var/A in castepaths)
		var/mob/living/carbon/alien/humanoid/ALIUM = A
		if(chosen_caste == initial(ALIUM.caste))
			alien_path = ALIUM

	if(!alien_path)
		user << "[chosen_caste] is not a valid caste for [user]! Ahelp this!"
		return

	if(user.timerMax && chosen_caste != "queen") //Does the caste have a timer? Then check it. Queen-wannabes are exempted from this
		if(user.timerGrow < user.timerMax)
			user << "You must wait to become powerful enough to evolve. Currently at: [user.timerGrow] / [user.timerMax]."
			return

	user.visible_message("<span class='greentext'><b>\The [user] begins to twist and contort..</b></span>","<span class='greentext'><b>You begin to twist and contort..</b></span>")
	if(do_after(user,25))
		if(!user.can_evolve())
			return//just to be sure nothing changed,might fuck up if 2 praes evolve at the same time otherwise
		var/mob/living/carbon/alien/M = new alien_path(get_turf(user))
		M.setDir(dir)
		if(user.mind)
			user.mind.transfer_to(M)
		else
			M.key = user.key

		if(M.health - user.getBruteLoss() - user.getFireLoss() > 0)
			M.bruteloss = user.bruteloss //Transfers the damage over.
			M.fireloss = user.fireloss //Transfers the damage over.
			M.updatehealth()

		user.drop_l_hand()
		user.drop_r_hand()
		for(var/atom/movable/A in user.stomach_contents)
			user.stomach_contents.Remove(A)
			M.stomach_contents.Add(A)
			A.loc = M

		M.visible_message("<span class='greentext'>\The [M] emerges from the husk of [user].</span>","<span class='greentext'>You emerge in a greater form from the husk of your old body. For the hive!</span>")
		qdel(user)
	else
		user << "<span class='notice'>You quiver, but nothing happens. Hold still while evolving.</span>"

	return

/proc/check_stuff(mob/living/carbon/alien/user)
	if(user.stat)
		user << "<span class='danger'>You have to be conscious to evolve.</span>"
		return
	if(user.handcuffed || user.legcuffed)
		user << "<span class='danger'>The restraints are too restricting to allow you to evolve.</span>"
		return
	if(!user.evolves_to.len)
		user << "<span class='danger'>You are already the apex of form and function. Go! Spread the hive!</span>"
		return
	if(user.health < user.maxHealth)
		user << "<span class='danger'>You must be at full health to evolve.</span>"
		return
	var/obj/item/organ/alien/plasmavessel/P = user.getorgan(/obj/item/organ/alien/plasmavessel)
	if(P.storedPlasma < P.max_plasma)
		user << "<span class='danger'>Your plasma vessel must be full to evolve.</span>"
		return
	if(!(user.can_evolve()))
		user << "<span class='danger'>Your queen doesn't want you to evolve yet.</span>"
		return
	return 1