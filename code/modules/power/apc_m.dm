/obj/machinery/power/apc/wasteland
	name = "switchboard"
	var/lock_id = 1
	req_access = 0


/obj/machinery/power/apc/wasteland/attackby(obj/item/W, mob/living/user, params)

	if (istype(user, /mob/living/silicon) && get_dist(src,user)>1)
		return src.attack_hand(user)
	if (istype(W, /obj/item/weapon/crowbar) && opened)
		if (has_electronics==1)
			if (terminal)
				user << "<span class='warning'>Disconnect the wires first!</span>"
				return
			playsound(src.loc, 'sound/items/Crowbar.ogg', 50, 1)
			user << "<span class='notice'>You are trying to remove the power control board...</span>" //lpeters - fixed grammar issues
			if(do_after(user, 50/W.toolspeed, target = src))
				if (has_electronics==1)
					has_electronics = 0
					if ((stat & BROKEN) || malfhack)
						user.visible_message(\
							"[user.name] has broken the power control board inside [src.name]!",\
							"<span class='notice'>You break the charred power control board and remove the remains.</span>",
							"<span class='italics'>You hear a crack.</span>")
						//ticker.mode:apcs-- //XSI said no and I agreed. -rastaf0
					else
						user.visible_message(\
							"[user.name] has removed the power control board from [src.name]!",\
							"<span class='notice'>You remove the power control board.</span>")
						new /obj/item/weapon/electronics/apc(loc)
		else if (opened!=2) //cover isn't removed
			opened = 0
			update_icon()
	else if (istype(W, /obj/item/weapon/crowbar) && !((stat & BROKEN) || malfhack) )
		if(coverlocked && !(stat & MAINT))
			user << "<span class='warning'>The cover is locked and cannot be opened!</span>"
			return
		else
			opened = 1
			update_icon()
	else if	(istype(W, /obj/item/weapon/stock_parts/cell) && opened)	// trying to put a cell inside
		if(cell)
			user << "<span class='warning'>There is a power cell already installed!</span>"
			return
		else
			if (stat & MAINT)
				user << "<span class='warning'>There is no connector for your power cell!</span>"
				return
			if(!user.drop_item())
				return
			W.loc = src
			cell = W
			user.visible_message(\
				"[user.name] has inserted the power cell to [src.name]!",\
				"<span class='notice'>You insert the power cell.</span>")
			chargecount = 0
			update_icon()
	else if	(istype(W, /obj/item/weapon/screwdriver))	// haxing
		if(opened)
			if (cell)
				user << "<span class='warning'>Close the switchboard first!</span>" //Less hints more mystery!
				return
			else
				if (has_electronics==1 && terminal)
					has_electronics = 2
					stat &= ~MAINT
					playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
					user << "<span class='notice'>You screw the circuit electronics into place.</span>"
				else if (has_electronics==2)
					has_electronics = 1
					stat |= MAINT
					playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
					user << "<span class='notice'>You unfasten the electronics.</span>"
				else /* has_electronics==0 */
					user << "<span class='warning'>There is nothing to secure!</span>"
					return
				update_icon()
		else if(emagged)
			user << "<span class='warning'>The interface is broken!</span>"
		else
			wiresexposed = !wiresexposed
			user << "The wires have been [wiresexposed ? "exposed" : "unexposed"]"
			update_icon()

	else if (istype(W,/obj/item/weapon/doorkey) && istype(W,/obj/item/weapon/keyring))			// trying to unlock the interface with an ID card
		if(emagged)
			user << "<span class='warning'>The interface is broken!</span>"
		else if(opened)
			user << "<span class='warning'>You must close the cover to lock it</span>"
		else if(wiresexposed)
			user << "<span class='warning'>You must close the panel!</span>"
		else if(stat & (BROKEN|MAINT))
			user << "<span class='warning'>Nothing happens!</span>"
		else
			if(checkkey(lock_id,W))
				locked = !locked
				user << "<span class='notice'>You [ locked ? "lock" : "unlock"] the switchboard interface.</span>"
				update_icon()
			else
				user << "<span class='warning'>Wrong keys</span>"
	else if (istype(W, /obj/item/stack/cable_coil) && !terminal && opened && has_electronics!=2)
		if (src.loc:intact)
			user << "<span class='warning'>You must remove the floor plating in front of the switchboard first!</span>"
			return
		var/obj/item/stack/cable_coil/C = W
		if(C.get_amount() < 10)
			user << "<span class='warning'>You need ten lengths of cable for switchboard!</span>"
			return
		user.visible_message("[user.name] adds cables to the switchboard frame.", \
							"<span class='notice'>You start adding cables to the switchboard frame...</span>")
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		if(do_after(user, 20, target = src))
			if (C.amount >= 10 && !terminal && opened && has_electronics != 2)
				var/turf/T = get_turf(src)
				var/obj/structure/cable/N = T.get_cable_node()
				if (prob(50) && electrocute_mob(usr, N, N))
					var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
					s.set_up(5, 1, src)
					s.start()
					return
				C.use(10)
				user << "<span class='notice'>You add cables to the switchboard frame.</span>"
				make_terminal()
				terminal.connect_to_network()
	else if (istype(W, /obj/item/weapon/wirecutters) && terminal && opened && has_electronics!=2)
		terminal.dismantle(user)

	else if (istype(W, /obj/item/weapon/electronics/apc) && opened && has_electronics==0 && !((stat & BROKEN) || malfhack))
		user.visible_message("[user.name] inserts the power control board into [src].", \
							"<span class='notice'>You start to insert the power control board into the frame...</span>")
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		if(do_after(user, 10, target = src))
			if(has_electronics==0)
				has_electronics = 1
				user << "<span class='notice'>You place the power control board inside the frame.</span>"
				qdel(W)
	else if (istype(W, /obj/item/weapon/electronics/apc) && opened && has_electronics==0 && ((stat & BROKEN) || malfhack))
		user << "<span class='warning'>You cannot put the board inside, the frame is damaged!</span>"
		return
	else if (istype(W, /obj/item/weapon/weldingtool) && opened && has_electronics==0 && !terminal)
		var/obj/item/weapon/weldingtool/WT = W
		if (WT.get_fuel() < 3)
			user << "<span class='warning'>You need more welding fuel to complete this task!</span>"
			return
		user.visible_message("[user.name] welds [src].", \
							"<span class='notice'>You start welding the switchboard frame...</span>", \
							"<span class='italics'>You hear welding.</span>")
		playsound(src.loc, 'sound/items/Welder.ogg', 50, 1)
		if(do_after(user, 50/W.toolspeed, target = src))
			if(!src || !WT.remove_fuel(3, user)) return
			if (emagged || malfhack || (stat & BROKEN) || opened==2)
				new /obj/item/stack/sheet/metal(loc)
				user.visible_message(\
					"[user.name] has cut [src] apart with [W].",\
					"<span class='notice'>You disassembled the broken switchboard frame.</span>")
			else
				new /obj/item/wallframe/apc(loc)
				user.visible_message(\
					"[user.name] has cut [src] from the wall with [W].",\
					"<span class='notice'>You cut the switchboard frame from the wall.</span>")
			qdel(src)
			return
	else if (istype(W, /obj/item/wallframe/apc) && opened && emagged)
		emagged = 0
		if (opened==2)
			opened = 1
		user.visible_message(\
			"[user.name] has replaced the damaged switchboard frontal panel with a new one.",\
			"<span class='notice'>You replace the damaged switchboard frontal panel with a new one.</span>")
		qdel(W)
		update_icon()
	else if (istype(W, /obj/item/wallframe/apc) && opened && ((stat & BROKEN) || malfhack))
		if (has_electronics)
			user << "<span class='warning'>You cannot repair this switchboard until you remove the electronics still inside!</span>"
			return
		user.visible_message("[user.name] replaces the damaged switchboard frame with a new one.",\
							"<span class='notice'>You begin to replace the damaged switchboard frame...</span>")
		if(do_after(user, 50, target = src))
			user << "<span class='notice'>You replace the damaged switchboard frame with a new one.</span>"
			qdel(W)
			stat &= ~BROKEN
			malfai = null
			malfhack = 0
			if (opened==2)
				opened = 1
			update_icon()
	else
		if((!opened && wiresexposed && wires.IsInteractionTool(W)) || (issilicon(user) && !(stat & BROKEN) &&!malfhack))
			return attack_hand(user)

		..()
		if( ((stat & BROKEN) || malfhack) && !opened && W.force >= 5 && W.w_class >= 3 && prob(20) )
			opened = 2
			user.visible_message("<span class='warning'>[user.name] has knocked down the switchboard cover  with the [W.name].</span>", \
				"<span class='danger'>You knock down the switchboard cover with your [W.name]!</span>", \
				"<span class='italics'>You hear bang.</span>")
			update_icon()
