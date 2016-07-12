/obj/machinery/power/port_gen/fuel
	name = "diesel generator"
	var/obj/item/weapon/reagent_containers/Storage = new /obj/item/weapon/reagent_containers


/obj/machinery/power/port_gen/fuel/New()
	Storage.volume = 500
	var/datum/reagents/R = Storage.reagents
	R.maximum_volume  = 500
	..()
/obj/machinery/power/port_gen/fuel/HasFuel()
	var/datum/reagents/R = Storage.reagents
	for(var/datum/reagent/fuel/F in R.reagent_list)
		return 1
	return 0
/obj/machinery/power/port_gen/fuel/UseFuel()
	var/datum/reagents/R = Storage.reagents
	for(var/datum/reagent/fuel/F in R.reagent_list)
		F.volume = max((F.volume-0.2),0)
		playsound(src,'sound/machines/generator_loop.ogg',50,0,4)
	R.update_total()
/obj/machinery/power/port_gen/fuel/AltClick(mob/user)
	var/datum/reagents/R = Storage.reagents
	R.remove_all(500)
	user << "You empty the generator's fuel tank"
/obj/machinery/power/port_gen/fuel/examine(mob/user)
	..()
	var/datum/reagents/R = Storage.reagents
	var/S = 0
	switch(R.total_volume)
		if(0)
			S = "empty"
		if(1 to 100)
			S = "almost empty"
		if(101 to 300)
			S = "half full"
		if(301 to 500)
			S = "full"
	user << "The fuel tank is [S]"
/obj/machinery/power/port_gen/fuel/attackby(obj/item/O, mob/user, params)
	if(istype(O,/obj/item/weapon/reagent_containers))
		var/obj/item/weapon/reagent_containers/C = O
		var/datum/reagents/R = C.reagents
		if(!R.total_volume)
			return
		var/datum/reagents/R2 = Storage.reagents
		R.trans_to(R2,C.amount_per_transfer_from_this)
		user << "<span class='notice'>You transfer [C.amount_per_transfer_from_this] units of fuel to generator</span>"
	if(istype(O, /obj/item/weapon/wrench))
		if(!anchored)
			connect_to_network()
			user << "<span class='notice'>You secure the generator to the floor.</span>"
			anchored = 1
		else if(anchored)
			disconnect_from_network()
			user << "<span class='notice'>You unsecure the generator from the floor.</span>"
			anchored = 0
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
/obj/machinery/power/port_gen/fuel/attack_hand(mob/user)
	if(!active)
		if(HasFuel() && anchored)
			active = 1
			playsound(src,'sound/machines/generator_start.ogg',50,0,4)
			user.visible_message("<span class='notice'>Generator starts</span>")
	else
		active = 0
		playsound(src,'sound/machines/generator_stop.ogg',50,0,4)
		user.visible_message("<span class='notice'>Generator stops</span>")