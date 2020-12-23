extends TextureRect

func change_scene(scn):
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(scn)
	$AnimationPlayer.play("fade_out")
	get_tree().paused = false

func reload():
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer,"animation_finished")
	get_tree().reload_current_scene()
	$AnimationPlayer.play("fade_out")
	get_tree().paused = false
