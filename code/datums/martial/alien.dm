#define TAIL_IMPALE				"HHDDH"

/datum/martial_art/alien
	name = "Alien combos"
	var/help_text = "You have several combos you can do on other lifeforms. Kill-grab someone and slash them to bite their head with your inner mouth. Perform a slash,slash,tackle,tackle,slash to impale your victim with your tail."


/datum/martial_art/alien/teach(mob/living/carbon/H,make_temporary=0)
	..()
	H.memory += help_text

/datum/martial_art/alien/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(findtext(streak,TAIL_IMPALE))
		streak = ""
		tail_impale(A,D)
		return 1

/datum/martial_art/alien/disarm_act(mob/living/carbon/A, mob/living/carbon/D)
	if(!isalien(D))
		add_to_streak("D",D, A)
		if(check_streak(A,D))
			return 1

/datum/martial_art/alien/harm_act(mob/living/carbon/A, mob/living/carbon/D)
	if(!isalien(D))
		add_to_streak("H",D, A)
		if(A.grab_state == GRAB_KILL)
			head_bite(A, D)
			return 1
		if(check_streak(A,D))
			return 1

/datum/martial_art/alien/grab_act(mob/living/carbon/A, mob/living/carbon/D)
	if(!isalien(D))
		add_to_streak("G",D, A)
		if(check_streak(A,D))
			return 1

/datum/martial_art/alien/proc/head_bite(mob/living/carbon/user, mob/living/carbon/target)
	var/obj/item/bodypart/head/H = locate() in target.bodyparts
	if(!H)
		user << "<span class='danger'>There's no head to stab!</span>"
		return
	user.visible_message("<span class='userdanger'>[user] stabs [target]'s head with his inner mouth!</span>", "<span class='userdanger'>You stab [target]'s head with your inner mouth.</span>")
	target.adjustBruteLoss(100)
	target.adjustBrainLoss(100)
	streak = ""
	if(istype(user))
		user.hud_used.combo_object.update_icon(streak)

/datum/martial_art/alien/proc/tail_impale(mob/living/carbon/user, mob/living/carbon/target)
	var/list/limbs_yacan_dismember = list()
	for(var/i in target.bodyparts)
		var/obj/item/bodypart/B = i
		if(B.body_zone in list("head", "chest"))
			continue
		limbs_yacan_dismember += B.body_zone
	if(isemptylist(limbs_yacan_dismember))
		return
	var/limb_aimed = user.zone_selected
	if(!(limb_aimed in limbs_yacan_dismember))//dismembering head or chest would be too op,let's be honest
		limb_aimed = pick(limbs_yacan_dismember)
	var/obj/item/bodypart/L = target.get_bodypart(limb_aimed)
	if(!L)//the fuck
		return
	user.Beam(target,icon_state="alientail",icon='icons/effects/beam.dmi',time=7, maxdistance=2,beam_type=/obj/effect/ebeam)
	user.visible_message("<span class='warning'>[user] stabs [target]'s [L.name] with his tail and lifts him up!</span>", "<span class='warning'>You stab [target]'s [L.name] with your tail and lift him up!</span>")
	target.pixel_y += 10
	sleep(6)
	if(user && target)
		user.visible_message("<span class='warning'>[user] slams [target] on the floor, causing \the [L.name] to fly off!</span>", "<span class='warning'>You stab lams [target] on the floor, causing \the [L.name] to fly off!</span>")
		target.pixel_y -= 10
		target.Weaken(5)
		L.dismember()
	streak = ""
	if(istype(user))
		user.hud_used.combo_object.update_icon(streak)