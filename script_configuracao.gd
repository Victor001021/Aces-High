extends Node2D



var opcao = 1

func _ready():
	$Label3.hide()
	$Sprite.hide()
	$Node2D/RichTextLabel.bbcode_text = tr("config_tr")

func _process(delta):
	if ScriptGlobal.status_musica:
		$Status_musica.bbcode_text = tr("ativado_tr")
	else:
		$Status_musica.bbcode_text = tr("desativado_tr")
	if ScriptGlobal.status_efeitos:
		$Status_efeitos.bbcode_text = tr("ativado_tr")
	else:
		$Status_efeitos.bbcode_text = tr("desativado_tr")
	if ScriptGlobal.status_fullscreen:
		$Status_fullscreen.bbcode_text = tr("ativado_tr")
	else:
		$Status_fullscreen.bbcode_text = tr("desativado_tr")	
	
	if opcao == 1:
		$AnimationPlayer.play("fullscreen")
	else:
		$Fullscreen2.modulate= Color(1,1,1)
	if opcao == 2:
		$AnimationPlayer.play("musica")
	else:
		$Musica.modulate= Color(1,1,1)
	if opcao == 3:
		$AnimationPlayer.play("efeitos")
	else:
		$Efeitos.modulate= Color(1,1,1)		
		
	if opcao == 4:
		$AnimationPlayer.play("voltar")	
		$Label3.show()
		$Sprite.show()
		$Label2.hide()
		$setas2.hide()
	else:
		$Voltar.modulate= Color(1,1,1)
		$Label3.hide()
		$Sprite.hide()
		$Label2.show()
		$setas2.show()		
		
	
	if Input.is_action_just_pressed("ui_up")  and opcao >= 1:
		if opcao == 1:
			opcao = 4
		else:
			opcao -= 1
		if ScriptGlobal.status_efeitos:
			$AudioStreamPlayer.play()
	if Input.is_action_just_pressed("ui_down") and opcao <= 4:
		if opcao == 4:
			opcao = 1
		else:
			opcao += 1
		if ScriptGlobal.status_efeitos:
			$AudioStreamPlayer.play()
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		if opcao == 1:
			ScriptGlobal.status_fullscreen = !ScriptGlobal.status_fullscreen
			
		elif opcao == 2:
			ScriptGlobal.status_musica = !ScriptGlobal.status_musica
		elif opcao == 3:
			ScriptGlobal.status_efeitos = !ScriptGlobal.status_efeitos
		
		if ScriptGlobal.status_efeitos:
			$AudioStreamPlayer.play()
	if Input.is_action_just_pressed("enter"):
		if opcao == 4:
			get_tree().change_scene("res://cena_menu.tscn")
