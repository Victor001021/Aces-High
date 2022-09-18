extends Node2D
func _ready():
	$AnimationPlayer.play("voltar")

func _input(event):
	if Input.is_action_just_pressed("enter"):
		yield(get_tree().create_timer(0.01), "timeout")
		get_tree().change_scene("res://cena_menu.tscn")
