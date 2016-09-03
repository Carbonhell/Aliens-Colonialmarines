//helmets
/obj/item/clothing/head/helmet/augment
	name = "augment array"
	desc = "A helmet with optical and cranial augments coupled to it."
	icon_state = "v62"
	item_state = "v62"
	armor = list(melee = 80, bullet = 60, laser = 50, energy = 25, bomb = 50, bio = 10, rad = 0)
	siemens_coefficient = 0.5
	anti_hug = 3

//===========================//MARINES\\=================================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/specrag
	name = "specialist head-rag"
	desc = "A hat worn by heavy-weapons operators to block sweat."
	icon = 'icons/Marine/marine_armor.dmi'
	icon_override = 'icons/Marine/marine_armor.dmi'
	icon_state = "spec"
	item_state = "spec"
	armor = list(melee = 35, bullet = 35, laser = 35, energy = 15, bomb = 10, bio = 0, rad = 0)
	flags_inv = HIDEEARS | HIDEHAIR

/obj/item/clothing/head/helmet/durag
	name = "durag"
	desc = "Good for keeping sweat out of your eyes"
	icon = 'icons/obj/clothing/hats.dmi'
	item_state = "durag"
	icon_state = "durag"
	armor = list(melee = 35, bullet = 35, laser = 35, energy = 15, bomb = 10, bio = 0, rad = 0)
	flags_inv = HIDEEARS | HIDEHAIR

/obj/item/clothing/head/helmet/durag/jungle
	name = "marksman cowl"
	desc = "A cowl worn to conceal the face of a marksman in the jungle."
	icon_state = "duragG"
	item_state = "duragG"

/obj/item/clothing/head/helmet/marine
	name = "\improper M10 Pattern Marine Helmet"
	desc = "A standard M10 Pattern Helmet. It reads on the label, 'The difference between an open-casket and closed-casket funeral. Wear on head for best results.'."
	icon = 'icons/Marine/marine_armor.dmi'
	icon_state = "helmet"
	item_state = "helmet"
	armor = list(melee = 65, bullet = 35, laser = 30, energy = 20, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEEARS
	pocket = /obj/item/weapon/storage/internal/pocket/big/marinehelmet

/obj/item/clothing/head/helmet/marine/tech
	name = "\improper M10 technician helmet"
	icon_state = "helmet-tech"
	item_color = "helmet-tech"

/obj/item/clothing/head/helmet/marine/medic
	name = "\improper M10 medic helmet"
	icon_state = "helmet-medic"
	item_color = "helmet-medic"

/obj/item/clothing/head/helmet/marine/leader
	name = "\improper M11 pattern leader helmet"
	icon_state = "xhelm"
	desc = "A slightly fancier helmet for marine leaders. This one contains a small built-in camera and has cushioning to project your fragile brain."
	armor = list(melee = 75, bullet = 45, laser = 40, energy = 40, bomb = 35, bio = 10, rad = 10)
	anti_hug = 2
	var/obj/machinery/camera/camera

/obj/item/clothing/head/helmet/marine/specialist
	name = "\improper B18 helmet"
	icon_state = "xhelm"
	desc = "The B18 Helmet that goes along with the B18 Defensive Armor. It's heavy, reinforced, and protects more of the face."
	armor = list(melee = 95, bullet = 105, laser = 75, energy = 65, bomb = 70, bio = 15, rad = 15)
	anti_hug = 3
	unacidable = 1

//=============================//PMCS\\==================================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/marine/veteran/PMC
	name = "\improper PMC tactical cap"
	desc = "A protective cap made from flexable kevlar. Standard issue for most security forms in the place of a helmet."
	icon = 'icons/PMC/PMC.dmi'
	icon_override = 'icons/PMC/PMC.dmi'
	item_state = "helmet"
	icon_state = "pmc_hat"
	armor = list(melee = 38, bullet = 38, laser = 32, energy = 22, bomb = 12, bio = 5, rad = 5)

/obj/item/clothing/head/helmet/marine/veteran/PMC/leader
	name = "\improper PMC beret"
	desc = "The pinacle of fashion for any aspiring mercenary leader. Designed to protect the head from light impacts."
	icon = 'icons/PMC/PMC.dmi'
	item_state = "officer_hat"
	icon_state = "officer_hat"
	anti_hug = 3

/obj/item/clothing/head/helmet/marine/veteran/PMC/sniper
	name = "\improper PMC sniper helmet"
	desc = "A helmet worn by PMC Marksmen"
	item_state = "pmc_sniper_hat"
	icon_state = "pmc_sniper_hat"
	armor = list(melee = 55, bullet = 65, laser = 45, energy = 55, bomb = 60, bio = 10, rad = 10)

/obj/item/clothing/head/helmet/marine/veteran/PMC/gunner
	name = "\improper PMC gunner helmet"
	desc = "A modification of the standard Armat Systems M3 armor."
	item_state = "heavy_helmet"
	icon_state = "heavy_helmet"
	armor = list(melee = 80, bullet = 80, laser = 50, energy = 60, bomb = 70, bio = 10, rad = 10)
	anti_hug = 4

/obj/item/clothing/head/helmet/marine/veteran/PMC/commando
	name = "\improper PMC commando helmet"
	desc = "A fully enclosed, armored helmet made for Weyland Yutani elite commandos."
	item_state = "commando_helmet"
	icon = 'icons/PMC/PMC.dmi'
	icon_state = "commando_helmet"
	armor = list(melee = 90, bullet = 120, laser = 90, energy = 90, bomb = 90, bio = 100, rad = 100)
	anti_hug = 6
	unacidable = 1

//==========================//DISTRESS\\=================================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/marine/veteran/dutch
	name = "\improper Dutch's Dozen helmet"
	desc = "A protective helmet worn by some seriously experienced mercs."
	icon = 'icons/PMC/PMC.dmi'
	item_state = "dutch_helmet"
	icon_state = "dutch_helmet"
	armor = list(melee = 70, bullet = 70, laser = 0,energy = 20, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/head/helmet/marine/veteran/dutch/cap
	name = "\improper Dutch's Dozen cap"
	item_state = "dutch_cap"
	icon_state = "dutch_cap"
	flags_inv = THICKMATERIAL

/obj/item/clothing/head/helmet/marine/veteran/dutch/band
	name = "\improper Dutch's Dozen band"
	item_state = "dutch_band"
	icon_state = "dutch_band"
	flags_inv = THICKMATERIAL

/obj/item/clothing/head/helmet/marine/veteran/bear
	name = "\improper Iron Bear helmet"
	desc = "Is good for winter, because it has hole to put vodka through."
	icon = 'icons/PMC/PMC.dmi'
	icon_override = 'icons/PMC/PMC.dmi'
	item_state = "dutch_helmet"
	icon_state = "dutch_helmet"
	armor = list(melee = 90, bullet = 65, laser = 40, energy = 35, bomb = 35, bio = 5, rad = 5)
	anti_hug = 2

//==========================//HELMET PROCS\\=============================\\
//=======================================================================\\

/obj/item/clothing/head/helmet/marine/examine(mob/user)
	..()
	if(pocket.contents.len)
		var/dat = "<br><br>There is something attached to \the [src]:<br><br>"
		for(var/obj/O in pocket.contents)
			dat += "\blue *\icon[O] - [O]<br>"
		user << dat

/obj/item/clothing/head/helmet/marine/leader/New()
	..()
	pocket.handle_item_insertion(new/obj/machinery/camera, 1)
	camera.network = list("LEADER")
