//All castes need an evolves_to list in their defines
//Such as evolves_to = list("queen", "sentinel", "boiler")

/obj/effect/proc_holder/alien/evolve
	name = "Evolve"
	desc = "Evolve into a higher form."
	action_icon_state = "alien_evolve"

/obj/effect/proc_holder/alien/evolve/fire(mob/living/carbon/alien/user)
	if(!isalien(user))
		src << "You shouldn't have this."
		return
	if(hardcore)//For WO
		src << "<span class='danger'>You don't feel strong enough to evolve.</span>"
		return
	if(jobban_isbanned(src, ROLE_ALIEN))
		src << "<span class='danger'>You are jobbanned from Aliens and cannot evolve. How did you even become an alien?</span>"
		return
	check_stuff(user)

	var/chosen_caste = input("You are growing into a beautiful alien! It is time to choose a caste.") as null|anything in evolves_to
	if(!caste)
		return
	check_stuff(user)


	var/mob/living/carbon/alien/humanoid/M

	var/list/castepaths = subtypesof(/mob/living/carbon/alien/humanoid)
	for(var/A in castepaths)
		if(chosen_caste == initial(A.caste))
			M = A

	if(!M)
		src << "[chosen_caste] is not a valid caste for [src]! Ahelp this!"
		return

	if(jellyMax) //Does the caste have a jelly timer? Then check it
		if(jellyGrow < jellyMax)
			src << "You must wait to let the royal jelly seep into your lymph. Currently at: [jellyGrow] / [jellyMax]."
			return

	visible_message("<span class='greentext'>\The [src] begins to twist and contort..</b></span>","<span class='greentext'><b>You begin to twist and contort..</b></span>")
	if(do_after(src,25))
		if(!user.can_evolve())
			return//just to be sure nothing changed,might fuck up if 2 praes evolve at the same time otherwise
		M = new(get_turf(src))
		M.setDir(dir)
		if(mind)
			mind.transfer_to(M)
		else
			M.key = key

		if(M.health - getBruteLoss(src) - getFireLoss(src) > 0)
			M.bruteloss = bruteloss //Transfers the damage over.
			M.fireloss = fireloss //Transfers the damage over.
			M.updatehealth()

		M.jellyGrow = 0
		M.middle_mouse_toggle = middle_mouse_toggle
		M.shift_mouse_toggle = shift_mouse_toggle

		drop_l_hand()
		drop_r_hand()
		for(var/atom/movable/A in stomach_contents)
			stomach_contents.Remove(A)
			M.stomach_contents.Add(A)
			A.loc = new_xeno

		new_xeno.visible_message("<span class='greentext'>\The [new_xeno] emerges from the husk of [src].</span>","<span class='greentext'>You emerge in a greater form from the husk of your old body. For the hive!</span>")
		qdel(src)
	else
		src << "<span class='notice'>You quiver, but nothing happens. Hold still while evolving.</span>"

	return

/proc/check_stuff(mob/living/carbon/alien/user)
	if(stat)
		src << "<span class='danger'>You have to be conscious to evolve.</span>"
		return
	if(handcuffed || legcuffed)
		src << "<span class='danger'>The restraints are too restricting to allow you to evolve.</span>"
		return
	if(!evolves_to.len)
		src << "<span class='danger'>You are already the apex of form and function. Go! Spread the hive!</span>"
		return
	if(user.health < user.maxHealth)
		src << "<span class='danger'>You must be at full health to evolve.</span>"
		return
	var/obj/item/organ/alien/plasmavessel/P = user.getorgan(/obj/item/organ/alien/plasmavessel)
	if(P.storedPlasma < P.max_plasma)
		src << "<span class='danger'>Your plasma vessel must be full to evolve.</span>"
		return
	if(!user.can_evolve())
		src << "<span class='danger'>Your queen doesn't want you to evolve yet.</span>"
		return
	return 1