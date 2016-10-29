/obj/item/organ/alien
	origin_tech = "biotech=5"
	icon_state = "xgibmid2"
	var/list/alien_powers = list()

/obj/item/organ/alien/New()
	for(var/A in alien_powers)
		if(ispath(A))
			alien_powers -= A
			alien_powers += new A(src)
	..()

/obj/item/organ/alien/Insert(mob/living/carbon/M, special = 0)
	..()
	for(var/obj/effect/proc_holder/alien/P in alien_powers)
		M.AddAbility(P)


/obj/item/organ/alien/Remove(mob/living/carbon/M, special = 0)
	for(var/obj/effect/proc_holder/alien/P in alien_powers)
		M.RemoveAbility(P)
	..()

/obj/item/organ/alien/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("sacid", 10)
	return S

/obj/item/organ/alien/Insert()
	..()
	if(owner)
		owner << "<span class='userdanger'>THAT was a terrible idea! You feel burning from the inside, oh shit!</span>"

/obj/item/organ/alien/on_life()
	..()
	if(owner && !isalien(owner))
		owner.reagents.add_reagent("plasma", 10)
		owner.reagents.add_reagent("sacid", 10)

/obj/item/organ/alien/plasmavessel
	name = "plasma vessel"
	icon_state = "plasma"
	origin_tech = "biotech=5;plasmatech=4"
	w_class = 3
	zone = "chest"
	slot = "plasmavessel"
	alien_powers = list(/obj/effect/proc_holder/alien/transfer)
	var/affected_by_pheromone = FALSE

	var/storedPlasma = 100
	var/max_plasma = 300
	var/heal_rate = 2
	var/plasma_rate = 10

/obj/item/organ/alien/plasmavessel/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("plasma", storedPlasma/10)
	return S

/obj/item/organ/alien/plasmavessel/large
	name = "large plasma vessel"
	icon_state = "plasma_large"
	w_class = 4
	storedPlasma = 300
	max_plasma = 500
	plasma_rate = 12
	heal_rate = 4

/obj/item/organ/alien/plasmavessel/large/hivelord
	storedPlasma = 200
	max_plasma = 800
	plasma_rate = 20
	heal_rate = 5

/obj/item/organ/alien/plasmavessel/large/praetorian
	storedPlasma = 200
	max_plasma = 600
	plasma_rate = 20

/obj/item/organ/alien/plasmavessel/large/queen
	origin_tech = "biotech=6;plasmatech=4"
	storedPlasma = 300
	max_plasma = 600
	plasma_rate = 20

/obj/item/organ/alien/plasmavessel/small
	name = "small plasma vessel"
	icon_state = "plasma_small"
	w_class = 2
	storedPlasma = 50
	max_plasma = 100
	plasma_rate = 5
	heal_rate = 1

/obj/item/organ/alien/plasmavessel/small/tiny
	name = "tiny plasma vessel"
	icon_state = "plasma_tiny"
	w_class = 1
	storedPlasma = 2
	max_plasma = 10
	plasma_rate = 2

/obj/item/organ/alien/plasmavessel/on_life()
	if(!owner)
		return

	var/mob/living/carbon/alien/A = owner
	if("recovery" in A.active_pheromones)
		affected_by_pheromone = TRUE
	else
		affected_by_pheromone = FALSE
	//If there are alien weeds on the ground then heal if needed or give some plasma
	if(locate(/obj/structure/alien/weeds) in owner.loc)
		var/multiplier = affected_by_pheromone ? 1 : 2
		if(owner.health >= owner.maxHealth)
			owner.adjustPlasma(plasma_rate*multiplier)
		else
			var/heal_amt = heal_rate*multiplier

			if(!isalien(owner))
				heal_amt *= 0.2

			if (owner.lying || affected_by_pheromone || !isalien(owner))
				var/heal_divider = owner.stat == UNCONSCIOUS ? 2 : 1

				owner.adjustBruteLoss(-heal_amt/heal_divider)
				owner.adjustFireLoss(-heal_amt/heal_divider)
				owner.adjustOxyLoss(-heal_amt/heal_divider)
				owner.adjustCloneLoss(-heal_amt/heal_divider)
			else
				if (owner.getBruteLoss() < 50)
					owner.adjustBruteLoss(-heal_amt)

			owner.adjustPlasma(plasma_rate*multiplier*0.5)

	return ..()

/obj/item/organ/alien/plasmavessel/Insert(mob/living/carbon/M, special = 0)
	..()
	if(isalien(M))
		var/mob/living/carbon/alien/A = M
		A.updatePlasmaDisplay()

/obj/item/organ/alien/plasmavessel/Remove(mob/living/carbon/M, special = 0)
	..()
	if(isalien(M))
		var/mob/living/carbon/alien/A = M
		A.updatePlasmaDisplay()
//Caste plasmavessels
//corroder
/obj/item/organ/alien/plasmavessel/large/corroder
	name = "huge plasma vessel"
	storedPlasma = 450
	max_plasma = 800
	plasma_rate = 30


