extends Node2D
var opcao


func _ready():
	opcao = 1
	ScriptGlobal.inimigos_destruidos = 0
	animacao()
	
func _process(_delta):
	pass
#	if opcao == 1:
#		$AnimationPlayer.play("iniciar")
#	else:
#		$Label.modulate = Color(1,1,1)
#	if opcao == 2:
#		$AnimationPlayer.play("como_jogar")
#	else:
#		$Label2.modulate = Color(1,1,1)
#	if opcao == 3:
#		$AnimationPlayer.play("configuracoes")
#	else:
#		$Label3.modulate = Color(1,1,1)
#
#	if opcao == 4:
#		$AnimationPlayer.play("sair")
#	else:
#		$Label4.modulate = Color(1,1,1)
#
	
	
#	if Input.is_action_just_pressed("ui_up")  and opcao >= 1:
#		if opcao == 1:
#			opcao = 4
#		else:
#			opcao -= 1
#		if ScriptGlobal.status_efeitos:
#			$AudioStreamPlayer.play()
#	if Input.is_action_just_pressed("ui_down") and opcao <= 4:
#		if opcao == 4:
#			opcao = 1
#		else:
#			opcao += 1
#		if ScriptGlobal.status_efeitos:
#			$AudioStreamPlayer.play()
func _input(event):
	if Input.is_action_pressed("enter"):
		$AudioStreamPlayer.play()
		if opcao == 1:
			get_tree().change_scene("res://cena_selecao.tscn")
		if opcao == 2:
			get_tree().change_scene("res://cena_como_jogar.tscn")
		if opcao == 3:
			get_tree().change_scene("res://cena_configuracao.tscn")
		if opcao == 4:
			get_tree().quit()
	if Input.is_action_just_pressed("ui_up")  and opcao >= 1:
			if opcao == 1:
				opcao = 4
			else:
				opcao -= 1
			if ScriptGlobal.status_efeitos:
				$AudioStreamPlayer.play()
			animacao()
	if Input.is_action_just_pressed("ui_down") and opcao <= 4:
		if opcao == 4:
			opcao = 1
		else:
			opcao += 1
		if ScriptGlobal.status_efeitos:
			$AudioStreamPlayer.play()
		animacao()

func animacao():
	if opcao == 1:
		$AnimationPlayer.play("iniciar")
	else:
		$Label.modulate = Color(1,1,1)
	if opcao == 2:
		$AnimationPlayer.play("como_jogar")
	else:
		$Label2.modulate = Color(1,1,1)
	if opcao == 3:
		$AnimationPlayer.play("configuracoes")
	else:
		$Label3.modulate = Color(1,1,1)
		
	if opcao == 4:
		$AnimationPlayer.play("sair")
	else:
		$Label4.modulate = Color(1,1,1)
		
