//SOFT CAPS

/obj/item/clothing/head/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_head()

///////////////////////////////////////////////////////////////////////

/obj/item/clothing/head/cmbandana
	name = "\improper USCM bandana (green)"
	desc = "Typically worn by heavy-weapon operators, mercenaries and scouts, the bandana serves as a lightweight and comfortable hat. Comes in two stylish colors."
	icon = 'icons/Marine/marine_armor.dmi'
	icon_state = "band"
	item_state = "band"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/cmbandana/tan
	name = "\improper USCM bandana (tan)"
	icon_state = "band2"
	item_state = "band2"

/obj/item/clothing/head/cmberet
	name = "\improper USCM beret"
	desc = "A hat typically worn by the field-officers of the USCM. Occasionally they find their way down the ranks into the hands of squad-leaders and decorated grunts."
	icon = 'icons/Marine/marine_armor.dmi'
	icon_state = "beret"
	item_state = "beret"

/obj/item/clothing/head/cmberet/tan
	icon_state = "berettan"
	item_state = "berettan"

/obj/item/clothing/head/cmberet/red
	icon_state = "beretred"
	item_state = "beretred"

/obj/item/clothing/head/headband
	name = "\improper USCM headband"
	desc = "A rag typically worn by the less-orthodox weapons operators in the USCM. While it offers no protection, it is certainly comfortable to wear compared to the standard helmet. Comes in two stylish colors."
	icon = 'icons/Marine/marine_armor.dmi'
	icon_state = "headband"
	item_state = "headband"

/obj/item/clothing/head/headband/red
	icon_state = "headbandred"
	item_state = "headbandred"

/obj/item/clothing/head/cmcap
	name = "\improper USCM cap"
	desc = "A casual cap occasionally  worn by Squad-leaders and Combat-Engineers. While it has limited combat functionality, some prefer to wear it over the standard issue helmet."
	icon = 'icons/Marine/marine_armor.dmi'
	icon_state = "cap"
	item_state = "cap"

/obj/item/clothing/head/cmcap/ro
	name = "\improper USCM officer cap"
	desc = "A hat usually worn by officers in the USCM. While it has limited combat functionality, some prefer to wear it over the standard issue helmet."
	icon_state = "rocap"
	item_state = "rocap"

/obj/item/clothing/head/cmcap/req
	name = "\improper USCM requisition cap"
	desc = "A hat usually worn by officers in the USCM. While it has limited combat functionality, some prefer to wear it over the standard issue helmet."
	icon_state = "cargocap"
	item_state = "cargocap"

/obj/item/clothing/head/soft/ro_cap
	name = "\improper requisition officer cap"
	desc = "It's a fancy hat for a not-so-fancy military supply clerk."
	icon_state = "cargocap"
	item_state = "cargocap"

/obj/item/clothing/head/soft/marine
	name = "marine sergeant cap"
	desc = "It's a soft cap made from advanced ballistic-resistant fibres. Fails to prevent lumps in the head."
	icon_state = "greysoft"
	armor = list(melee = 35, bullet = 35, laser = 35,energy = 15, bomb = 10, bio = 0, rad = 0)
	flags_inv = THICKMATERIAL

/obj/item/clothing/head/soft/marine/alpha
	name = "alpha squad sergeant cap"
	icon_state = "redsoft"

/obj/item/clothing/head/soft/marine/beta
	name = "beta squad sergeant cap"
	icon_state = "yellowsoft"

/obj/item/clothing/head/soft/marine/charlie
	name = "charlie squad sergeant cap"
	icon_state = "purplesoft"

/obj/item/clothing/head/soft/marine/delta
	name = "delta squad sergeant cap"
	icon_state = "bluesoft"

/obj/item/clothing/head/soft/marine/mp
	name = "marine police sergeant cap"
	icon_state = "greensoft"

//============================//BERETS\\=================================\\
//=======================================================================\\
//Berets have armor, so they have their own category. PMC caps are helmets, so they're in helmets.dm.
/obj/item/clothing/head/beret/marine
	name = "marine officer beret"
	desc = "A beret with the ensign insignia emblazoned on it. It radiates respect and authority."
	icon_state = "beret_badge"
	armor = list(melee = 40, bullet = 40, laser = 40,energy = 20, bomb = 10, bio = 0, rad = 0)
	flags_inv = THICKMATERIAL

/obj/item/clothing/head/beret/marine/commander
	name = "marine commander beret"
	desc = "A beret with the commander insignia emblazoned on it. Wearer may suffer the heavy weight of responsibility upon his head and shoulders."
	icon_state = "centcomcaptain"

/obj/item/clothing/head/beret/marine/chiefofficer
	name = "chief officer beret"
	desc = "A beret with the lieutenant-commander insignia emblazoned on it. It emits a dark aura and may corrupt the soul."
	icon_state = "hosberet"

/obj/item/clothing/head/beret/marine/techofficer
	name = "technical officer beret"
	desc = "A beret with the lieutenant insignia emblazoned on it. There's something inexplicably efficient about it..."
	icon_state = "e_beret_badge"

/obj/item/clothing/head/beret/marine/logisticsofficer
	name = "logistics officer beret"
	desc = "A beret with the lieutenant insignia emblazoned on it. It inspires a feeling of respect."
	icon_state = "hosberet"
