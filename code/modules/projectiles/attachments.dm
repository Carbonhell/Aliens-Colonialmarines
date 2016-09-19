//Attachments
/obj/item/gun_attachment
	name = "attachment"
	desc = "default attachment, if you see this someone fuggd up"
	w_class = 2
	var/obj/item/weapon/gun/gun //the gun the attachment's attached to.
	var/gun_flag//what attachment is it?BARREL, UNDERBARREL, etc. See in /__DEFINES/guns.dm
	var/image/overlay
	var/list/special_effects = list()//special effects, such as an underslug grenade launcher shooting its nade and the likes

/obj/item/gun_attachment/New()
	..()
	overlay = image(icon = icon, icon_state = "[icon_state]_overlay")
	for(var/i in special_effects)
		special_effects += new i()
		special_effects -= i

/obj/item/gun_attachment/Destroy()
	if(gun)
		gun.priority_overlays -= overlay
		gun.overlays -= overlay
	gun = null
	qdel(overlay)
	..()

/obj/item/gun_attachment/proc/on_insert(mob/user)//Special action when the attachment's inserted,such as increasing damage, accuracy, and the likes.
	for(var/i in special_effects)
		var/datum/action/A = i
		gun.actions += A
		A.target = gun
		A.UpdateButtonIcon()
	return

/obj/item/gun_attachment/proc/on_remove(mob/user)
	for(var/i in special_effects)
		var/datum/action/A = i
		gun.actions -= A
		A.target = null
	return

//default attachment types. Want to make a new barrel attachment? Make it a child of barrel,easy.
/obj/item/gun_attachment/barrel
	gun_flag = BARREL

/obj/item/gun_attachment/grip
	gun_flag = GRIP

/obj/item/gun_attachment/optics
	gun_flag = OPTICS

/obj/item/gun_attachment/underbarrel
	gun_flag = UNDERBARREL

/obj/item/gun_attachment/paint
	gun_flag = PAINT

//Attachments' special actions. Put 'em in the special_effects list of your attachment.
/datum/action/item_action/attachment//Doesn't need any editing

