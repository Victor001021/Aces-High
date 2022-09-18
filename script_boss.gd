extends Area2D

var mov = Vector2(0,0)
var velocidade = 3.5
var virar = false
var iniciar = false
var descer = false
var tipo_disparo
func _ready():
#	print($".".global_position.y)
	$CollisionPolygon2D.disabled = true
	ScriptGlobal.sumir_boss = false
	tipo_disparo = 1

func _process(delta):
	tipo_disparo = randi()%6+1
	
	if $".".global_position.y <= 88:
		mov.y = 3
		$AnimationPlayer.play("inicio_boss")
	else:
		mov.y = 0

	if ScriptGlobal.sumir_boss:
		queue_free()
		
	if ScriptGlobal.vida_boss == 0:
		$AnimationPlayer.remove_animation("dano_boss")
		iniciar = false
		mov.x = 0
		$Sprite.play("explodindo")
		yield(get_tree().create_timer(0.7), "timeout")
		ScriptGlobal.coletal = false
	
	if iniciar:
		mov.x = velocidade
		$CollisionPolygon2D.disabled = false
		if !virar:
			$Sprite.play("direita")
			mov.x = velocidade
			if $".".position.x >= 560:
				virar = true
#				print(virar)

		else:
			$Sprite.play("esquerda")
			mov.x = -velocidade
			if $".".position.x <= -490:
				mov.x = 0
				virar = false
#				print(virar)


	translate(mov)
	
func _on_Timer_timeout():
	
	if tipo_disparo == 1 or tipo_disparo == 4:
		var esq = 0
		var dir = 0
		for i in range(0,7):
			var cena_disparo_inimigo = preload("res://cena_disparo_inimigo.tscn")
			var tiro = cena_disparo_inimigo.instance()
			var tiro2 = cena_disparo_inimigo.instance()
			
			tiro.global_position = $Position2D2.global_position
			tiro2.global_position = $Position2D.global_position
			
			tiro.get_node("DisparoInimigo").mov.x = esq
			
			tiro2.get_node("DisparoInimigo").mov.x = dir
			get_tree().root.add_child(tiro)
			get_tree().root.add_child(tiro2)
			esq -= 0.6
			dir += 0.6
	elif tipo_disparo == 2 or tipo_disparo == 5:
		$Timer.paused = true
		
		var cena_disparo_inimigo = preload("res://cena_disparo_inimigo.tscn")		
		var tiro = cena_disparo_inimigo.instance()
		var tiro2 = cena_disparo_inimigo.instance()
		var tiro3 = cena_disparo_inimigo.instance()
		var tiro4 = cena_disparo_inimigo.instance()
		var tiro5 = cena_disparo_inimigo.instance()
		var tiro6 = cena_disparo_inimigo.instance()
		
		for i in range(0,3):
			if not get_tree().paused:
				tiro.global_position = $Position2D.global_position
				get_tree().root.add_child(tiro)
				yield(get_tree().create_timer(0.7), "timeout")
			if not get_tree().paused:			
				tiro2.global_position = $Position2D2.global_position
				get_tree().root.add_child(tiro2)
				yield(get_tree().create_timer(0.7), "timeout")
			if not get_tree().paused:
				tiro3.global_position = $Position2D.global_position
				get_tree().root.add_child(tiro3)
				yield(get_tree().create_timer(0.7), "timeout")
			if not get_tree().paused:				
				tiro4.global_position = $Position2D2.global_position
				get_tree().root.add_child(tiro4)
				yield(get_tree().create_timer(0.7), "timeout")

			if not get_tree().paused:
				tiro5.global_position = $Position2D.global_position
				get_tree().root.add_child(tiro5)
				yield(get_tree().create_timer(0.7), "timeout")
			if not get_tree().paused:				
				tiro6.global_position = $Position2D2.global_position
				get_tree().root.add_child(tiro6)
			$Timer.paused = false
		
	if tipo_disparo == 3 or tipo_disparo == 6:
		$Timer.paused = true
		var cena_disparo_inimigo = preload("res://cena_disparo_inimigo.tscn")
		var tiro = cena_disparo_inimigo.instance()
		var tiro2 = cena_disparo_inimigo.instance()
		var tiro3 = cena_disparo_inimigo.instance()
		var tiro4 = cena_disparo_inimigo.instance()
		var tiro5 = cena_disparo_inimigo.instance()
		var tiro6 = cena_disparo_inimigo.instance()
		if not get_tree().paused:
			tiro.global_position = $Position2D.global_position
			get_tree().root.add_child(tiro)			
			tiro2.global_position = $Position2D2.global_position
			get_tree().root.add_child(tiro2)
			yield(get_tree().create_timer(0.7), "timeout")		
		if not get_tree().paused:
			tiro3.global_position = $Position2D.global_position			
			get_tree().root.add_child(tiro3)
			tiro4.global_position = $Position2D2.global_position
			get_tree().root.add_child(tiro4)
			yield(get_tree().create_timer(0.7), "timeout")	
		if not get_tree().paused:
			tiro5.global_position = $Position2D.global_position
			get_tree().root.add_child(tiro5)
			tiro6.global_position = $Position2D2.global_position
			get_tree().root.add_child(tiro6)
			yield(get_tree().create_timer(0.7), "timeout")				
		$Timer.paused = false





func _on_Area2D_area_entered(area):
	if area.name == "Disparo":
		if ScriptGlobal.vida_boss >= 5:
			$AnimationPlayer.play("dano_boss")
		ScriptGlobal.vida_boss -= 1
		ScriptGlobal.pontuacao += rand_range(1,5)
		area.queue_free()

func _on_Timer2_timeout():
	iniciar = true


func _on_Area2D_body_entered(body):
	if body.name == "Personagem":
		body.dano()
		if ScriptGlobal.vida_personagem > 0:
			ScriptGlobal.vida_personagem -= 1


func _on_Sprite_animation_finished():
	if $Sprite.animation == "explodindo":
		ScriptGlobal.boss_derrotado = true
		queue_free()
