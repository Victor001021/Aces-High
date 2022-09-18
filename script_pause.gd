extends Node2D


var opcao = 1
var opcao2 = 1
var config = false

func _ready():
	visible = false
	
	

func _process(delta):
	if ScriptGlobal.status_fullscreen:
		OS.set_window_fullscreen(true)
	else:
		OS.set_window_fullscreen(false)
		OS.set_window_size(Vector2(1024, 720))

	if config:
		if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
			if opcao2 == 1:
				ScriptGlobal.status_fullscreen = !ScriptGlobal.status_fullscreen
			if opcao2 == 2:
				ScriptGlobal.status_efeitos = !ScriptGlobal.status_efeitos
			if opcao2 == 3:
				ScriptGlobal.status_musica = !ScriptGlobal.status_musica
			if ScriptGlobal.status_efeitos:
				$AudioStreamPlayer.play()

	
	if ScriptGlobal.status_fullscreen:
			$ColorRect2/Fullscreen_status.text = "<Ativado>"
	else:
		$ColorRect2/Fullscreen_status.text = "<Desativado>"
			
	if ScriptGlobal.status_efeitos:
			$ColorRect2/Efeitos_status.text = "<Ativado>"
	else:
			$ColorRect2/Efeitos_status.text = "<Desativado>"
		
	if ScriptGlobal.status_musica:
			$ColorRect2/Musica_status.text = "<Ativado>"
	else:
			$ColorRect2/Musica_status.text = "<Desativado>"

	if Input.is_action_just_pressed("ESC"):
			visible = not get_tree().paused
			get_tree().paused = not get_tree().paused
	


		
	if visible == true:	

		if $ColorRect.visible == true:
			if Input.is_action_just_pressed("ui_down"):
				if opcao == 4:
					opcao = 1
				else:
					opcao += 1
				if ScriptGlobal.status_efeitos:
					$AudioStreamPlayer.play()
			if Input.is_action_just_pressed("ui_up"):
				if opcao == 1:
					opcao = 4
				else:
					opcao -= 1
				if ScriptGlobal.status_efeitos:
					$AudioStreamPlayer.play()
			if Input.is_action_just_pressed("enter"):
				if opcao == 1:
					visible = not get_tree().paused
					get_tree().paused = not get_tree().paused
				
				
				if opcao == 2:
					ScriptGlobal.sumir_boss = true
					ScriptGlobal.coletal = false
					ScriptGlobal.sumir_inimigo = true
					get_tree().reload_current_scene()
					get_tree().paused = not get_tree().paused
					
				
				if opcao == 3:
					$ColorRect2.show()				
					$ColorRect.hide()
					opcao = 1
					
					

				if opcao == 4:
					get_tree().paused = not get_tree().paused
					ScriptGlobal.sumir_boss = true
					ScriptGlobal.coletal = false
					ScriptGlobal.sumir_inimigo = true
					ScriptGlobal.sumir_disparo_inimigo = true
					
					
					get_tree().change_scene("res://cena_menu.tscn")
					
		if $ColorRect2.visible == true:
			config = true
			if Input.is_action_just_pressed("ui_down"):
				if opcao2 == 4:
					opcao2 = 1
				else:
					opcao2 += 1
				if ScriptGlobal.status_efeitos:
					$AudioStreamPlayer.play()
			if Input.is_action_just_pressed("ui_up"):
				if opcao2 == 1:
					opcao2 = 4
				else:
					opcao2 -= 1
				if ScriptGlobal.status_efeitos:
					$AudioStreamPlayer.play()
			if Input.is_action_just_pressed("enter"):
				if opcao2 == 4:
					$ColorRect2.hide()
					$ColorRect.show()
					opcao2 = 1
		else:
			config = false

	
	if opcao == 1:
		$ColorRect/AnimationPlayer.play("continuar")
	else:
		$ColorRect/Label2.modulate = Color(1,1,1)

	if opcao == 2:
		$ColorRect/AnimationPlayer.play("reiniciar")
	else:
		$ColorRect/Label7.modulate = Color(1,1,1)
		


	if opcao == 3:
		$ColorRect/AnimationPlayer.play("configuracoes")
	else:
		$ColorRect/Label3.modulate = Color(1,1,1)



	if opcao == 4:
		$ColorRect/AnimationPlayer.play("sair")
	else:
		$ColorRect/Label4.modulate = Color(1,1,1)


	if opcao2 == 1:
		$ColorRect2/AnimationPlayer.play("fullscreen")
	else:
		$ColorRect2/Fullscreen.modulate = Color(1,1,1)

	if opcao2 == 2:
		$ColorRect2/AnimationPlayer.play("efeitos")
	else:
		$ColorRect2/Efeitos_sonoros.modulate = Color(1,1,1)

	if opcao2 == 3:
		$ColorRect2/AnimationPlayer.play("musica")
	else:
		$ColorRect2/Musica.modulate = Color(1,1,1)
		
	if opcao2 == 4:
		$ColorRect2/AnimationPlayer.play("voltar")
		$ColorRect2/Sprite5.show()
		$ColorRect2/Label3.show()
		$ColorRect2/Sprite4.hide()
		$ColorRect2/Label2.hide()
	else:
		$ColorRect2/Voltar.modulate = Color(1,1,1)
		$ColorRect2/Sprite5.hide()
		$ColorRect2/Label3.hide()
		$ColorRect2/Sprite4.show()
		$ColorRect2/Label2.show()
