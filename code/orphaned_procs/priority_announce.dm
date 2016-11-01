/proc/priority_announce(text, title = "", sound = 'sound/AI/attention.ogg', type)
	if(!text)
		return

	var/announcement

	if(type == "Priority")
		announcement += "<h1 class='alert'>Priority Announcement</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"
	else if(type == "Captain")
		announcement += "<h1 class='alert'>Commander Announces</h1>"
		news_network.SubmitArticle(text, "Commander's Announcement", "Sulaco Announcements", null)

	else if(type =="Xeno") //because players deserve heard admins
		announcement += "<h1 class='alert'>Queen Announces To The Hivemind</h1>"
	else if(type =="BioscanXeno") //because xeno deserve know the tallhosts numbers
		announcement += "<h1 class='alert'>Hivemind Senses</h1>"
	else if(type =="BioscanHuman") //because humans deserve know the fun things numbers
		announcement += "<h1 class='alert'>M.O.T.H.E.R's Scanner Report</h1>"
		news_network.SubmitArticle(text, "M.O.T.H.E.R's Announcement", "Sulaco Announcements", null)

	else
		announcement += "<h1 class='alert'>[command_name()] Update</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"
		if(title == "")
			news_network.SubmitArticle(text, "USCM Update", "Sulaco Announcements", null)
		else
			news_network.SubmitArticle(title + "<br><br>" + text, "USCM", "Sulaco Announcements", null)

	announcement += "<br><span class='alert'>[html_encode(text)]</span><br>"
	announcement += "<br>"

	for(var/mob/M in player_list)
		if(!istype(M,/mob/new_player) && !M.ear_deaf  )
			if(type == "Xeno" || type == "BioscanXeno" && !ishuman(M))
				M << announcement
				if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
					M << sound(sound)
			else
				if(type == "BioscanHuman" && ishuman(M))
					M << announcement
					if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
						M << sound(sound)

/proc/print_command_report(text = "", title = "USCM Update")
	for (var/obj/machinery/computer/communications/C in machines)
		if(!(C.stat & (BROKEN|NOPOWER)) && C.z == ZLEVEL_STATION)
			var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( C.loc )
			P.name = "paper- '[title]'"
			P.info = text
			C.messagetitle.Add("[title]")
			C.messagetext.Add(text)
			P.update_icon()

/proc/minor_announce(message, title = "Attention:", alert)
	if(!message)
		return

	for(var/mob/M in player_list)
		if(!istype(M,/mob/new_player) && !M.ear_deaf && !isalien(M))
			M << "<b><font size = 3><font color = red>[title]</font color><BR>[message]</font size></b><BR>"
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				if(alert)
					M << sound('sound/misc/notice1.ogg')
				else
					M << sound('sound/misc/notice2.ogg')
