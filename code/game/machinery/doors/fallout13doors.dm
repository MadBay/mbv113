//We have dooors here, unlike doors the dooors are way more simple and thus better.
//Wasteland dooors from wasteland_doors.dmi
/obj/machinery/dooor/wood
	name = "wooden door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "wasteland"
	opacity = 1
	density = 1
	anchored = 1
	layer = 4.2

/obj/machinery/dooor
	var/islock = 0
	var/lock_id = 0
	var/locked = 0
	var/sound_open = 'sound/machines/door_open.ogg'
	var/sound_close = 'sound/machines/door_close.ogg'
	density = 1
/obj/machinery/dooor/attackby(obj/item/weapon/I, mob/living/user, params)
	if(istype(I,/obj/item/weapon/lock))
		var/obj/item/weapon/lock/L = I
		if(islock)
			user << "Lock already installed here"
			return
		user << "You start installing the lock"
		if(do_after(user, 10, target = src))
			lock_id = L.id
			islock = 1
			qdel(I)
			user << "You successfully install the lock"
			return
		user << "You failed to install the lock"
		return
	if(istype(I,/obj/item/weapon/doorkey) && istype(I,/obj/item/weapon/keyring))
		var/obj/item/weapon/doorkey/K = I
		if(!islock)
			user << "There is no lock installed"
			return
		if(locked)
			if(checkkey(lock_id,K))
				user << "You unlock the door"
				locked = 0
				return
			else
				user << "There is a wrong key"
				return
		if(!locked && density)
			if(checkkey(lock_id,K))
				user << "You lock the door"
				locked = 1
				return
			else
				user << "There is a wrong key"
				return
	if(!locked)
		if (density)
			icon_state = "[icon_state]open"
			playsound(src.loc, sound_open, 30, 0, 0)
			opacity = 0
		else
			icon_state = copytext(icon_state,1,lentext(icon_state)-3)
			playsound(src.loc, sound_close, 30, 0, 0)
			opacity = 1
		density = !density
		return
	else
		user << "The door is locked"

/obj/machinery/dooor/attack_hand(mob/user)
	if(!locked)
		if (density)
			icon_state = "[icon_state]open"
			playsound(src.loc, sound_open, 30, 0, 0)
			opacity = 0
		else
			icon_state = copytext(icon_state,1,lentext(icon_state)-3)
			playsound(src.loc, sound_close, 30, 0, 0)
			opacity = 1
		density = !density
		return
	else
		user << "The door is locked"
/obj/machinery/dooor/attack_tk(mob/user)
	if(!locked)
		if (density)
			icon_state = "[icon_state]open"
			playsound(src.loc, sound_open, 30, 0, 0)
			opacity = 0
		else
			icon_state = copytext(icon_state,1,lentext(icon_state)-3)
			playsound(src.loc, sound_close, 30, 0, 0)
			opacity = 1
		density = !density
		return
	else
		user << "The door is locked"


/obj/machinery/dooor/wood/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/wood/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density

//Copy-paste
/obj/machinery/dooor/house
	name = "wooden door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "house"
	opacity = 1
	density = 1
	anchored = 1
	layer = 4.2

/obj/machinery/dooor/house/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/house/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/room
	name = "wooden door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "room"
	opacity = 1
	density = 1
	anchored = 1
	layer = 4.2

/obj/machinery/dooor/room/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/room/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density


//Fuck them copypastes, someone pls, make a system for dooor so no one gets to copypaste shit!
/obj/machinery/dooor/dirtyglass
	name = "wooden door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "dirtyglass"
	opacity = 1
	density = 1
	anchored = 1
	layer = 4.2

/obj/machinery/dooor/dirtyglass/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/dirtyglass/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density

//Copypaste ride never ends!
/obj/machinery/dooor/fakeglass
	name = "damaged wooden door"
	desc = "It still somehow opens and closes."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "fakeglass"
	opacity = 1
	density = 1
	anchored = 1
	layer = 4.2

/obj/machinery/dooor/fakeglass/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/fakeglass/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density

//Will this copypasting hell ever stop?!
/obj/machinery/dooor/brokenglass
	name = "shattered door"
	desc = "It still opens and closes."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "brokenglass"
	opacity = 0
	density = 1
	anchored = 1
	layer = 4.2

/obj/machinery/dooor/brokenglass/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/brokenglass/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density

//Why the hell no one made a normal door system yet without any material/overlays/power/wiring bullshit?
/obj/machinery/dooor/glass
	name = "wooden door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "glass"
	opacity = 0
	density = 1
	anchored = 1
	layer = 4.2


/obj/machinery/dooor/glass/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/glass/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density

//Wolololo copypaste overload my brlndrdr
/obj/machinery/dooor/dirtystore
	name = "metal door"
	desc = "It's a metal door with dirty glass."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "dirtystore"
	opacity = 1
	density = 1
	anchored = 1
	layer = 4.2

/obj/machinery/dooor/dirtystore/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/dirtystore/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density

//Finaly?
/obj/machinery/dooor/store
	name = "metal door"
	desc = "It opens and closes."
	icon = 'icons/obj/doors/wasteland_doors.dmi'
	icon_state = "store"
	opacity = 0
	density = 1
	anchored = 1
	layer = 4.2

/obj/machinery/dooor/store/CanPass(atom/movable/mover, turf/target, height=0)
	if (mover.loc == loc)
		return 1
	return !density

/obj/machinery/dooor/store/CheckExit(atom/movable/O as mob|obj, target)
	if (O.loc == loc)
		return 1
	return !density