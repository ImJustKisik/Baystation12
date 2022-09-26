#define WEBHOOK_SUBMAP_LOADED_ICCGN	"webhook_submap_ICCGN"

/obj/effect/submap_landmark/joinable_submap/away_iccgn_farfleet
	name = "Farfleet Recon Ship"
	archetype = /decl/submap_archetype/away_iccgn_farfleet

/decl/submap_archetype/away_iccgn_farfleet
	descriptor = "ICCGN Farfleet Recon Ship"
	map = "Recon Ship"
	crew_jobs = list(
		/datum/job/submap/iccgn_captain,
		/datum/job/submap/iccgn_droptrooper,
		/datum/job/submap/iccgn_sergeant,
		/datum/job/submap/iccgn_medic,
		/datum/job/submap/iccgn_gunner
	)
	call_webhook = WEBHOOK_SUBMAP_LOADED_ICCGN

/obj/effect/submap_landmark/spawnpoint/away_iccg
	name = "Army SCGSO Trooper"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/away_iccg/sergeant
	name = "ICCGN Droptroops Sergeant "

/obj/effect/submap_landmark/spawnpoint/away_iccg/captain
	name = "Farfleet Captain"

/obj/effect/submap_landmark/spawnpoint/away_iccg/droptrooper
	name = "ICCGN Droptrooper"

/obj/effect/submap_landmark/spawnpoint/away_iccg/medic
	name = "Farfleet Medic"

/obj/effect/submap_landmark/spawnpoint/away_iccg/gunner
	name = "Ordnance Specialist"

/* ACCESS
 * =======
 */

/var/const/access_away_iccgn = "ACCESS_ICCGN"
/var/const/access_away_iccgn_droptroops = "ACCESS_ICCGN_DROPTROOPS"
/var/const/access_away_iccgn_sergeant = "ACCESS_ICCGN_SERGEANT"
/var/const/access_away_iccgn_captain = "ACCESS_ICCGN_CAPTAIN"

/datum/access/access_away_iccgn
	id = access_away_iccgn
	desc = "ICCGN Main"
	region = ACCESS_REGION_NONE

/datum/access/access_away_iccgn_droptroops
	id = access_away_iccgn_droptroops
	desc = "ICCGN Droptroops"
	region = ACCESS_REGION_NONE

/datum/access/access_away_iccgn_sergeant
	id = access_away_iccgn_sergeant
	desc = "ICCGN Sergeant"
	region = ACCESS_REGION_NONE

/datum/access/access_away_iccgn_captain
	id = access_away_iccgn_captain
	desc = "ICCGN Captain"
	region = ACCESS_REGION_NONE

/obj/item/card/id/awayiccgn/fleet
	color = COLOR_GRAY40
	detail_color = "#447ab1"
	access = list(access_away_iccgn)

/obj/item/card/id/awayiccgndroptroops
	color = "#b10309c2"
	detail_color = "#000000"
	access = list(access_away_iccgn, access_away_iccgn_droptroops)

/obj/item/card/id/awayiccgn/ops/sergeant
	access = list(access_away_iccgn, access_away_iccgn_droptroops, access_away_iccgn_sergeant)
	extra_details = list("goldstripe")

/obj/item/card/id/awayiccgn/fleet/captain
	access = list(access_away_iccgn, access_away_iccgn_droptroops, access_away_iccgn_sergeant, access_away_iccgn_captain)
	extra_details = list("goldstripe")

/* JOBS
 * =======
 */

/datum/job/submap/iccgn_droptrooper
	title = "ICCG Droptrooper"
	total_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/iccgn_droptroops
	supervisors = "sergeant"
	loadout_allowed = TRUE
	is_semi_antagonist = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа разведывательного корабля Флота Дальнего Плавания ГКК, вы - член прикоммандированного к нему отряда Космодесантных войск ГКК. \
	По данным бортового компьютера, в данном регионе могут потенциально находиться цели вашей разведывательной экседиции.\
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками, или вступать в огневой контакт с кораблями или войсками ЦПСС без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы атакованы противником, терпите бедствие или на вашем судне аварийная ситуация."
	required_language = LANGUAGE_HUMAN_RUSSIAN
	whitelisted_species = list(SPECIES_HUMAN)
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_BASIC,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_EVA = SKILL_BASIC)
	access = list(access_away_iccgn, access_away_iccgn_droptroops)
	//required_role = list("Sub-Lieutenant", "Ensign")

