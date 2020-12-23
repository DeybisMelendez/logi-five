tool
extends TextureButton
export var text = "" setget set_text, get_text

func set_text(t):
	$Label.text = t

func get_text():
	return $Label.text
