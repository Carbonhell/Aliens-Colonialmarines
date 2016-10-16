/obj/machinery/computer/shuttle/dropship1
	name = "dropship 1 console"
	circuit = /obj/item/weapon/circuitboard/computer/dropship1
	req_one_access = list(access_sulaco_bridge, access_marine_leaderprep)
	shuttleId = "marine1"
	possible_destinations = "planet1;sulaco1"

/obj/machinery/computer/shuttle/dropship2
	name = "dropship 2 console"
	circuit = /obj/item/weapon/circuitboard/computer/dropship2
	req_one_access = list(access_sulaco_bridge, access_marine_leaderprep)
	shuttleId = "marine2"
	possible_destinations = "planet2;sulaco2"

/obj/item/weapon/circuitboard/computer/dropship1
	name = "circuit board (Dropship 1)"
	build_path = /obj/machinery/computer/shuttle/dropship1

/obj/item/weapon/circuitboard/computer/dropship2
	name = "circuit board (Dropship 2)"
	build_path = /obj/machinery/computer/shuttle/dropship2
