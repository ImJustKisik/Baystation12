/datum/shuttle/autodock/overmap/snz
	name = "SNZ Speedboat"
	warmup_time = 15
	current_location = "nav_dock_snz"
	range = 2
	shuttle_area = /area/ship/snz
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_NONE
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/merc

/obj/machinery/computer/shuttle_control/explore/away_farfleet/snz
	name = "SNZ Shuttle control console"
	req_access = list(access_away_iccgn)
	shuttle_tag = "SNZ Speedboat"

/obj/effect/overmap/visitable/ship/landable/snz
	scanner_name = "SNZ-250"
	scanner_desc = @{"[i]Registration[/i]: ICCGN Speedboat
[i]Class[/i]: Shuttle
[i]Transponder[/i]: Transmitting (MIL), ICCG
[b]Notice[/b]: SNZ-250 Speedboat. Space and atmosphere assault craft. The standard mass military production model of the Shipyards of Novaya Zemlya."}
	shuttle = "SNZ Speedboat"
	fore_dir = WEST
	color = "#ff7300"
	vessel_mass = 250
	vessel_size = SHIP_SIZE_TINY

/area/ship/snz
	name = "\improper SNZ"
	icon_state = "iccgn-snz-250"
	base_turf = /turf/simulated/floor
	requires_power = 1
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED

/obj/effect/shuttle_landmark/snz/start
	name = "Dock"
	landmark_tag = "nav_dock_snz"
	base_area = /area/ship/farfleet/command/snz_exterior_dock
	base_turf = /turf/simulated/floor/reinforced
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/shuttle_landmark/snz/altdock
	name = "Docking Port"
	landmark_tag = "nav_dock_iggc_snz"


	////////
	//TAGS//
	////////

/*/obj/effect/shuttle_landmark/reaper/hangar
	name = "Reaper Hangar"
	landmark_tag = "nav_hangar_reaper"
	base_area = /area/ship/patrol/command/hangar
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/reaper/transit
	name = "In transit"
	landmark_tag = "nav_transit_reaper"

/obj/effect/shuttle_landmark/reaper/tdock
	name = "SEV Torch Dock"
	landmark_tag = "nav_reaper_dock"
	docking_controller = "nuke_shuttle_dock_airlock" */
