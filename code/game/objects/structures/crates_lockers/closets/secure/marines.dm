/*/obj/structure/closet/secure_closet/marine //standard marine shite
	name = "marine locker"
	req_access = list(access_marine_prep)
	icon_state = "marinestandard"

/obj/structure/closet/secure_closet/marine/New()
	..()
	new /obj/item/clothing/suit/storage/marine(src)
	new /obj/item/weapon/storage/belt/marine(src)
	new /obj/item/clothing/head/helmet/marine(src)
	new /obj/item/device/flashlight(src)
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/clothing/under/marine(src)

//commander
/obj/structure/closet/secure_closet/marine_commander
	name = "commander's locker"
	req_access = list(access_sulaco_commander)
	icon_state = "cap"

/obj/structure/closet/secure_closet/marine_commander/New()
	..()
	new /obj/item/weapon/storage/backpack/mcommander(src)
	new /obj/item/clothing/shoes/marinechief/commander(src)
	new /obj/item/clothing/gloves/marine/techofficer/commander(src)
	new /obj/item/clothing/under/marine/officer/command(src)
	new /obj/item/clothing/head/beret/marine/commander(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/device/radio/headset/mcom(src)

//commander smartgun
/obj/structure/closet/secure_closet/securecom
	name = "commander's secure box"
	desc = "You could probably get court-marshaled just by looking at this..."
	icon_state = "largermetal"

*/