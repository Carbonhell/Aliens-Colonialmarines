/mob/living/carbon/alien/humanoid/emote(act,m_type=1,message = null)

	var/param = null
	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	var/muzzled = is_muzzled()

	switch(act) //Alphabetical please
		if ("growl","growls")
			if (!muzzled)
				message = "<span class='name'>[src]</span> growls."
				if(mob_size == MOB_SIZE_LARGE)
					playsound(loc, 'sound/voice/alien_growl_large.ogg', 30, 1, 1)
				else
					playsound(loc, 'sound/voice/alien_growl_small.ogg', 30, 1, 1)

		if ("gnarl","gnarls")
			if (!muzzled)
				message = "<span class='name'>[src]</span> gnarls and shows its teeth.."
				m_type = 2

		if ("hiss","hisses")
			if(!muzzled)
				message = "<span class='name'>[src]</span> hisses."
				m_type = 2
				if(mob_size == MOB_SIZE_LARGE)
					playsound(loc, 'sound/voice/alien_hiss_large.ogg', 100, 1, 1)
				else
					playsound(loc, 'sound/voice/alien_hiss_small.ogg', 100, 1, 1)

		if ("me")
			..()
			return


		if ("roar","roars")
			if (!muzzled)
				message = "<span class='name'>[src]</span> roars!"
				if(mob_size == MOB_SIZE_LARGE)
					playsound(loc, 'sound/voice/alien_roar_large.ogg', 100, 1, 1)
				else
					playsound(loc, 'sound/voice/alien_roar_small.ogg', 100, 1, 1)
				m_type = 2

		if ("screech","screeches")
			if (!muzzled)
				message = "<span class='name'>[src]</span> screeches."
				m_type = 2

		if ("tail")
			message = "<span class='name'>[src]</span> lashes its tail."
			playsound(loc, 'sound/voice/alien_tail.ogg', 100, 1, 1)
			m_type = 1

		if ("help") //This is an exception
			src << "<br><br><b>To use an emote, type an asterix (*) before a following word. Emotes with a sound are <span style='color: green;'>green</span>. Spamming emotes with sound will likely get you banned. Don't do it.<br><br>\
			dance, \
			<span style='color: green;'>growl</span>, \
			<span style='color: green;'>hiss</span>, \
			me, \
			<span style='color: green;'>roar</span>, \
			<span style='color: green;'>tail</span></b><br>"

	if ((message && src.stat == 0))
		log_emote("[name]/[key] : [message]")

		if (m_type & 1)
			visible_message(message)
		else
			audible_message(message)
	return