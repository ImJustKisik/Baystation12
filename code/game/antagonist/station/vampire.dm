GLOBAL_DATUM_INIT(vampires, /datum/antagonist/vampire, new)

/datum/antagonist/vampire
	id = MODE_VAMPIRE
	role_text = "Vampire"
	role_text_plural = "Vampires"
	feedback_tag = "vampire_objective"
	restricted_jobs = list(/datum/job/captain, /datum/job/hos, /datum/job/hop,
							/datum/job/rd, /datum/job/chief_engineer, /datum/job/cmo,
							/datum/job/iaa, /datum/job/officer, /datum/job/warden, /datum/job/detective )
	minimum_player_age = 7


	blacklisted_jobs = list(/datum/job/ai, /datum/job/cyborg, /datum/job/chaplain)
	welcome_text = "<hr><u>Вы - Вампир</u> существо, которое после экспериментов с магией крови, \
	или после обращения самим вампиром, было осквернено Вуалью и одарено силами за гранью человеческого понимания.\
	Как существо ночи, вы потеряли свою потребность в еде и воде, \
	но вместо этого вас гложет неутолимая жажда крови для того, \
	чтобы поддерживать своё существование и стать более могущественным, \
	приблизившись к использованию всей силы Вуали. \
	Используйте команду "<b>Vampire Help</b>" для навигации по способностям вампира"
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	antaghud_indicator = "hudvampire"


/datum/antagonist/vampire/update_antag_mob(datum/mind/player)
	..()
	player.current.make_vampire()


/datum/antagonist/vampire/can_become_antag(datum/mind/player, ignore_role)
	if(..())
		if(player.current)
			if(ishuman(player.current))
				var/mob/living/carbon/human/H = player.current
				if(H.isSynthetic())
					return 0
				if(H.species.species_flags & SPECIES_FLAG_NO_SCAN)
					return 0
				return 1
			else if(isnewplayer(player.current))
				if(player.current.client && player.current.client.prefs)
					var/datum/species/S = all_species[player.current.client.prefs.species]
					if(S && (S.species_flags & SPECIES_FLAG_NO_SCAN))
						return 0
					if(player.current.client.prefs.organ_data[BP_CHEST] == "cyborg") // Full synthetic.
						return 0
					return 1
 	return 0