/obj/item/organ/alien/hivenode
	name = "hive node"
	icon_state = "hivenode"
	zone = "head"
	slot = "hivenode"
	origin_tech = "biotech=5;magnets=4;bluespace=3"
	w_class = 1
	alien_powers = list(/obj/effect/proc_holder/alien/whisper)

/obj/item/organ/alien/hivenode/Insert(mob/living/carbon/M, special = 0)
	..()
	M.faction |= "alien"

/obj/item/organ/alien/hivenode/Remove(mob/living/carbon/M, special = 0)
	M.faction -= "alien"
	..()

/obj/item/organ/alien/resinspinner
	name = "resin spinner"
	icon_state = "stomach-x"
	zone = "mouth"
	slot = "resinspinner"
	origin_tech = "biotech=5;materials=4"
	alien_powers = list(/obj/effect/proc_holder/alien/resin, /obj/effect/proc_holder/alien/plant)


/obj/item/organ/alien/acid
	name = "acid gland"
	icon_state = "acid"
	zone = "head"
	slot = "acidgland"
	origin_tech = "biotech=5;materials=2;combat=2"
	alien_powers = list(/obj/effect/proc_holder/alien/acid)
	var/power = WEAKACID

/obj/item/organ/alien/acid/New(acidpower = WEAKACID)
	..()
	power = acidpower

/obj/item/organ/alien/neurotoxin
	name = "small spitting gland"
	icon_state = "neurotox"
	zone = "mouth"
	slot = "neurotoxingland"
	origin_tech = "biotech=5;combat=5"
	alien_powers = list(/obj/effect/proc_holder/alien/neurotoxin, /obj/effect/proc_holder/alien/neurotoxinchange)
	var/chosenammo = 1
	var/list/ammo_list = list(/obj/item/projectile/bullet/acid/neuro, /obj/item/projectile/bullet/acid/weak)//list of possible ammo types

/obj/item/organ/alien/neurotoxin/spitter
	name = "medium spitting gland"
	ammo_list = list(/obj/item/projectile/bullet/acid/neuro, /obj/item/projectile/bullet/acid)

/obj/item/organ/alien/neurotoxin/bombard
	name = "enhanced spitting gland"
	origin_tech = "biotech=7;combat=8"//if you get this somehow, you're getting it from a corroder, you're robust man
	alien_powers = list(/obj/effect/proc_holder/alien/neurotoxin, /obj/effect/proc_holder/alien/neurotoxinchange, /obj/effect/proc_holder/alien/zoom)
	ammo_list = list(/obj/item/projectile/bullet/acid/neuro, /obj/item/projectile/bullet/acid, /obj/item/projectile/bullet/acid/bombard, /obj/item/projectile/bullet/acid/bombard/lethal)

/obj/item/organ/alien/acidspray
	name = "enormous spitting gland"
	icon_state = "neurotox"
	origin_tech = "biotech=7;combat=8"
	zone = "mouth"
	slot = "spraygland"
	alien_powers = list(/obj/effect/proc_holder/alien/sprayacid)

/obj/item/organ/alien/eggsac
	name = "egg sac"
	icon_state = "eggsac"
	zone = "groin"
	slot = "eggsac"
	w_class = 4
	origin_tech = "biotech=6"
	alien_powers = list(/obj/effect/proc_holder/alien/lay_egg)

/obj/item/organ/alien/legmuscles
	name = "legs muscles"
	icon_state = "alien_muscle"
	zone = "groin"
	slot = "muscles"
	w_class = 4
	origin_tech = "biotech=5;combat=6"
	alien_powers = list(/obj/effect/proc_holder/alien/stomp)

/obj/item/organ/alien/pheromone
	name = "pheromones gland"
	icon_state = "pheromone_gland"
	zone = "mouth"
	slot = "pheromones gland"
	w_class = 4
	origin_tech = "biotech=7"
	alien_powers = list(/obj/effect/proc_holder/alien/pheromone)
	var/active = FALSE
	var/pheromone = "frenzy"
	var/list/pheromone_types = list("frenzy", "guard", "recovery")

/obj/item/organ/alien/pheromone/on_life()
	if(owner && active)
		if(!owner.usePlasma(10))//instead of 5,it'll be 10 but with no initial cost
			owner << "<span class='notice'>You stop emitting pheromones.</span>"
			active = FALSE
	return ..()

/obj/item/organ/alien/pheromone/Remove(mob/living/carbon/M, special = 0)
	..()
	active = FALSE

/obj/item/organ/alien/reinforcedvchords
	name = "reinforced vocal chords"
	icon_state = "vocal"
	zone = "mouth"
	slot = "vocal chords"
	w_class = 3
	origin_tech = "biotech=7;combat=7"
	alien_powers = list(/obj/effect/proc_holder/alien/screech)

/obj/item/organ/alien/storage
	name = "nutrient spines"
	icon_state = "nutrientspines"
	zone = "chest"
	slot = "nutrient spines"
	w_class = 4
	origin_tech = "biotech=5;illegal=1"
	alien_powers = list(/obj/effect/proc_holder/alien/huggerstorage)
	var/obj/item/weapon/storage/internal/alien/huggerinv

/obj/item/organ/alien/storage/New()
	..()
	huggerinv = new(src)
