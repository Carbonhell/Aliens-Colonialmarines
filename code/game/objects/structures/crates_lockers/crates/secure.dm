/obj/structure/closet/crate/secure
	desc = "A secure crate."
	name = "secure crate"
	icon_state = "securecrate"
	secure = 1
	locked = 1
	health = 1000

/obj/structure/closet/crate/secure/update_icon()
	..()
	if(broken)
		add_overlay("securecrateemag")
	else if(locked)
		add_overlay("securecrater")
	else
		add_overlay("securecrateg")

/obj/structure/closet/crate/secure/weapon
	desc = "A secure weapons crate."
	name = "weapons crate"
	icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/plasma
	desc = "A secure plasma crate."
	name = "plasma crate"
	icon_state = "plasmacrate"

/obj/structure/closet/crate/secure/gear
	desc = "A secure gear crate."
	name = "gear crate"
	icon_state = "secgearcrate"

/obj/structure/closet/crate/secure/hydroponics
	desc = "A crate with a lock on it, painted in the scheme of the station's botanists."
	name = "secure hydroponics crate"
	icon_state = "hydrosecurecrate"

/obj/structure/closet/crate/secure/engineering
	desc = "A crate with a lock on it, painted in the scheme of the station's engineers."
	name = "secure engineering crate"
	icon_state = "engi_secure_crate"

/obj/structure/closet/crate/secure/military
	desc = "A military crate."
	name = "secure military crate"
	icon_state = "securemilitary"

/obj/structure/closet/crate/secure/military/update_icon()
	..()
	if(broken)
		add_overlay("securemilitaryemag")
	else if(locked)
		add_overlay("securemilitaryr")
	else
		add_overlay("securemilitaryg")

/obj/structure/closet/crate/secure/military/medical
	name = "medical military crate"
	desc = "A secure military crate with medical supplies."
	icon_state = "medicmilitary"

/obj/structure/closet/crate/secure/military/engineering
	name = "engineering medical crate"
	desc = "A secure military crate with engineering supplies."
	icon_state = "engimilitary"