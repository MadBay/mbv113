////WASTELAND LOOT/////////////
/obj/effect/landmark/wastelandloot
	name = "wasteland_general"
	var/list/poor
	var/list/common
	var/list/rare
	var/list/ultrarare
	var/max = 100
	var/item_amount = 1

/obj/effect/landmark/wastelandloot/New()
	poor = file2list("tools/lootlists/[name]/poor.txt")
	common = file2list("tools/lootlists/[name]/common.txt")
	rare = file2list("tools/lootlists/[name]/rare.txt")
	ultrarare = file2list("tools/lootlists/[name]/ultrarare.txt")
	var/x
	for(var/i = 0;i<item_amount;i++)
		x = rand(1,max)
		var/S
		switch(x)
			if(1 to 59)
				S = pick(poor)
			if(60 to 92)
				S = pick(common)
			if(93 to 97)
				S = pick(rare)
			if(98 to 100)
				S = pick(ultrarare)
		new S(src.loc)
	qdel(src)
//////////////////////////////////////////
/obj/effect/landmark/wastelandweapon
	name = "weapon"
/obj/effect/landmark/martfood
	name = "superdupermart_food"
