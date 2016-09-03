//Masks
/obj/item/clothing/mask/gas/PMC
	name = "\improper M8 pattern armored balaclava"
	desc = "An armored balaclava designed to conceal both the identity of the operator and act as an air-filter."
	icon = 'icons/PMC/PMC.dmi'
	item_state = "helmet"
	icon_state = "pmc_mask"
	anti_hug = 3
	armor = list(melee = 10, bullet = 10, laser = 5, energy = 5, bomb = 10, bio = 1, rad = 1)

/obj/item/clothing/mask/gas/PMC/leader
	name = "\improper M8 pattern armored balaclava"
	desc = "An armored balaclava designed to conceal both the identity of the operator and act as an air-filter. This particular suit looks like it belongs to a high-ranking officer."
	icon = 'icons/PMC/PMC.dmi'
	item_state = "officer_mask"
	icon_state = "officer_mask"

/obj/item/clothing/mask/gas/bear
	name = "tactical balaclava"
	desc = "A superior balaclava worn by the Iron Bears."
	icon = 'icons/PMC/PMC.dmi'
	item_state = "bear_mask"
	icon_state = "bear_mask"
	anti_hug = 2

//MARINES
/obj/item/clothing/under/marine
	name = "\improper USCM uniform"
	desc = "The issue uniform for the USCM forces. It is weaved with light kevlar plates that protect against light impacts and light-caliber rounds."
	armor = list(melee = 5, bullet = 10, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	icon_state = "marine_jumpsuit"
	item_state = "marine_jumpsuit"
	item_color = "marine_jumpsuit"

/obj/item/clothing/under/marine/underoos
	name = "marine underpants"
	desc = "A simple outfit worn by USCM operators during cyrosleep. Makes you drowsy and slower while wearing. Find an actual uniform and change out."
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	icon_state = "marine_underpants"
	item_state = "marine_underpants"
	item_color = "marine_underpants"
	slowdown = 3

//OFFICERS

/obj/item/clothing/under/rank/chef/exec
	name = "\improper Weyland Yutani suit"
	desc = "A formal white undersuit."

/obj/item/clothing/under/rank/ro_suit
	name = "requisition officer suit."
	desc = "A nicely-fitting military suit for a requisition officer."
	icon_state = "RO_jumpsuit"
	item_state = "RO_jumpsuit"

/obj/item/clothing/suit/storage/RO
	name = "\improper RO jacket"
	desc = "A green jacket worn by crew on the Sulaco. The back has the flag of the United Americas on it."
	icon_state = "RO_jacket"
	item_state = "RO_jacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/under/marine/mp
	name = "military police jumpsuit"
	icon_state = "MP_jumpsuit"
	item_state = "MP_jumpsuit"

/obj/item/clothing/under/marine/officer
	name = "marine officer uniform"
	desc = "Softer than silk. Lighter than feather. More protective than Kevlar. Fancier than a regular jumpsuit, too."
	icon_state = "milohachert"
	item_state = "milohachert"

/obj/item/clothing/under/marine/officer/technical
	name = "technical officer uniform"
	icon_state = "johnny"

/obj/item/clothing/under/marine/officer/logistics
	name = "marine officer uniform"
	desc = "A uniform worn by commissoned officers of the USCM. Do the corps proud."
	icon_state = "BO_jumpsuit"

/obj/item/clothing/under/marine/officer/bridge
	name = "bridge officer uniform"
	desc = "A uniform worn by commissoned officers of the USCM. Do the corps proud."
	icon_state = "BO_jumpsuit"
	item_state = "BO_jumpsuit"

/obj/item/clothing/under/marine/officer/exec
	name = "executive officer uniform"
	desc = "A uniform typically worn by a First-lieutenant in the USCM. The Executive Officer is the second in-charge of the USCM forces onboard the USS Sulaco."
	icon_state = "XO_jumpsuit"
	item_state = "XO_jumpsuit"

/obj/item/clothing/under/marine/officer/command
	name = "commander uniform"
	desc = "The well-ironed uniform of a USCM Captain, the commander onboard the USS Sulaco. Even looking at it the wrong way could result in being court-marshalled."
	icon_state = "CO_jumpsuit"
	item_state = "CO_jumpsuit"

/obj/item/clothing/under/marine/officer/ce
	name = "chief engineer uniform"
	desc = "A uniform for the engineering crew of the USS Sulaco. Slightly protective against enviromental hazards. Worn by the Chief.."
	armor = list(melee = 0, bullet = 0, laser = 25,energy = 0, bomb = 0, bio = 0, rad = 25)
	icon_state = "EC_jumpsuit"
	item_state = "EC_jumpsuit"

/obj/item/clothing/under/marine/officer/engi
	name = "engineer uniform"
	desc = "A uniform for the engineering crew of the USS Sulaco. Slightly protective against enviromental hazards."
	armor = list(melee = 0, bullet = 0, laser = 15,energy = 0, bomb = 0, bio = 0, rad = 10)
	icon_state = "E_jumpsuit"

/obj/item/clothing/under/marine/officer/researcher
	name = "researcher clothes"
	desc = "A simple set of civilian clothes worn by researchers. "
	armor = list(melee = 0, bullet = 0, laser = 15,energy = 10, bomb = 0, bio = 10, rad = 10)
	icon_state = "research_jumpsuit"
	item_state = "research_jumpsuit"

//RESPONDERS

/obj/item/clothing/under/marine/veteran/PMC
	name = "\improper PMC uniform"
	desc = "A white set of fatigues, designed for private security operators. The symbol of the Weyland-Yutani corporation is emblazed on the suit."
	icon = 'icons/PMC/PMC.dmi'
	icon_state = "pmc_jumpsuit"
	item_state = "armor"
	armor = list(melee = 10, bullet = 10, laser = 5, energy = 5, bomb = 10, bio = 1, rad = 1)

/obj/item/clothing/under/marine/veteran/PMC/leader
	name = "\improper PMC command uniform"
	desc = "A white set of fatigues, designed for private security operators. The symbol of the Weyland-Yutani corporation is emblazed on the suit. This particular suit looks like it belongs to a high-ranking officer."
	item_state = "officer_jumpsuit"

/obj/item/clothing/under/marine/veteran/PMC/commando
	name = "\improper PMC commando uniform"
	desc = "An armored uniform worn by Weyland Yutani elite commandos. It is well protected while remaining light and comfortable."
	icon = 'icons/PMC/PMC.dmi'
	icon_state = "commando_jumpsuit"
	item_state = "commando_jumpsuit"
	item_color = "commando_jumpsuit"
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 20, bomb = 10, bio = 10, rad = 10)
	has_sensor = 0

