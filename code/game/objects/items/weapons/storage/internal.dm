/obj/item/weapon/storage/internal
	storage_slots = 2
	max_w_class = 2
	max_combined_w_class = 50 // Limited by slots, not combined weight class
	w_class = 4

/obj/item/weapon/storage/internal/ClickAccessible(mob/user, depth=1)
	if(loc)
		return loc.ClickAccessible(user, depth)

/obj/item/weapon/storage/internal/Adjacent(A)
	if(loc)
		return loc.Adjacent(A)

/obj/item/weapon/storage/internal/pocket
	var/priority = TRUE
	// TRUE if opens when clicked, like a backpack.
	// FALSE if opens only when dragged on mob's icon (hidden pocket)
	var/quickdraw = FALSE
	// TRUE if you can quickdraw items from it with alt-click.

/obj/item/weapon/storage/internal/pocket/New()
	..()
	if(loc)
		name = loc.name

/obj/item/weapon/storage/internal/pocket/handle_item_insertion(obj/item/W, prevent_warning = 0, mob/user)
	. = ..()
	if(. && silent && !prevent_warning)
		if(quickdraw)
			user << "<span class='notice'>You discreetly slip [W] into [src]. Alt-click [src] to remove it.</span>"
		else
			user << "<span class='notice'>You discreetly slip [W] into [src]."

/obj/item/weapon/storage/internal/pocket/big
	max_w_class = 3

/obj/item/weapon/storage/internal/pocket/small
	storage_slots = 1
	priority = FALSE

/obj/item/weapon/storage/internal/pocket/tiny
	storage_slots = 1
	max_w_class = 1
	priority = FALSE

/obj/item/weapon/storage/internal/pocket/shoes
	can_hold = list(
		/obj/item/weapon/kitchen/knife, /obj/item/weapon/switchblade, /obj/item/weapon/pen,
		/obj/item/weapon/scalpel, /obj/item/weapon/reagent_containers/syringe, /obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/hypospray/medipen, /obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/implanter, /obj/item/weapon/screwdriver, /obj/item/weapon/weldingtool/mini,
		/obj/item/device/firing_pin
		)
	//can hold both regular pens and energy daggers. made for your every-day tactical librarians/murderers.
	priority = FALSE
	quickdraw = TRUE
	silent = TRUE


/obj/item/weapon/storage/internal/pocket/shoes/clown
	can_hold = list(
		/obj/item/weapon/kitchen/knife, /obj/item/weapon/switchblade, /obj/item/weapon/pen,
		/obj/item/weapon/scalpel, /obj/item/weapon/reagent_containers/syringe, /obj/item/weapon/dnainjector,
		/obj/item/weapon/reagent_containers/hypospray/medipen, /obj/item/weapon/reagent_containers/dropper,
		/obj/item/weapon/implanter, /obj/item/weapon/screwdriver, /obj/item/weapon/weldingtool/mini,
		/obj/item/device/firing_pin, /obj/item/weapon/bikehorn)

/obj/item/weapon/storage/internal/pocket/small/detective
	priority = TRUE // so the detectives would discover pockets in their hats

/obj/item/weapon/storage/internal/pocket/small/detective/New()
	..()
	new /obj/item/weapon/reagent_containers/food/drinks/flask/det(src)

/obj/item/weapon/storage/internal/pocket/butt

/obj/item/weapon/storage/internal/pocket/butt/handle_item_insertion(obj/item/W, prevent_warning = 1, mob/user)
	if(istype(loc, /obj/item/organ/internal/butt))
		var/obj/item/organ/internal/butt/B = loc
		if(B.owner && ishuman(B.owner))
			var/mob/living/carbon/human/H = B.owner
			if(H.w_uniform)
				user << "<span class='danger'>Remove the jumpsuit first!</span>"
				return
	. = ..()

/obj/item/weapon/storage/internal/pocket/butt/Adjacent(A)
	if(istype(loc, /obj/item/organ/internal/butt))
		var/obj/item/organ/internal/butt/B = loc
		if(B.owner)
			var/mob/guy = B.owner
			return guy.Adjacent(A)

/obj/item/weapon/storage/internal/pocket/butt/xeno
	storage_slots = 3

/obj/item/weapon/storage/internal/pocket/butt/bluespace
	storage_slots = 4
	max_w_class = 3