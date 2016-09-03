//==========================//ACCESSORIES\\==============================\\
//=======================================================================\\

/*Things like backpacks and belts should go in here. You know the drill.*/

//=======================================================================\\
//=======================================================================\\

//==========================//BACKPACKS\\================================\\
//=======================================================================\\

/obj/item/weapon/storage/backpack/marine
	name = "\improper USCM infantry backpack"
	desc = "The standard-issue backpack of the USCM forces."
	icon_state = "marinepack"
	item_state = "backpack"
	max_w_class = 3    //  Largest item that can be placed into the backpack
	max_combined_w_class = 21   //Capacity of the backpack

/obj/item/weapon/storage/backpack/marine/medic
	name = "\improper USCM medic backpack"
	desc = "The standard-issue backpack worn by USCM Medics."
	icon_state = "marinepack-medic"
	item_state = "marinepack-medic"

/obj/item/weapon/storage/backpack/marine/tech
	name = "\improper USCM technician backpack"
	desc = "The standard-issue backpack worn by USCM Technicians."
	icon_state = "marinepack-tech"
	item_state = "marinepack-tech"

/obj/item/weapon/storage/backpack/marine/smock
	name = "sniper's smock"
	desc = "A specially designed smock with pockets for all your sniper needs."
	icon_state = "smock"
	item_state = "smock"

/obj/item/weapon/storage/backpack/marinesatchel
	name = "\improper USCM infantry satchel"
	desc = "A heavy-duty satchel carried by some USCM soldiers."
	icon_state = "marinepack2"
	item_state = "marinepack2"

/obj/item/weapon/storage/backpack/marinesatchel/medic
	name = "\improper USCM medic satchel"
	desc = "A heavy-duty satchel carried by some USCM Medics."
	icon_state = "marinepack-medic2"
	item_state = "marinepack-medic"

/obj/item/weapon/storage/backpack/marinesatchel/tech
	name = "\improper USCM technician satchel"
	desc = "A heavy-duty satchel carried by some USCM Technicians."
	icon_state = "marinepack-tech2"
	item_state = "marinepack-tech2"

/obj/item/weapon/storage/backpack/marinesatchel/commando
	name = "\improper commando bag"
	desc = "A heavy-duty bag carried by Weyland Yutani Commandos."
	icon_state = "marinepack-tech3"
	item_state = "marinepack-tech3"

/obj/item/weapon/storage/backpack/mcommander
	name = "marine commander backpack"
	desc = "The contents of this backpack are top secret."
	icon_state = "marinepack"
	item_state = "marinepack" //Placeholder

//============================//BELTS\\==================================\\
//=======================================================================\\

/obj/item/weapon/storage/belt/holster/pistolbelt
	name = "pistol belt"
	desc = "A belt-holster assembly that allows one to hold a pistol and two magazines."
	icon_state = "marinebelt"

/obj/item/weapon/storage/belt/gun/m4a3
	name = "m4a3 duty belt"
	desc = "A belt-holster assembly that allows one to carry the m4a3 comfortably secure with two magazines of ammunition."
	icon_state = "M4A3_holster_0"
	max_combined_w_class = 5
	can_hold = list(
		/obj/item/weapon/gun/pistol/m4a3,
		/obj/item/ammo_magazine/pistol
		)

//Probably want to remove the gun from the marine belt.
/obj/item/weapon/storage/belt/marine
	name = "m276 load belt"
	desc = "A standard issue toolbelt for USCM military forces. Put your ammo in here."
	icon_state = "marinebelt"
	item_state = "marine"//Could likely use a better one.
	w_class = 4
	max_combined_w_class = 9
	can_hold = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/combat_knife,
		/obj/item/device/flashlight/flare,
		/obj/item/device/flash,
		/obj/item/ammo_magazine,
		/obj/item/flareround_s,
		/obj/item/flareround_sp,
		/obj/item/weapon/grenade,
		/obj/item/device/mine
		)

/obj/item/weapon/storage/belt/marine/full/New()
	..()
	new /obj/item/weapon/gun/pistol/m4a3(src)
	new /obj/item/ammo_magazine/pistol(src)

/obj/item/weapon/storage/belt/security/MP
	name = "\improper MP belt"
	desc = "Can hold Military Police Equipment."
	icon_state = "securitybelt"
	item_state = "security"//Could likely use a better one.
	max_w_class = 3
	max_combined_w_class = 20
	can_hold = list(
		/obj/item/weapon/grenade/flashbang,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash,
		/obj/item/clothing/glasses,
		/obj/item/weapon/gun/taser,
		/obj/item/weapon/gun/pistol,
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/handcuffs,
		/obj/item/weapon/combat_knife,
		/obj/item/device/flashlight/flare,
		/obj/item/ammo_magazine,
		/obj/item/weapon/reagent_containers/food/snacks/donut,
		/obj/item/clothing/glasses/hud/security,
		/obj/item/taperoll/police
		)

/obj/item/weapon/storage/belt/security/MP/full/New()
	..()
	new /obj/item/weapon/gun/taser(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/melee/baton(src)
	new /obj/item/weapon/handcuffs(src)

/obj/item/weapon/storage/belt/knifepouch
	name = "knife rig"
	desc = "Storage for your sharp toys"
	icon_state = "securitybelt"
	item_state = "security"
	w_class = 3
	max_w_class = 1
	max_combined_w_class=10

/obj/item/weapon/storage/belt/knifepouch/New()
	..()
	for(var/i in 1 to max_combined_w_class/max_w_class)
		new /obj/item/weapon/throwing_knife(src)

	can_hold = list(/obj/item/weapon/throwing_knife)

/obj/item/weapon/storage/belt/grenade
	name = "grenade bandolier"
	desc = "Storage for your exploding toys."
	icon_state = "grenadebelt"
	item_state="security"
	w_class = 4
	max_w_class = 3
	max_combined_w_class = 24

	can_hold = list(/obj/item/weapon/grenade)

/obj/item/weapon/storage/belt/grenade/New()
	..()
	for(var/i in 1 to max_combined_w_class/max_w_class)
		new /obj/item/weapon/grenade/incendiary(src)
		new /obj/item/weapon/grenade/explosive(src)

//============================//GOGGLES\\================================\\
//=======================================================================\\

/obj/item/clothing/glasses/night/m56_goggles
	name = "\improper M56 head mounted sight"
	desc = "A headset and goggles system for the M56 Smartgun. Has a low-res short range imager, allowing for view of terrain."
	icon = 'icons/Marine/marine_armor.dmi'
	icon_state = "m56_goggles"
	item_state = "glasses"
	darkness_view = 5

/obj/item/clothing/glasses/meson/m42_goggles
	name = "\improper M42 scout sight"
	desc = "A headset and goggles system for the M42 Scout Rifle. Allows highlighted imaging of surroundings. Click it to toggle."
	icon = 'icons/Marine/marine_armor.dmi'
	icon_state = "m56_goggles"
	item_state = "m56_goggles"