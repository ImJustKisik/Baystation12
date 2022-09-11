/// Restores our verbs. It will only restore verbs allowed during lesser (monkey) form if we are not human
/mob/proc/make_changeling()
	if(!mind)
		return
	if(!mind.changeling)
		mind.changeling = new /datum/changeling(gender)
		mind.changeling.owner_mind = mind

	verbs += /datum/changeling/proc/EvolutionMenu
	add_language(LANGUAGE_CHANGELING_GLOBAL)

	if(!LAZYLEN(GLOB.changeling_power_instances))
		for(var/P in GLOB.changeling_powers)
			GLOB.changeling_power_instances += new P()

	// Code to auto-purchase free powers.
	for(var/datum/power/changeling/P in GLOB.changeling_power_instances)
		if(!P.genome_cost && !P.no_autobuy && !(P in mind.changeling.purchased_powers)) // Is it free, and we don't own it?
			mind.changeling.purchasePower(mind, P.name, 0, TRUE) // Purchase it. Don't remake our verbs, we're doing it after this.

	/*for(var/datum/power/changeling/P in mind.changeling.purchased_powers)
		if(P.isVerb)
			if(lesser_form && !P.allow_during_lesser_form)	continue
			if(!(P in src.verbs))
				src.verbs += P.verbpath*/ // Keeping this comment in case this functionality is restored in the future

	for(var/language in languages)
		mind.changeling.absorbed_languages |= language

	var/mob/living/carbon/human/H = src
	if(istype(H))
		var/datum/absorbed_dna/newDNA = new(H.real_name, H.dna, H.species.name, H.languages)
		mind.changeling.absorb_DNA(newDNA)

	return TRUE


/mob/proc/sting_can_reach(mob/M, sting_range = 1)
	if(M.loc == loc)
		return 1 //target and source are in the same thing
	if(!isturf(loc) || !isturf(M.loc))
		to_chat(src, SPAN_WARNING("We cannot reach \the [M] with a sting!"))
		return //One is inside, the other is outside something.
	// Maximum queued turfs set to 25; I don't *think* anything raises sting_range above 2, but if it does the 25 may need raising
	if(!AStar(loc, M.loc, /turf/proc/AdjacentTurfs, /turf/proc/Distance, max_nodes=25, max_node_depth=sting_range)) //If we can't find a path, fail
		to_chat(src, SPAN_WARNING("We cannot find a path to sting \the [M] by!"))
		return
	return TRUE

/obj/item/melee/arm_blade
	name = "armblade"
	desc = "A grotesque blade made out of bone and flesh that cleaves through people as a hot knife through butter."
	icon = 'infinity/icons/obj/changeling.dmi'
	icon_state = "arm_blade"
	item_state = "arm_blade"
	item_icons = list(
		slot_l_hand_str = 'infinity/icons/obj/changeling.dmi',
		slot_r_hand_str = 'infinity/icons/obj/changeling.dmi')
	item_state_slots = list(
		slot_l_hand_str = "arm_blade_lh",
		slot_r_hand_str = "arm_blade_rh")
	hitsound = 'infinity/sound/weapons/bloodyslice.ogg'
	w_class = 4
	force = 23
	siemens_coefficient = 0.4
	base_parry_chance = 40
	canremove = 0
	sharp = 1
	edge = 1
	anchored = TRUE
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	var/mob/living/creator

/obj/item/melee/arm_blade/dropped(var/mob/living/user)
	visible_message(SPAN_DANGER("With a sickening crunch, [user] reforms their armblade into an arm!"),
	SPAN_WARNING("You hear organic matter ripping and tearing!"))
	playsound(loc, 'sound/effects/blobattack.ogg', 30, 1)
	QDEL_IN(src, 1)

/obj/item/melee/arm_blade/Process()
	if(!creator || loc != creator || (creator.l_hand != src && creator.r_hand != src))
		// Tidy up a bit.
		if(istype(loc,/mob/living))
			var/mob/living/carbon/human/host = loc
			if(istype(host))
				for(var/obj/item/organ/external/organ in host.organs)
					for(var/obj/item/O in organ.implants)
						if(O == src)
							organ.implants -= src
			host.pinned -= src
			host.embedded -= src
			host.drop_from_inventory(src)
		QDEL_IN(src, 1)

/obj/item/melee/arm_blade/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return

	if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/D = target

		if(D.allowed(user) || !D.requiresID())
			return

		else if(D.locked)
			to_chat(user, SPAN_NOTICE("The airlock's bolts prevent it from being forced."))
			return

	else if(istype(target, /obj/structure/table))
		var/obj/structure/table/T = target
		T.break_to_parts()
