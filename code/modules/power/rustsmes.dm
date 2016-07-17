/obj/machinery/power/smes/wasteland
	name = "power storage unit"
	desc = "Rusty old SMES"
	capacity = 4e6
	var/brokentime = 0

/obj/machinery/power/smes/wasteland/process()
	..()
	if(prob(1) && !brokentime && outputting)
		outputting = 0
		brokentime = 5
		update_icon()

	if(brokentime >= 1)
		brokentime--

	if(brokentime == 1)
		outputting = 1
		update_icon()