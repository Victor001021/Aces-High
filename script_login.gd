extends Node2D


var opcao = 1
var falhou = false

func _process(delta):
	
	if ScriptGlobal.traduzir:
		$senha.rect_global_position.x = 264
		$Label5.rect_global_position.x = 456
	else:
		$senha.rect_global_position.x = 288
		$Label5.rect_global_position.x = 476
		
	
	
	if opcao == 1:
		$txtEmail.grab_focus()
	else:
		$txtEmail.release_focus()
	if opcao == 2:
		$txtSenha.grab_focus()
	else:
		$txtSenha.release_focus()
	if opcao == 3:
		$Button.grab_focus()
	else:
		$Button.release_focus()	

		
	if opcao == 3 and !falhou:
		$AnimationPlayer.play("entrar")
	else:
		$Button.modulate = Color(1,1,1)
		
	if opcao == 4:
		$AnimationPlayer.play("criar")
	else:
		$Label2.modulate = Color(1,1,1)
	
func _input(event):
	if !falhou:
		if Input.is_action_just_pressed("ui_down"):
			if opcao == 4:
				opcao = 1
			else:
				opcao += 1
		if Input.is_action_just_pressed("ui_up"):
			if opcao == 1:
				opcao = 4
			else:
				opcao -= 1
		
		if Input.is_action_just_pressed("TAB"):
			if opcao <= 4:
				if opcao == 4:
					opcao = 1
				else:
					opcao += 1
		if Input.is_action_just_pressed("enter"):
			if opcao == 4:
				get_tree().change_scene("res://cena_conta.tscn")
		
	

func _on_Button_pressed():
	var url = "http://uni9jogosdigitais.freevar.com/cadastro/consultar.php?";
	var data = "email=" + $txtEmail.text + "&senha=" + $txtSenha.text;
	var headers = []
	var use_ssl = false
	$HTTPRequest.request(url + data, headers, use_ssl, HTTPClient.METHOD_GET)
	
	


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	
	var nome = body.get_string_from_utf8()
	print(nome)
	nome = nome.replace("\n", "")
	nome = nome.replace("\t", "")

	if nome == "Falhou":
		print(nome)
		falhou = true
		$AnimationPlayer.play("popErro")
	elif nome != "":
		ScriptGlobal.nome_jogador = nome
		get_tree().change_scene("res://cena_menu.tscn")
	else:
		nome += "1"
		print(nome)
		falhou = true		
		$AnimationPlayer.play("popErro2")
		
	

	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "popErro" or anim_name == "popErro2":
		falhou = false