/obj/item/clothing/under/marine/veteran/bear
	name = "\improper Iron Bear uniform"
	desc = "A uniform worn by Iron Bears mercenaries in the service of Mother Russia. Smells a little like an actual bear."
	icon = 'icons/PMC/PMC.dmi'
	icon_state = "bear_jumpsuit"
	item_state = "bear_jumpsuit"
	has_sensor = 0

/obj/item/clothing/under/marine/veteran/dutch
	name = "\improper Dutch's Dozen uniform"
	desc = "A comfortable uniform worn by the Dutch's Dozen mercenaries. It's seen some definite wear and tear, but is still in good condition."
	icon = 'icons/PMC/PMC.dmi'
	icon_state = "dutch_jumpsuit"
	item_state = "dutch_jumpsuit"
	has_sensor = 0

/obj/item/clothing/under/marine/veteran/dutch/ranger
	icon = 'icons/PMC/PMC.dmi'
	icon_state = "dutch_jumpsuit2"
	item_state = "dutch_jumpsuit2"

//===========================//CIVILIANS\\===============================\\
//=======================================================================\\

/obj/item/clothing/under/pizza
	name = "pizza delivery uniform"
	desc = "An ill-fitting, slightly stained uniform for a pizza delivery pilot. Smells of cheese."
	icon_state = "redshirt2"
	item_state = "r_suit"
	has_sensor = 0

/obj/item/clothing/under/colonist
	name = "colonist uniform"
	desc = "A stylish grey-green jumpsuit - standard issue for colonists."
	icon_state = "colonist"
	item_state = "colonist"
	has_sensor = 0

/obj/item/clothing/under/CM_uniform
	name = "colonial marshal uniform"
	desc = "A blue shirt and tan trousers - the official uniform for a Colonial Marshal."
	icon_state = "marshal"
	item_state = "marshal"
	item_color = "marshal"
	armor = list(melee = 15, bullet = 15, laser = 15,energy = 5, bomb = 5, bio = 0, rad = 0)
	has_sensor = 0

/obj/item/clothing/suit/storage/CMB
	name = "\improper CMB jacket"
	desc = "A green jacket worn by crew on the Colonial Marshals."
	icon_state = "CMB_jacket"
	item_state = "CMB_jacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/under/liaison_suit
	name = "liaison's tan suit"
	desc = "A stiff, stylish tan suit commonly worn by businessmen from the Weyland Yutani corporation. Specically crafted to make you look like a prick."
	icon_state = "liaison_regular"
	item_state = "liaison_regular"
	item_color = "liaison_regular"

/obj/item/clothing/under/liaison_suit/outing
	name = "liaison's outfit"
	desc = "A casual outfit consisting of a collared shirt and a vest. Looks like something you might wear on the weekends, or on a visit to a derelict colony."
	icon_state = "liaison_outing"
	item_state = "liaison_outing"
	item_color = "liaison_outing"

/obj/item/clothing/under/liaison_suit/formal
	name = "liaison's white suit"
	desc = "A formal, white suit. Looks like something you'd wear to a funeral, a Weyland-Yutani corporate dinner, or both. Stiff as a board, but makes you feel like rolling out of a Rolls-Royce."
	icon_state = "liaison_formal"
	item_state = "liaison_formal"
	item_color = "liaison_formal"

/obj/item/clothing/under/liaison_suit/suspenders
	name = "liaison's attire"
	desc = "A collared shirt, complimented by a pair of suspenders. Worn by Weyland-Yutani employees who ask the tough questions. Smells faintly of cigars and bad acting."
	icon_state = "liaison_suspenders"
	item_state = "liaison_suspenders"
	item_color = "liaison_suspenders"
