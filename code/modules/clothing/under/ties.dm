/obj/item/clothing/tie
	name = "tie"
	desc = "A neosilk clip-on tie."
	icon = 'icons/obj/clothing/ties.dmi'
	icon_state = "bluetie"
	item_state = ""	//no inhands
	item_color = "bluetie"
	slot_flags = 0
	w_class = 2
	var/minimize_when_attached = TRUE // TRUE if shown as a small icon in corner, FALSE if overlayed

/obj/item/clothing/tie/proc/attach(obj/item/clothing/under/U, user)
	if(pockets) // Attach storage to jumpsuit
		if(U.pockets) // storage items conflict
			return 0

		pockets.loc = U
		U.pockets = pockets

	U.hastie = src
	loc = U
	layer = FLOAT_LAYER
	if(minimize_when_attached)
		transform *= 0.5	//halve the size so it doesn't overpower the under
		pixel_x += 8
		pixel_y -= 8
	U.add_overlay(src)

	for(var/armor_type in armor)
		U.armor[armor_type] += armor[armor_type]

	return 1


/obj/item/clothing/tie/proc/detach(obj/item/clothing/under/U, user)
	if(pockets && pockets == U.pockets)
		pockets.loc = src
		U.pockets = null

	for(var/armor_type in armor)
		U.armor[armor_type] -= armor[armor_type]

	if(minimize_when_attached)
		transform *= 2
		pixel_x -= 8
		pixel_y += 8
	layer = initial(layer)
	U.cut_overlays()
	U.hastie = null



/obj/item/clothing/tie/blue
	name = "blue tie"
	icon_state = "bluetie"
	item_color = "bluetie"

/obj/item/clothing/tie/red
	name = "red tie"
	icon_state = "redtie"
	item_color = "redtie"

/obj/item/clothing/tie/black
	name = "black tie"
	icon_state = "blacktie"
	item_color = "blacktie"

/obj/item/clothing/tie/horrible
	name = "horrible tie"
	desc = "A neosilk clip-on tie. This one is disgusting."
	icon_state = "horribletie"
	item_color = "horribletie"

/obj/item/clothing/tie/waistcoat
	name = "waistcoat"
	desc = "For some classy, murderous fun."
	icon_state = "waistcoat"
	item_state = "waistcoat"
	item_color = "waistcoat"
	minimize_when_attached = FALSE

/obj/item/clothing/tie/stethoscope
	name = "stethoscope"
	desc = "An outdated medical apparatus for listening to the sounds of the human body. It also makes you look like you know what you're doing."
	icon_state = "stethoscope"
	item_color = "stethoscope"

/obj/item/clothing/tie/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && isliving(user))
		if(user.a_intent == "help")
			var/body_part = parse_zone(user.zone_selected)
			if(body_part)
				var/their = "their"
				switch(M.gender)
					if(MALE)
						their = "his"
					if(FEMALE)
						their = "her"

				var/sound = "pulse"
				var/sound_strength

				if(M.stat == DEAD || (M.status_flags&FAKEDEATH))
					sound_strength = "cannot hear"
					sound = "anything"
				else
					sound_strength = "hear a weak"
					switch(body_part)
						if("chest")
							if(M.oxyloss < 50)
								sound_strength = "hear a healthy"
							sound = "pulse and respiration"
						if("eyes","mouth")
							sound_strength = "cannot hear"
							sound = "anything"
						else
							sound_strength = "hear a weak"

				user.visible_message("[user] places [src] against [M]'s [body_part] and listens attentively.", "You place [src] against [their] [body_part]. You [sound_strength] [sound].")
				return
	return ..(M,user)

//////////
//Medals//
//////////

/obj/item/clothing/tie/medal
	name = "bronze medal"
	desc = "A bronze medal."
	icon_state = "bronze"
	item_color = "bronze"
	materials = list(MAT_METAL=1000)
	burn_state = FIRE_PROOF