/datum/job/submap/iccgn_sergeant
	title = "ICCG Droptrooper Sergeant"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/iccgn_sergeant
	supervisors = "recon captain, command of the Farfleet Recon Squadron , ICCGN"
	loadout_allowed = TRUE
	is_semi_antagonist = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа разведывательного корабля Флота Дальнего Плавания ГКК, вы - командир прикоммандированного к нему отряда Космодесантных войск ГКК. \
	По данным бортового компьютера, в данном регионе могут потенциально находиться цели вашей разведывательной экседиции.\
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками, или вступать в огневой контакт с кораблями или войсками ЦПСС без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы атакованы противником, терпите бедствие или на вашем судне аварийная ситуация."
	required_language = LANGUAGE_HUMAN_RUSSIAN
	whitelisted_species = list(SPECIES_HUMAN)
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_BASIC,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_PILOT = SKILL_ADEPT,
					 SKILL_EVA = SKILL_BASIC)
	access = list(access_away_iccgn, access_away_iccgn_droptroops, access_away_iccgn_sergeant)
	//required_role = list("Sub-Lieutenant", "Ensign")

/datum/job/submap/iccgn_captain
	title = "Farfleet Captain"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/iccgn_captain
	supervisors = "command of the Farfleet Recon Squadron , ICCGN"
	loadout_allowed = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Будучи одним из членов экипажа разведывательного корабля Флота Дальнего Плавания ГКК, вы - капитан разведывательного корабля. \
	По данным бортового компьютера, в данном регионе могут потенциально находиться цели вашей разведывательной экседиции.\
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками, или вступать в огневой контакт с кораблями или войсками ЦПСС без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы атакованы противником, терпите бедствие или на вашем судне аварийная ситуация."
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_BASIC,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_PILOT = SKILL_ADEPT,
					 SKILL_EVA = SKILL_BASIC)
	access = list(access_away_iccgn, access_away_iccgn_droptroops, access_away_iccgn_sergeant, access_away_iccgn_captain)
	//required_role = null

/datum/job/submap/iccgn_medic
	title = "Farfleet Medic"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/iccgn_medic
	loadout_allowed = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа разведывательного корабля Флота Дальнего Плавания ГКК, ваша задача состоит в медицинской поддержке экипажа. \
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками, или вступать в огневой контакт с кораблями или войсками ЦПСС без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы атакованы противником, терпите бедствие или на вашем судне аварийная ситуация."
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_ADEPT,
					 SKILL_MEDICAL = SKILL_EXPERT,
					 SKILL_ANATOMY = SKILL_BASIC,
					 SKILL_CHEMISTRY = SKILL_BASIC,
					 SKILL_EVA = SKILL_BASIC)
	access = list(access_away_iccgn)

/datum/job/submap/iccgn_gunner
	title = "Ordnance Technician"
	total_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/iccgn_gunner
	supervisors = "captain"
	loadout_allowed = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа разведывательного корабля Флота Дальнего Плавания ГКК, ваша задача состоит в ведении огня из ракетных установок, пилотирования корабля, поддержании работоспособности судна и экипировки экипажа. \
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками, или вступать в огневой контакт с кораблями или войсками ЦПСС без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы атакованы противником,  терпите бедствие или на вашем судне аварийная ситуация."
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_ADEPT,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_PILOT = SKILL_ADEPT,
					 SKILL_EVA = SKILL_ADEPT,
					 SKILL_CONSTRUCTION = SKILL_ADEPT,
					 SKILL_ELECTRICAL = SKILL_ADEPT,
					 SKILL_ATMOS  = SKILL_BASIC,
					 SKILL_ENGINES = SKILL_ADEPT,
					 SKILL_DEVICES = SKILL_BASIC)
	access = list(access_away_iccgn)


