// Base type, do not use.
/obj/structure/lift
	name = "turbolift control component"
	icon = 'icons/obj/turbolift.dmi'
	anchored = TRUE
	density = FALSE
	layer = ABOVE_OBJ_LAYER

	var/datum/turbolift/lift

/obj/structure/lift/set_dir(var/newdir)
	. = ..()
	pixel_x = 0
	pixel_y = 0
	if(dir & NORTH)
		pixel_y = -32
	else if(dir & SOUTH)
		pixel_y = 37
	else if(dir & EAST)
		pixel_x = -32
	else if(dir & WEST)
		pixel_x = 32

/obj/structure/lift/proc/pressed(var/mob/user)
	if(!istype(user, /mob/living/silicon))
		if(user.a_intent == I_HURT)
			user.visible_message("<span class='danger'>\The [user] hammers on the lift button!</span>")
		else
			user.visible_message("<span class='notice'>\The [user] presses the lift button.</span>")


/obj/structure/lift/New(var/newloc, var/datum/turbolift/_lift)
	lift = _lift
	return ..(newloc)

/obj/structure/lift/attack_ai(var/mob/user)
	return attack_hand(user)

/obj/structure/lift/attack_generic(var/mob/user)
	return attack_hand(user)

/obj/structure/lift/attack_hand(var/mob/user)
	return interact(user)

/obj/structure/lift/interact(var/mob/user)
	if(!lift.is_functional())
		return 0
	return 1
// End base.

// Button. No HTML interface, just calls the associated lift to its floor.
/obj/structure/lift/button
	name = "elevator button"
	desc = "A call button for an elevator. Be sure to hit it three hundred times."
	icon_state = "button"
	var/light_up = FALSE
	var/datum/turbolift_floor/floor
	mouse_opacity = 2 //No more eyestrain aiming at tiny pixels

/obj/structure/lift/button/Destroy()
	if(floor && floor.ext_panel == src)
		floor.ext_panel = null
	floor = null
	return ..()

/obj/structure/lift/button/proc/reset()
	light_up = FALSE
	update_icon()

/obj/structure/lift/button/interact(var/mob/user)
	if(!..())
		return
	playsound(src, 'infinity/sound/SS2/effects/buttons/butelev.wav', 50)//inf
	light_up()
	pressed(user)
	if(floor == lift.current_floor)
		lift.open_doors()
		spawn(3)
			reset()
		return
	lift.queue_move_to(floor)

/obj/structure/lift/button/proc/light_up()
	light_up = TRUE
	update_icon()

/obj/structure/lift/button/on_update_icon()
	if(light_up)
		icon_state = "button_lit"
	else
		icon_state = initial(icon_state)

// End button.


// Panel. Lists floors (TGUI), moves with the elevator, schedules a move to a given floor.
/obj/structure/lift/panel
	name = "elevator control panel"
	icon_state = "panel"
	mouse_opacity = 2 //No more eyestrain aiming at tiny pixels

/obj/structure/lift/panel/attack_ghost(var/mob/user)
	return interact(user)

/obj/structure/lift/panel/interact(mob/user)
	tgui_interact(user)

/obj/structure/lift/panel/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ElevatorPanel", "Lift Panel")
		ui.open()

/obj/structure/lift/panel/tgui_data(mob/user)
	. = list()
	.["areDoorsOpen"] = lift.doors_are_open()
	.["current"] = list(
		"label" = lift.current_floor.label,
		"name" = lift.current_floor.name,
		"ref" = REF(lift.current_floor),
	)
	.["options"] = list()

	for(var/datum/turbolift_floor/floor in lift.floors)
		.["options"] += list(list(
			"label" = floor.label,
			"name" = floor.name,
			"queued" = (floor in lift.queued_floors),
			"ref" = REF(floor),
		))

/obj/structure/lift/panel/tgui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if (..())
		return TRUE

	switch(action)
		if("move_to_floor")
			lift.queue_move_to(locate(params["ref"]))
			. = TRUE
		if("open_doors")
			lift.open_doors()
			. = TRUE
		if("close_doors")
			lift.close_doors()
			. = TRUE
		if("emergency_stop")
			lift.emergency_stop()
			. = TRUE

	if(.)
		pressed(usr)

// End panel.
