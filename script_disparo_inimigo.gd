extends Area2D


var mov = Vector2(0, 4.2)

func _process(delta):
	if ScriptGlobal.sumir_disparo_inimigo:
		sumir()
	
	translate(mov)
	
	
func explodir():
	$CollisionShape2D.queue_free()
	$AnimationPlayer.play("explosao_tiro_inimigo")
	
func sumir():
	queue_free()

func _on_DisparoInimigo_body_entered(body):
	if body.name == "Personagem":
		body.dano()
		explodir()
		if ScriptGlobal.vida_personagem > 0:
			ScriptGlobal.vida_personagem -= 1
		if ScriptGlobal.pontuacao >= 5:
			ScriptGlobal.pontuacao -= rand_range(1,5)

func _on_DisparoInimigo_area_entered(area):
	if area.name == "Disparo":
		ScriptGlobal.pontuacao += rand_range(1,3)
		explodir()
