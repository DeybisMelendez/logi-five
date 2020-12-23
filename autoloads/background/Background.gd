extends TextureRect

func change_scene(scn):
	Audio.play("Select")
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer,"animation_finished")
	var _i = get_tree().change_scene(scn)
	$AnimationPlayer.play("fade_out")
	get_tree().paused = false

func reload():
	Audio.play("Select")
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer,"animation_finished")
	var _i = get_tree().reload_current_scene()
	$AnimationPlayer.play("fade_out")
	get_tree().paused = false
