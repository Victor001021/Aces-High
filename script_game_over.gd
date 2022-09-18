extends Node2D

var opcao = 1

func _ready():
	ScriptGlobal.vida_terra = ScriptGlobal.vida_terra_padrao
	ScriptGlobal.vida_personagem = ScriptGlobal.vida_personagem_padrao
	
func _process(delta):
	if opcao == 1:
		$AnimationPlayer.play("voltar")
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene("res://cena_menu.tscn")
