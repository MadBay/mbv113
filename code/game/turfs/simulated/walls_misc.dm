/turf/simulated/wall/cult
	name = "wall"
	desc = "The patterns engraved on the wall seem to shift as you try to focus on them. You feel sick."
	icon = 'icons/turf/walls/cult_wall.dmi'
	icon_state = "cult"
	walltype = "cult"
	builtin_sheet = null
	canSmoothWith = null

/turf/simulated/wall/cult/New()
	PoolOrNew(/obj/effect/overlay/temp/cult/turf, src)
	..()

/turf/simulated/wall/cult/break_wall()
	new /obj/effect/decal/cleanable/blood(src)
	return (new /obj/structure/cultgirder(src))

/turf/simulated/wall/cult/devastate_wall()
	new /obj/effect/decal/cleanable/blood(src)
	new /obj/effect/decal/remains/human(src)

/turf/simulated/wall/cult/narsie_act()
	return

/turf/simulated/wall/vault
	icon = 'icons/turf/walls.dmi'
	icon_state = "rockvault"

/turf/simulated/wall/ice
	icon = 'icons/turf/walls/icedmetal_wall.dmi'
	icon_state = "iced"
	desc = "A wall covered in a thick sheet of ice."
	walltype = "iced"
	canSmoothWith = null
	hardness = 35
	slicing_duration = 150 //welding through the ice+metal

/turf/simulated/wall/rust
	name = "rusted wall"
	desc = "A rusted metal wall."
	icon = 'icons/turf/walls/rusty_wall.dmi'
	icon_state = "arust"
	walltype = "arust"
	hardness = 45

/turf/simulated/wall/r_wall/rust
	name = "rusted reinforced wall"
	desc = "A huge chunk of rusted reinforced metal."
	icon = 'icons/turf/walls/rusty_reinforced_wall.dmi'
	icon_state = "rrust"
	walltype = "rrust"
	hardness = 15

/turf/simulated/wall/shuttle
	name = "wall"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "wall1"
	walltype = "shuttle"
	smooth = SMOOTH_FALSE

//sub-type to be used for interior shuttle walls
//won't get an underlay of the destination turf on shuttle move
/turf/simulated/wall/shuttle/interior/copyTurf(turf/T)
	if(T.type != type)
		T.ChangeTurf(type)
		if(underlays.len)
			T.underlays = underlays
	if(T.icon_state != icon_state)
		T.icon_state = icon_state
	if(T.icon != icon)
		T.icon = icon
	if(T.color != color)
		T.color = color
	if(T.dir != dir)
		T.dir = dir
	T.transform = transform
	return T

/turf/simulated/wall/shuttle/copyTurf(turf/T)
	. = ..()
	T.transform = transform

//why don't shuttle walls habe smoothwall? now i gotta do rotation the dirty way
/turf/simulated/wall/shuttle/shuttleRotate(rotation)
	var/matrix/M = transform
	M.Turn(rotation)
	transform = M

/turf/simulated/wall/invisible
	icon = 'icons/misc/invisible.dmi'

/turf/simulated/wall/wooden_m
	sheet_type = /obj/item/stack/sheet/mineral/wood
	name = "wooden wall"
	icon = 'craftable_wooden_wall.dmi'
	icon_state = "wall"

/turf/simulated/wall/wooden_m/try_decon(obj/item/weapon/W, mob/user, turf/T)
	if( istype(W,/obj/item/weapon/crowbar) )
		user << "You started to pull the nails out of board"
		playsound(src, 'sound/items/Crowbar.ogg', 100, 1)
		if(do_after(user, 30, target = src))
			user << "<span class='notice'>You remove the outer planks.</span>"
			dismantle_wall()

/turf/simulated/wall/wooden_m/dismantle_wall(devastated=0, explode=0)
	var/newgirder = break_wall()
	transfer_fingerprints_to(newgirder)
	for(var/obj/O in src.contents) //Eject contents!
		if(istype(O,/obj/structure/sign/poster))
			var/obj/structure/sign/poster/P = O
			P.roll_and_drop(src)
		else
			O.loc = src
	ChangeTurf(/turf/simulated/floor/plating/asteroid)

/turf/simulated/wall/wooden_m/break_wall()
	builtin_sheet.amount = 2
	builtin_sheet.loc = src
	return (new /obj/structure/girder/wood(src))