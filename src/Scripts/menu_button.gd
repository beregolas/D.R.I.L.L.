extends Control

var selected = false

@export var label_text = "": set = _set_label_text

func _ready():
	$Field/Label.text = label_text
	

func _set_label_text(new_value: String):
	label_text = new_value
	$Field/Label.text = label_text


func toggle_value(anim=true):
	self.selected = !self.selected
	if (anim):
		$Animation.play("select" if self.selected else "deselect")


func set_value(value, anim=true):
	self.selected = value
	if (anim):
		$Animation.play("select" if self.selected else "deselect")
