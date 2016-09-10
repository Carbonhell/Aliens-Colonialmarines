/obj/machinery/modular_computer/console/preset
	// Can be changed to give devices specific hardware
	var/_has_id_slot = 0
	var/_has_printer = 0
	var/_has_battery = 0

/obj/machinery/modular_computer/console/preset/New()
	. = ..()
	if(!cpu)
		return
	cpu.install_component(new /obj/item/weapon/computer_hardware/processor_unit)

	if(_has_id_slot)
		cpu.install_component(new /obj/item/weapon/computer_hardware/card_slot)
	if(_has_printer)
		cpu.install_component(new /obj/item/weapon/computer_hardware/printer)
	if(_has_battery)
		cpu.install_component(new /obj/item/weapon/computer_hardware/battery(cpu, /obj/item/weapon/stock_parts/cell/computer/super))
	install_programs()

// Override in child types to install preset-specific programs.
/obj/machinery/modular_computer/console/preset/proc/install_programs()
	return



// ===== ENGINEERING CONSOLE =====
/obj/machinery/modular_computer/console/preset/engineering
	 console_department = "Engineering"
	 desc = "A stationary computer. This one comes preloaded with engineering programs."

/obj/machinery/modular_computer/console/preset/engineering/install_programs()
	cpu.hard_drive.store_file(new/datum/computer_file/program/power_monitor())
	cpu.hard_drive.store_file(new/datum/computer_file/program/alarm_monitor())

// ===== RESEARCH CONSOLE =====
/obj/machinery/modular_computer/console/preset/research
	 console_department = "Research"
	 desc = "A stationary computer. This one comes preloaded with research programs."

/obj/machinery/modular_computer/console/preset/research/install_programs()
	cpu.hard_drive.store_file(new/datum/computer_file/program/ntnetmonitor())
	cpu.hard_drive.store_file(new/datum/computer_file/program/nttransfer())
	cpu.hard_drive.store_file(new/datum/computer_file/program/chatclient())


// ===== COMMAND CONSOLE =====
/obj/machinery/modular_computer/console/preset/command
	 console_department = "Command"
	 desc = "A stationary computer. This one comes preloaded with command programs."
	 _has_id_slot = 1
	 _has_printer = 1

/obj/machinery/modular_computer/console/preset/command/install_programs()
	cpu.hard_drive.store_file(new/datum/computer_file/program/chatclient())
	cpu.hard_drive.store_file(new/datum/computer_file/program/card_mod())

// ===== CIVILIAN CONSOLE =====
/obj/machinery/modular_computer/console/preset/civilian
	 console_department = "Civilian"
	 desc = "A stationary computer. This one comes preloaded with generic programs."

/obj/machinery/modular_computer/console/preset/civilian/install_programs()
	cpu.hard_drive.store_file(new/datum/computer_file/program/chatclient())
	cpu.hard_drive.store_file(new/datum/computer_file/program/nttransfer())

