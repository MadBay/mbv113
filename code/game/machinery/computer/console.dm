
/obj/machinery/computer/console
	name = "Console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "terminal"
	var/pass = null
	var/myvar = null
	var/endline = ""
	var/datum/program/curprogram = null
	var/style = {"
		<style type="text/css">
		body
		{
			background-color:#222222;
		}
		input\[type=text]
			{
			background-color: #222222;
			color: #5bfd67;
			border: 0px
		}
		form{
		position:absolute;
		top:570px;
		}
		p{
		margin:3px;
		padding:0px;
		}
		#content{
		height: 400px;
		max-height:400px;
		overflow: hidden;
		word-wrap: break-word;
		}
		</style>"}
	var/content = ""
	var/list/commands_n = list()
	var/commands_types = list(/datum/program/help,/datum/program/log, /datum/program/clear)
	var/list/commands_d = list()

/obj/machinery/computer/console/update_icon()
	if(stat & NOPOWER)
		icon_state = "terminal_off"
	else if(stat & BROKEN)
		icon_state = "terminal_broken"
	else
		icon_state = "terminal"

/obj/machinery/computer/console/New()
	for(var/P in commands_types)
		var/datum/program/P1 = new P
		commands_d += P1
		commands_n += P1.name
	..()

/obj/machinery/computer/console/attack_hand(mob/living/user)
	if(..())
		return
	endline = {"<form name="consoleinput" action="byond://?src=\ref[src]\ method="get">
		<input type="hidden" name="src" value="\ref[src]">
		><input id = "consoleinput_text" type="text" name="command" maxlength="75" size="75" autofocus>
		<input type="submit" value="Enter"></form></body>
		<script type="text/javascript">
  			var block = document.getElementById("content");
  			block.scrollTop = block.scrollHeight;
		</script>"}

	var/dat = ""
	dat += style
	dat += "<body scroll=\"no\">"
	dat += "<center><h3><b>ROBCO INDUSTRIES UNIFIED OPERATING SYSTEM</b></h3></center>"
	dat += "<center><h3><b>COPYRIGHT 2075-2077 ROBCO INDUSTRIES</b></h3></center><br><hr>"
	dat += "<div id=\"content\">"
	dat += content
	dat +="<div id=\"scrollhack\"></div></div>"
	dat += endline
	var/datum/browser/popup = new(user, "robco terminal", name, 600, 600)
	popup.set_content(dat)
	popup.add_stylesheet("console",'html/browser/console.css')
	popup.window_options = "focus=0;can_close=1;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1;"
	popup.open()
	return

/obj/machinery/computer/console/Topic(href, href_list)
	if(..())
		return
	if(href_list["command"])
		href_list["command"] = strip_html(href_list["command"])
		content += "<p>>[href_list["command"]]\n</p>"
		var/list/commands = text2list(href_list["command"], " ")
		if(commands.len < 2)
			commands += " "
		if(curprogram != null)
			content += curprogram.execute(src, commands)
		else
			for(var/datum/program/P in commands_d)
				if(P.name == commands[1])

					content += "<p>"
					content += P.execute(src, commands)
					content += "\n</p>"
	updateUsrDialog()