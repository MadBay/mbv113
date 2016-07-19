/*
Program execurtes when it's name typed in command line. Return of program/execute will be shown on the screen.
Arguments are in L list, starts from 2nd index.

*/
/////some data structures
/datum/logentry/
	var/name = "log"
	var/text = " "

/datum/logentry/welcome
	name = "Greetings"
	text = {"Thank you for using ROBCO INDUSTRIES terminal. If you head any issues please call to your local ROBCO technical support"}
datum/logentry/testing
	name = "Testing_entry"
	text = {"If you are reading this something went wrong. Please call your system administrator"}


/datum/logentry/New()
	if(name == "log")
		name = "log[rand(1000)]"
////////////////actually programs
/datum/program
	var/name = "program name"
	var/pdesc = "description of a program"

/datum/program/proc/execute(var/obj/machinery/computer/console/C, var/list/L)
	return "0"
/////////////////////////HELP
/datum/program/help
	name = "help"
	pdesc = {"Displays list of possible commands or command manual. Type help %command name to read manual"}

/datum/program/help/execute(var/obj/machinery/computer/console/C, var/list/L)
	if(L[2] != " ")
		for(var/datum/program/P in C.commands_d)
			if(P.name == L[2])
				return P.pdesc
	else
		return "[list2text(C.commands_n, ", ")]<br>Type help %command name to read manual"
//////////////////////SHITTY TEST
/datum/program/test
	name = "test"

/datum/program/test/execute(var/obj/machinery/computer/console/C, var/list/L)
	return "test"
///////////////////////////////////LOG
/datum/program/log
	name = "log"
	pdesc = {"Provides access to log files. If called witout argument will show a list of existing logs
			  Possible arguments:<br>
			  read %log_name to read log<br>
			  write %log_name to create a new log"}
	var/logs = list(new /datum/logentry/welcome, new /datum/logentry/testing)
	var/mode = 1
	var/datum/logentry/curlog = null

/datum/program/log/execute(var/obj/machinery/computer/console/C, var/list/L)
	if(mode == 2)
		C.content = ""
		if(L[1] == "finish")
			mode = 1
			C.curprogram = null
			curlog = null
			return "Saved"

		C.content= {"Now writing [curlog.name] <br>type a line to add it to file, type "finish" to end modifying<br>----------------------------------------------------------------<br>"}
		for(var/i = 1; i <= L.len; i++)
			curlog.text += L[i]
			curlog.text += " "
		curlog.text += "<br>"
		return curlog.text

	if(L[2] == "read")
		for(var/datum/logentry/E in logs)
			if(E.name == L[3])
				return E.text
		return "Error: file not found"

	if(L[2] == "write")
		if(L.len<3)
			return "Error: invalid filename"
		C.curprogram = src
		mode = 2
		var/modify = 0
		for(var/datum/logentry/LE in logs)
			if(LE.name == L[3])
				curlog = LE
				modify = 1
		if(!modify)
			var/datum/logentry/E = new /datum/logentry/
			E.name = L[3]
			logs+=E
			curlog = E
		return {"Now writing [curlog.name] <br>type a line to add it to file, type "finish" to end modifying<br>----------------------------------------------------------------<br>"}

	else
		var/S = ""
		for(var/datum/logentry/E in logs)
			S += E.name
			S += " \n"
		return S
////////////////////////////CLEAR
/datum/program/clear
 	name = "clear"
 	pdesc = "Clears the terminal's screen"

/datum/program/clear/execute(var/obj/machinery/computer/console/C, var/list/L)
 	C.content = ""
 	return ""