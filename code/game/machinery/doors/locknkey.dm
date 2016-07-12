/proc/checkkey(var/id,var/obj/item/O)
	if(istype(O,/obj/item/weapon/doorkey))
		var/obj/item/weapon/doorkey/K = O
		if(id == K.id)
			return 1
		return 0
	if(istype(O,/obj/item/weapon/keyring))
		var/obj/item/weapon/keyring/K = O
		for(var/obj/item/weapon/doorkey/DK in K)
			if(id == DK.id)
				return 1
	return 0

/obj/item/weapon/doorkey
	name = "key"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "key"
	var/id = 0
	w_class = 1
	slot_flags = SLOT_BELT | SLOT_EARS

/obj/item/weapon/doorkey/attack_self(mob/user)
	if(usr.stat || !usr.canmove || usr.restrained())
		return
	if(!ishuman(usr))
		return
	var/n_name = stripped_input(usr, "What would you like to label the key?", "Key renaming", name, MAX_NAME_LEN)
	name = n_name

/obj/item/weapon/doorkey/attackby(obj/item/I, mob/user, params)
	if(istype(I,/obj/item/weapon/doorkey))
		var/obj/item/weapon/doorkey/K1 = I
		var/obj/item/weapon/doorkey/K2 = src
		var/obj/item/weapon/keyring/K = new /obj/item/weapon/keyring (src.loc)
		K.keys = list(K1,K2)
		user.remove_from_mob(K1)
		user.remove_from_mob(K2)
		K1.loc = null
		K2.loc = null
		K.keys_n = K.getnumber()
		user.put_in_hands(K)

/obj/item/weapon/keyring
	name = "Keyring"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "keyring"
	var/keys_n = 1
	var/list/keys
/obj/item/weapon/keyring/proc/getnumber()
	var/number = 0
	for(var/obj/item/weapon/doorkey/K1 in keys)
		number++
	return number
/obj/item/weapon/keyring/attack_self(mob/user)
	var/obj/item/weapon/doorkey/K = input(user, "Select a key","Keys", null) as obj in keys
	if(K)
		var/obj/item/weapon/doorkey/K1 = K
		keys-=K1
		user.put_in_hands(K1)
	keys_n = getnumber()
	if(keys_n < 1)
		qdel(src)
/obj/item/weapon/keyring/attackby(obj/item/I, mob/user, params)
	if(istype(I,/obj/item/weapon/doorkey))
		var/obj/item/weapon/doorkey/K1 = I
		src.keys += K1
		user.remove_from_mob(K1)
		K1.loc = null
		keys_n = getnumber()
/obj/item/weapon/lock
	name = "lock"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "lock"
	var/id = 0