/* BRANCH & RANKS
 * =======

/datum/mil_branch/scgdf
	name = "Sol Central Government Defence Forces"
	name_short = "SCGDF"
	email_domain = "sol.gov"

	rank_types = list(/datum/mil_rank/skrell_fleet)
	spawn_rank_types = list(/datum/mil_rank/skrell_fleet)

/datum/mil_rank/skrell_fleet
	name = "NULL"

/datum/job/submap/sentinel_crew/equip(var/mob/living/carbon/human/H, var/alt_title, var/datum/mil_branch/branch, var/datum/mil_rank/grade)
	. = ..(H, alt_title, branch, grade)

	var/milbranches = list(
		"Malish-Katish" = list(
			"Mero'ta-Ketish",
			"Toglo'i-Ketish"
		),
		"Kanin-Katish" = list(
			"Xiqarr-Ketish",
			"Mero'tol-Ketish",
			"Goxo'i-Ketish"
		),
		"Raskinta-Katish" = list(
			"Me'kerr-Ketish",
			"Qi'kerr-Ketish",
			"Me'xoal-Ketish"
		)
	)

	var/milbranch = input(H, "What was your branch before SOCOM?", "SCGDF Branch") as null|anything in milbranches
	if(milbranch)
		var/milsubbranch = input(H, "What is your assignment now?", "SCGDF Assignment") as null|anything in milbranches[milbranch]
		var/obj/item/card/id/C = H.wear_id
		if(istype(C))
			C.assignment = milsubbranch
*/

/* OUTFITS
 * =======
 */

#define ICCGN_OUTFIT_JOB_NAME(job_name) ("ICCGN Recon Craft - Job - " + job_name)

/decl/hierarchy/outfit/job/iccgn
	hierarchy_type = /decl/hierarchy/outfit/job/iccgn
	uniform = /obj/item/clothing/under/terran/navy/utility
	shoes = /obj/item/clothing/shoes/terran
	l_ear = /obj/item/device/radio/headset/away_iccg_recon
	l_pocket = /obj/item/device/radio
	r_pocket = /obj/item/crowbar/prybar
	suit_store = /obj/item/tank/oxygen
	id_types = list(/obj/item/card/id/farfleet/fleet)
	id_slot = slot_wear_id
	pda_type = null
	belt = null
	back = /obj/item/storage/backpack/satchel/pocketbook/navy
	backpack_contents = null
	flags = OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/iccgn_droptroops
	name = ICCGN_OUTFIT_JOB_NAME("Droptrooper")
	head = /obj/item/clothing/head/terran/beret/grey
	uniform = /obj/item/clothing/under/solgov/utility/army/urban/away_solpatrol
	id_types = list(/obj/item/card/id/farfleet/droptroops)
	gloves = /obj/item/clothing/gloves/thick/combat/marine

/decl/hierarchy/outfit/job/iccgn_sergeant
	name = ICCGN_OUTFIT_JOB_NAME("Droptroops Sergeant")
	head = /obj/item/clothing/head/terran/beret
	uniform = /obj/item/clothing/under/solgov/utility/army/urban/away_solpatrol/captain
	id_types = list(/obj/item/card/id/awaycavalry/ops/captain)
	gloves = /obj/item/clothing/gloves/thick/combat/marine

/decl/hierarchy/outfit/job/iccgn_gunner
	name = ICCGN_OUTFIT_JOB_NAME("Ordnance Technician")
	head = /obj/item/clothing/head/terran/navy/service
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering/away_solpatrol
	belt = /obj/item/storage/belt/holster/security/away_solpatrol
	gloves = /obj/item/clothing/gloves/insulated/black

/decl/hierarchy/outfit/job/iccgn_medic
	name = ICCGN_OUTFIT_JOB_NAME("Doctor")
	uniform = /obj/item/clothing/head/terran/navy/service
	belt = /obj/item/storage/belt/holster/security/away_solpatrol
	gloves = /obj/item/clothing/gloves/latex/nitrile

/decl/hierarchy/outfit/job/iccgn_captain
	name = ICCGN_OUTFIT_JOB_NAME("Lieutenant Commander")
	head = /obj/item/clothing/head/terran/navy/service/command
	uniform = /obj/item/clothing/under/solgov/utility/fleet/officer/command/commander/away_solpatrol
	belt = /obj/item/storage/belt/holster/security/away_solpatrol
	id_types = list(/obj/item/card/id/awayiccgn/fleet/captain)
	gloves = /obj/item/clothing/gloves/terran

#undef ICCGN_OUTFIT_JOB_NAME
#undef WEBHOOK_SUBMAP_LOADED_ICCGN
