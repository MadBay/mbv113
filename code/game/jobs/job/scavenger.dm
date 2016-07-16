/*
Scavenger
*/
/datum/job/scavenger
	title = "Scavenger"
	flag = SCAVENGER
	department_flag = CIVILIAN
	faction = "Desert" //desert faction shall disable appearing as scavenger after readying
	total_positions = -1
	spawn_positions = -1 //does not matter for late join
	supervisors = "nobody"
	selection_color = "#dddddd"
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/scavenger

/datum/outfit/job/scavenger
	name = "Scavenger"
	id = null
	ears = null
	belt = null
	backpack = null
	satchel = null

/datum/outfit/job/scavenger/pre_equip(mob/living/carbon/human/H)
	..()
	uniform = pick(/obj/item/clothing/under/pj/red,\
		/obj/item/clothing/under/pj/blue,\
		/obj/item/clothing/under/waiter,\
		/obj/item/clothing/under/f13/settler,\
		/obj/item/clothing/under/f13/mercadv,\
		/obj/item/clothing/under/f13/springm,\
		/obj/item/clothing/under/f13/caravaneer,\
		/obj/item/clothing/under/f13/roving)
	if (prob(50))
		glasses = /obj/item/clothing/glasses/sunglasses
	if (prob(80))
		l_hand = pick(/obj/item/weapon/kitchen/knife,\
			/obj/item/weapon/storage/toolbox/mechanical,\
			/obj/item/weapon/twohanded/spear)


	if (prob(100))
		back = /obj/item/weapon/storage/backpack
		backpack = /obj/item/weapon/storage/backpack
		satchel = /obj/item/weapon/storage/backpack/satchel_norm
		backpack_contents = pick(list(/obj/item/weapon/melee/classic_baton/telescopic=1), \
			list(/obj/item/weapon/reagent_containers/food/drinks/nukacola = 3), \
			list(/obj/item/weapon/reagent_containers/pill/patch/styptic), \
			list(/obj/item/weapon/reagent_containers/syringe/stimulants))

/datum/job/wmedic
	title = "Wasteland medic"
	flag = SCAVENGER
	department_flag = CIVILIAN
	faction = "Desert" //desert faction shall disable appearing as scavenger after readying
	total_positions = -1
	spawn_positions = -1 //does not matter for late join
	supervisors = "nobody"
	selection_color = "#dddddd"
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/wmedic
/datum/outfit/job/wmedic
	name = "Wasteland medic"
	id = null
	ears = null
	belt = null
	backpack = null
	satchel = null
/datum/outfit/job/wmedic/pre_equip(mob/living/carbon/human/H)
	..()
	uniform = /obj/item/clothing/under/f13/doctor
	back = /obj/item/weapon/storage/backpack
	satchel = /obj/item/weapon/storage/backpack/satchel_norm
	backpack = /obj/item/weapon/storage/backpack
	backpack_contents = pick(list(/obj/item/weapon/storage/firstaid/brute = 1,/obj/item/weapon/scalpel = 1),\
								list(/obj/item/weapon/storage/firstaid/fire = 1, /obj/item/weapon/cautery = 1))





/datum/job/wtrader
	title = "Trader"
	flag = SCAVENGER
	department_flag = CIVILIAN
	faction = "Desert" //desert faction shall disable appearing as scavenger after readying
	total_positions = -1
	spawn_positions = -1 //does not matter for late join
	supervisors = "nobody"
	selection_color = "#dddddd"
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/wtrader

/datum/outfit/job/wtrader
	name = "Trader"
	id = null
	ears = null
	belt = null
	backpack = null
	satchel = null

/datum/outfit/job/wtrader/pre_equip(mob/living/carbon/human/H)
	..()
	uniform = /obj/item/clothing/under/f13/brahmin
	back = /obj/item/weapon/storage/backpack
	satchel = /obj/item/weapon/storage/backpack/satchel_norm
	backpack = /obj/item/weapon/storage/backpack
	l_hand = /obj/item/weapon/storage/backpack/dufflebag
	backpack_contents = /obj/item/weapon/storage/wallet

/datum/job/farmer
	title = "Farmer"
	flag = SCAVENGER
	department_flag = CIVILIAN
	faction = "Desert" //desert faction shall disable appearing as scavenger after readying
	total_positions = -1
	spawn_positions = -1 //does not matter for late join
	supervisors = "nobody"
	selection_color = "#dddddd"
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/farmer

/datum/outfit/job/farmer
	name = "Farmer"
	id = null
	ears = null
	belt = null
	backpack = null
	satchel = null

/datum/outfit/job/farmer/pre_equip(mob/living/carbon/human/H)
	..()
	uniform = /obj/item/clothing/under/f13/brahmin
	back = /obj/item/weapon/storage/backpack
	satchel = /obj/item/weapon/storage/backpack/satchel_norm
	backpack = /obj/item/weapon/storage/backpack
	if(prob(50))
		r_pocket = /obj/item/weapon/shovel/spade
	else
		r_pocket = /obj/item/weapon/cultivator
	l_pocket = /obj/item/weapon/doorkey{id = FARMER_ID}
	backpack_contents = /obj/item/seeds

/datum/job/sheriff
	title = "Sheriff"
	flag = SCAVENGER
	department_flag = CIVILIAN
	faction = "Desert" //desert faction shall disable appearing as scavenger after readying
	total_positions = -1
	spawn_positions = 1 //does not matter for late join
	supervisors = "nobody"
	selection_color = "#dddddd"
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/sheriff

/datum/outfit/job/sheriff
	name = "Sheriff"
	id = null
	ears = null
	belt = null
	backpack = null
	satchel = null

/datum/outfit/job/sheriff/pre_equip(mob/living/carbon/human/H)
	..()
	uniform = /obj/item/clothing/under/f13/cowboyg
	suit = /obj/item/clothing/suit/f13/duster
	back = /obj/item/weapon/storage/backpack
	satchel = /obj/item/weapon/storage/backpack/satchel_norm
	backpack = /obj/item/weapon/storage/backpack
	r_pocket = /obj/item/weapon/gun/projectile/revolver/mateba
	l_pocket = /obj/item/weapon/doorkey{id = SHERIFF_ID}
	backpack_contents = /obj/item/ammo_box/c38