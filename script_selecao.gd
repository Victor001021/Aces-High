extends Node2D


var opcao = 1
var opcao_anterior
var voltar = false




func _process(delta):

	
	$Personagens/personagem1.hide()
	$Personagens/personagem2.hide()
	$Personagens/personagem3.hide()
	$Personagens/personagem4.hide()
	
	if opcao >= 1 and opcao <= 2:
		$Personagens/personagem1.show()
		$Personagens/personagem2.show()
	elif opcao >= 3 and opcao <= 4:
		$Personagens/personagem3.show()
		$Personagens/personagem4.show()
		
	if opcao == opcao_anterior and voltar:
		$AnimationPlayer.play("voltar")
	else:
		$Label2.modulate = Color(1,1,1)
		
	if opcao == 1 and !voltar:
		$AnimationPlayer.play("personagem1")
	else:
		$Personagens/personagem1.modulate = Color(1,1,1)
	if opcao == 2 and !voltar:
		$AnimationPlayer.play("personagem2")
	else:
		$Personagens/personagem2.modulate = Color(1,1,1)
	if opcao == 3 and !voltar:
		$AnimationPlayer.play("personagem3")
	else:
		$Personagens/personagem3.modulate = Color(1,1,1)
	if opcao == 4 and !voltar:
		$AnimationPlayer.play("personagem4")
	else:
		$Personagens/personagem4.modulate = Color(1,1,1)

func _input(event):
	if Input.is_action_just_pressed("ui_left"):
		if opcao == 1:
			opcao = 4
		else:
			opcao -= 1
		if ScriptGlobal.status_efeitos:
			$AudioStreamPlayer.play()
	if Input.is_action_just_pressed("ui_right"):
		if opcao == 4:
			opcao = 1
		else:
			opcao += 1
		if ScriptGlobal.status_efeitos:
			$AudioStreamPlayer.play()
	if Input.is_action_pressed("ui_left"):
		$seta3.modulate = Color(0,0,0)
	else:
		$seta3.modulate = Color(1,1,1)
		
	if Input.is_action_pressed("ui_right"):
		$seta4.modulate = Color(0,0,0)
	else:
		$seta4.modulate = Color(1,1,1)
	if Input.is_action_just_pressed("ui_down"):
		opcao_anterior = opcao
		opcao = opcao_anterior
		voltar = true
	if voltar:
		if Input.is_action_just_pressed("ui_up"):
			opcao = opcao_anterior
			voltar = false
			
	if Input.is_action_just_pressed("enter"):
		yield(get_tree().create_timer(0.02), "timeout")
		print(ScriptGlobal.nave_selecionada)
		if voltar:
			voltar = false
			get_tree().change_scene("res://cena_menu.tscn")
		elif opcao == 1:
			ScriptGlobal.nave_selecionada = 1
			get_tree().change_scene("res://cena_fase.tscn")			
		elif opcao == 2:
			ScriptGlobal.nave_selecionada = 2
			get_tree().change_scene("res://cena_fase.tscn")
		elif opcao == 3:
			ScriptGlobal.nave_selecionada = 3
			get_tree().change_scene("res://cena_fase.tscn")
		elif opcao == 4:
			ScriptGlobal.nave_selecionada = 4
			get_tree().change_scene("res://cena_fase.tscn")
		

