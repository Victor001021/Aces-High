extends Node2D


var mov = Vector2(0,1)


func _process(_delta):
	if ScriptGlobal.sumir_inimigo:
		queue_free()
	translate(mov)


func explodir():
	$Inimigo/AnimatedSprite.play("explosao")
	$Inimigo/CollisionPolygon2D.queue_free()
	if ScriptGlobal.status_efeitos:
		$Inimigo/AudioStreamPlayer.play()

func _on_Inimigo_area_entered(area):
	if area.name ==  "Disparo":
		ScriptGlobal.inimigos_destruidos += 1
		ScriptGlobal.liberar_especial += 1
		ScriptGlobal.pontuacao += rand_range(5, 11)
		area.queue_free()
		explodir()
		
	if area.name == "Terra" and ScriptGlobal.inimigos_destruidos < 50:
		if ScriptGlobal.pontuacao < 10:
			ScriptGlobal.pontuacao = 0
		else:
			ScriptGlobal.pontuacao -= 15
		explodir()


func _on_Inimigo_body_entered(body):
	if body.name == "Personagem":
		if ScriptGlobal.pontuacao < 5:
			ScriptGlobal.pontuacao = 0
		else:
			ScriptGlobal.pontuacao -= 5
		explodir()
		body.dano()
		if ScriptGlobal.vida_personagem > 0:
			ScriptGlobal.vida_personagem -= 1

func _on_AnimatedSprite_animation_finished():
	if $Inimigo/AnimatedSprite.animation == "explosao":
		queue_free()
