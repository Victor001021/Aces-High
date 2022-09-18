extends Node2D


var opcao = 1
var criar = false 


func _process(_delta):
	if opcao == 1:
		$LineEdit.grab_focus()
	else:
		$LineEdit.release_focus()
	if opcao == 2:
		$LineEdit2.grab_focus()
	else:
		$LineEdit2.release_focus()
	if opcao == 3:
		$LineEdit3.grab_focus()
	else:
		$LineEdit3.release_focus()	
	if opcao == 4:
		$Button.grab_focus()
	else:
		$Button.release_focus()	
	if opcao == 5:
		$Button2.grab_focus()
	else:
		$Button2.release_focus()	
		
	if opcao == 4 and !criar:
		$AnimationPlayer.play("criar")
	else:
		$Button.modulate = Color(1,1,1)
		
	if opcao == 5:
		$AnimationPlayer.play("voltar")
	else:
		$Button2.modulate = Color(1,1,1)
		
		
func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		if opcao == 5:
			opcao = 1
		else:
			opcao += 1
	if Input.is_action_just_pressed("ui_up"):
		if opcao == 1:
			opcao = 5
		else:
			opcao -= 1
	if Input.is_action_just_pressed("TAB"):
		if opcao <= 5:
			if opcao == 5:
				opcao = 1
			else:
				opcao += 1
	if Input.is_action_just_pressed("ESC"):
			ScriptGlobal.traduzir = !ScriptGlobal.traduzir
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "popErro":
		criar = false
	if anim_name == "popErro2":
		criar = false




func _on_Button_pressed():
	$LineEdit2.text = $LineEdit2.text.replace(" ", "+")
	var url = "http://uni9jogosdigitais.freevar.com/cadastro/salvar.php?";
	var data = "email=" + $LineEdit.text + "&nome=" + $LineEdit2.text + "&senha=" + $LineEdit3.text;
	var headers = []
	var use_ssl = false
	$HTTPRequest.request(url + data, headers, use_ssl, HTTPClient.METHOD_GET)
	



func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var email = body.get_string_from_utf8()
	email = email.replace("\n", "")
	email = email.replace("\t", "")
	print(email)
#	yield(get_tree().create_timer(1), "timeout")
	if email == "Falhou":
		criar = true
		$AnimationPlayer.play("popErro")
	elif email == "Nick":
		criar = true
		$AnimationPlayer.play("popErro2")
		
	elif email == "Cadastrado":
		get_tree().change_scene("res://cena_login.tscn")



func _on_Button2_pressed():
	get_tree().change_scene("res://cena_login.tscn")