//Pinning medals on people
/obj/item/clothing/tie/medal/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && (user.a_intent == "help"))

		if(M.wear_suit)
			if((M.wear_suit.flags_inv & HIDEJUMPSUIT)) //Check if the jumpsuit is covered
				user << "<span class='warning'>Medals can only be pinned on jumpsuits.</span>"
				return

		if(M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			var/delay = 20
			if(user == M)
				delay = 0
			else
				user.visible_message("[user] is trying to pin [src] on [M]'s chest.", \
									 "<span class='notice'>You try to pin [src] on [M]'s chest.</span>")
			if(do_after(user, delay, target = M))
				if(U.attachTie(src, user, 0)) //Attach it, do not notify the user of the attachment
					if(user == M)
						user << "<span class='notice'>You attach [src] to [U].</span>"
					else
						user.visible_message("[user] pins \the [src] on [M]'s chest.", \
											 "<span class='notice'>You pin \the [src] on [M]'s chest.</span>")

		else user << "<span class='warning'>Medals can only be pinned on jumpsuits!</span>"
	else ..()

/obj/item/clothing/tie/medal/conduct
	name = "distinguished conduct medal"
	desc = "A bronze medal awarded for distinguished conduct. Whilst a great honor, this is the most basic award given by Nanotrasen. It is often awarded by a captain to a member of his crew."

/obj/item/clothing/tie/medal/bronze_heart
	name = "bronze heart medal"
	desc = "A bronze heart-shaped medal awarded for sacrifice. It is often awarded posthumously or for severe injury in the line of duty."
	icon_state = "bronze_heart"

/obj/item/clothing/tie/medal/nobel_science
	name = "nobel sciences award"
	desc = "A bronze medal which represents significant contributions to the field of science or engineering."

/obj/item/clothing/tie/medal/silver
	name = "silver medal"
	desc = "A silver medal."
	icon_state = "silver"
	item_color = "silver"
	materials = list(MAT_SILVER=1000)

/obj/item/clothing/tie/medal/silver/valor
	name = "medal of valor"
	desc = "A silver medal awarded for acts of exceptional valor."

/obj/item/clothing/tie/medal/silver/security
	name = "robust security award"
	desc = "An award for distinguished combat and sacrifice in defence of Nanotrasen's commercial interests. Often awarded to security staff."

/obj/item/clothing/tie/medal/gold
	name = "gold medal"
	desc = "A prestigious golden medal."
	icon_state = "gold"
	item_color = "gold"
	materials = list(MAT_GOLD=1000)

/obj/item/clothing/tie/medal/gold/captain
	name = "medal of captaincy"
	desc = "A golden medal awarded exclusively to those promoted to the rank of captain. It signifies the codified responsibilities of a captain to Nanotrasen, and their undisputable authority over their crew."

/obj/item/clothing/tie/medal/gold/heroism
	name = "medal of exceptional heroism"
	desc = "An extremely rare golden medal awarded only by Centcom. To receive such a medal is the highest honor and as such, very few exist. This medal is almost never awarded to anybody but commanders."

////////////
//Armbands//
////////////

/obj/item/clothing/tie/armband
	name = "red armband"
	desc = "An fancy red armband!"
	icon_state = "redband"
	item_color = "redband"

/obj/item/clothing/tie/armband/deputy
	name = "security deputy armband"
	desc = "An armband, worn by personnel authorized to act as a deputy of station security."

/obj/item/clothing/tie/armband/cargo
	name = "cargo bay guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is brown."
	icon_state = "cargoband"
	item_color = "cargoband"

/obj/item/clothing/tie/armband/engine
	name = "engineering guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is orange with a reflective strip!"
	icon_state = "engieband"
	item_color = "engieband"

/obj/item/clothing/tie/armband/science
	name = "science guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is purple."
	icon_state = "rndband"
	item_color = "rndband"

/obj/item/clothing/tie/armband/hydro
	name = "hydroponics guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is green and blue."
	icon_state = "hydroband"
	item_color = "hydroband"

/obj/item/clothing/tie/armband/med
	name = "medical guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is white."
	icon_state = "medband"
	item_color = "medband"

/obj/item/clothing/tie/armband/medblue
	name = "medical guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is white and blue."
	icon_state = "medblueband"
	item_color = "medblueband"

///////////
//SCARVES//
///////////

/obj/item/clothing/tie/scarf //Default white color, same functionality as beanies.
	name = "white scarf"
	icon_state = "scarf"
	desc = "A stylish scarf. The perfect winter accessory for those with a keen fashion sense, and those who just can't handle a cold breeze on their necks."
	item_color = "scarf"
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/tie/scarf/black
	name = "black scarf"
	icon_state = "scarf"
	color = "#4A4A4B" //Grey but it looks black

/obj/item/clothing/tie/scarf/red
	name = "red scarf"
	icon_state = "scarf"
	color = "#D91414" //Red

/obj/item/clothing/tie/scarf/green
	name = "green scarf"
	icon_state = "scarf"
	color = "#5C9E54" //Green

/obj/item/clothing/tie/scarf/darkblue
	name = "dark blue scarf"
	icon_state = "scarf"
	color = "#1E85BC" //Blue

/obj/item/clothing/tie/scarf/purple
	name = "purple scarf"
	icon_state = "scarf"
	color = "#9557C5" //purple

/obj/item/clothing/tie/scarf/yellow
	name = "yellow scarf"
	icon_state = "scarf"
	color = "#E0C14F" //Yellow

/obj/item/clothing/tie/scarf/orange
	name = "orange scarf"
	icon_state = "scarf"
	color = "#C67A4B" //orange

/obj/item/clothing/tie/scarf/cyan
	name = "cyan scarf"
	icon_state = "scarf"
	color = "#54A3CE" //Cyan


//Striped scarves get their own icons

/obj/item/clothing/tie/scarf/zebra
	name = "zebra scarf"
	icon_state = "zebrascarf"
	item_color = "zebrascarf"

/obj/item/clothing/tie/scarf/christmas
	name = "christmas scarf"
	icon_state = "christmasscarf"
	item_color = "christmasscarf"

//The three following scarves don't have the scarf subtype
//This is because Ian can equip anything from that subtype
//However, these 3 don't have corgi versions of their sprites
/obj/item/clothing/tie/stripedredscarf
	name = "striped red scarf"
	icon_state = "stripedredscarf"
	item_color = "stripedredscarf"

/obj/item/clothing/tie/stripedgreenscarf
	name = "striped green scarf"
	icon_state = "stripedgreenscarf"
	item_color = "stripedgreenscarf"

/obj/item/clothing/tie/stripedbluescarf
	name = "striped blue scarf"
	icon_state = "stripedbluescarf"
	item_color = "stripedbluescarf"

/obj/item/clothing/tie/petcollar //don't really wear this though please c'mon seriously guys
	name = "pet collar"
	desc = "It's for pets. Though you probably could wear it yourself, you'd doubtless be the subject of ridicule."
	icon_state = "petcollar"
	item_color = "petcollar"
	var/tagname = null

/obj/item/clothing/tie/petcollar/attack_self(mob/user)
	tagname = copytext(sanitize(input(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot") as null|text),1,MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

//////////////
//DOPE BLING//
//////////////

/obj/item/clothing/tie/dope_necklace
	name = "gold necklace"
	desc = "Damn, it feels good to be a gangster."
	icon = 'icons/obj/clothing/ties.dmi'
	icon_state = "bling"
	item_color = "bling"

//Here comes the tooth necklace, wanted to keep it in the same area as most under attachments. This seems to be the best place
/obj/item/clothing/tie/necklace
	name = "necklace"
	w_class = 2
	desc = "Can attach teeth to it."
	icon = 'icons/obj/clothing/ties.dmi'
	icon_state = "necklace_red"
	var/list/ornaments = list() //Teeth attached to this.
	var/max_ornaments = 16
	var/updatecolor = "red"
	item_color = "necklace" //Workaround, necklace color won't show up on person but whether or not teeth are on it will

/obj/item/clothing/tie/necklace/New()
	..()
	update_icon()

/obj/item/clothing/tie/necklace/update_icon()
	icon_state = "necklace_[updatecolor]"
	item_color = "necklace"
	overlays.Cut()
	if(ornaments && ornaments.len)
		item_color = "necklace_teeth"
		var/i = 0
		for(var/obj/item/I in ornaments)
			if(i >= 10) break //Too many teeth already, no room to display anymore
			var/image/img = image(icon,src,"o_[I.icon_state]")
			if(img)
				i++
				//X for tooth number N = necklace center X - tooth spacing * tooth count / 2 + tooth spacing * N
				var/necklace_center_x = 14
				var/tooth_spacing = 2
				img.pixel_x = necklace_center_x - tooth_spacing * min(ornaments.len, 10) / 2 + tooth_spacing * i
				//TODO: Make below if checks a single calculation like pixel_x
				if(img.pixel_x < 11 || img.pixel_x > 19)
					img.pixel_y += 1
				if(img.pixel_x < 9 || img.pixel_x > 21)
					img.pixel_y += 1
				if(img.pixel_x < 8 || img.pixel_x > 22)
					img.pixel_y += 1

				overlays += img

/obj/item/clothing/tie/necklace/examine(mob/user)
	..()
	user << "It contains:"
	for(var/obj/item/I in ornaments)
		var/getname = I.name
		if(istype(I, /obj/item/stack))
			var/obj/item/stack/S = I
			getname = S.singular_name
		user << "\icon[I] \a [getname]"

/obj/item/clothing/tie/necklace/attack_self(mob/user)
	if(ornaments.len)
		user << "You shuffle the ornaments on the necklace."
		ornaments = shuffle(ornaments)
		update_icon()

/obj/item/clothing/tie/necklace/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/weapon/wirecutters))
		new /obj/item/stack/cable_coil(user.loc, 4, updatecolor)
		for(var/obj/item/I in ornaments)
			I.loc = user.loc
		user << "You cut the necklace."
		qdel(src)
		return
	if(istype(W, /obj/item/stack/teeth))
		if(ornaments.len >= max_ornaments)
			user << "There's no room for \the [src]!"
			return
		var/obj/item/stack/teeth/O = W
		var/obj/item/stack/teeth/T = new O.type(user, 1)
		T.copy_evidences(src)
		T.add_fingerprint(user)
		ornaments += T
		T.loc = src
		O.use(1) //Take some teeth from the teeth stack
		update_icon()
		user << "You add one [T] to \the [src]."

/obj/item/stack/teeth/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/stack/cable_coil))
		src.add_fingerprint(user)
		var/obj/item/stack/cable_coil/C = W
		if(C.amount < 4)
			usr << "<span class='danger'>You need at least 4 lengths to make a necklace!</span>"
			return
		var/obj/item/clothing/tie/necklace/N = new (usr.loc)
		N.updatecolor = C.item_color
		var/obj/item/stack/teeth/T = new src.type(user, 1)
		T.copy_evidences(src)
		T.add_fingerprint(user)
		src.use(1) //Take some teeth from the teeth stack
		N.ornaments += T
		T.loc = N
		N.update_icon()
		C.use(4) //Take some cables
	else
		..()

////////////////
//OONGA BOONGA//
////////////////

/obj/item/clothing/tie/talisman
	name = "bone talisman"
	desc = "A hunter's talisman, some say the old gods smile on those who wear it."
	icon_state = "talisman"
	item_color = "talisman"
	armor = list(melee = 5, bullet = 5, laser = 5, energy = 5, bomb = 20, bio = 20, rad = 5) //Faith is the best armor.
