extends Node2D

var mostrar = true
var a = true
var ini_timer = false

func _ready():
	ScriptGlobal.vida_boss = ScriptGlobal.vida_boss_padrao 
	ScriptGlobal.vida_terra = ScriptGlobal.vida_terra_padrao
	ScriptGlobal.vida_personagem = ScriptGlobal.vida_personagem_padrao
	ScriptGlobal.pontuacao = 0
	ScriptGlobal.boss_derrotado = false
	ScriptGlobal.sumir_inimigo = false
	ScriptGlobal.sumir_disparo_inimigo = false
	ScriptGlobal.coletal = true
	ScriptGlobal.inimigos_destruidos = 0
	ScriptGlobal.especial = 0
	ScriptGlobal.liberar_especial = 0
	
	$Terra/escudo1.hide()
	$Terra/escudo2.hide()
	$Terra/escudo3.hide()
	$Terra/escudo4.hide()
	$Terra/escudo5.hide()

	
	
func _process(_delta):
	HUD()
	$Pontuacao/pontuacao.text = "Pontuação " + str(int(ScriptGlobal.pontuacao))
	
	if ScriptGlobal.status_musica and !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
	elif !ScriptGlobal.status_musica:
		$AudioStreamPlayer.stop()
	
	if ScriptGlobal.boss_derrotado:
		queue_free()
		get_tree().change_scene("res://cena_vitoria.tscn")
	
	if ScriptGlobal.vida_terra == 0:
		$Terra/CollisionPolygon2D.queue_free()
	
	if ScriptGlobal.inimigos_destruidos >= 50 and a == true:
		$TimerInimigo.stop()
		$TimerInimigo2.stop()
		

		if $Sprite.position.y <= 240:
			$Sprite.position.y += 1

		if $Terra.position.y <= 200:
			$Terra.position.y += 1
			
		ini_timer = true
		if ini_timer and $TimerBoss.is_stopped():
			$TimerBoss.start()
		yield(get_tree().create_timer(2.5), "timeout")
		a = false
		
		
	
	if ScriptGlobal.vida_terra == 6:
		$Terra/escudo1.show()
	if ScriptGlobal.vida_terra == 5:
		$Terra/escudo1.hide()
		$Terra/escudo2.show()
	if  ScriptGlobal.vida_terra == 4:
		$Terra/escudo1.hide()
		$Terra/escudo2.hide()
		$Terra/escudo3.show()
	if  ScriptGlobal.vida_terra == 3:
		$Terra/escudo1.hide()
		$Terra/escudo2.hide()
		$Terra/escudo3.hide()
		$Terra/escudo4.show()
	if  ScriptGlobal.vida_terra == 2:
		$Terra/escudo1.hide()
		$Terra/escudo2.hide()
		$Terra/escudo3.hide()
		$Terra/escudo4.hide()
		$Terra/escudo5.show()
	if  ScriptGlobal.vida_terra == 1:
		$Terra/escudo1.hide()
		$Terra/escudo2.hide()
		$Terra/escudo3.hide()
		$Terra/escudo4.hide()
		$Terra/escudo5.hide()
	

	if ScriptGlobal.vida_terra == 0 or ScriptGlobal.vida_personagem == 0:
		queue_free()
		ScriptGlobal.sumir_boss = true
		ScriptGlobal.coletal = false
		ScriptGlobal.sumir_inimigo = true
		ScriptGlobal.sumir_disparo_inimigo = true
		
		get_tree().change_scene("res://cena_game_over.tscn")
	
func _on_Terra_area_entered(area):
	if area.name == "Inimigo":
		if ScriptGlobal.vida_terra > 0:
			ScriptGlobal.vida_terra -= 1



func _on_TimerInimigo_timeout():
	var cena_inimigo = preload("res://cena_inimigo.tscn")
	var inimigo = cena_inimigo.instance()

	var largura_tela = (get_viewport_rect().size.x) - 10 #pega a largura da tela
	get_tree().root.add_child(inimigo)
	
	inimigo.global_position.x = rand_range(0,largura_tela)
	inimigo.global_position.y = -150

	


func _on_TimerInimigo2_timeout():
	var cena_inimigo = preload("res://cena_inimigo.tscn")
	var inimigo = cena_inimigo.instance()
	inimigo.get_node(".").mov.y = 3
	var largura_tela = get_viewport_rect().size.x #pega a largura da tela
	
	get_tree().root.add_child(inimigo)

	inimigo.global_position.x = rand_range(0,largura_tela)
	inimigo.global_position.y = -150

	

func _on_limiteDisparo_area_entered(area):
	if area.name == "Disparo":
		area.queue_free()


func _on_limiteDisparoInimigo_area_entered(area):
	if area.name == "DisparoInimigo":
		area.queue_free()
		
func HUD():
	$BarraVida/vida1.show()
	$BarraVida/vida2.show()
	$BarraVida/vida3.show()
	$BarraVida/vida4.show()
	$BarraVida/Label.text = "X " + str(int(ScriptGlobal.especial))
	if ScriptGlobal.vida_personagem == 4:
		$BarraVida/vida1.show()
		$BarraVida/vida2.hide()
		$BarraVida/vida3.hide()
		$BarraVida/vida4.hide()
	if ScriptGlobal.vida_personagem == 3:
		$BarraVida/vida2.show()
		$BarraVida/vida1.hide()
		$BarraVida/vida3.hide()
		$BarraVida/vida4.hide()
	if ScriptGlobal.vida_personagem == 2:
		$BarraVida/vida3.show()
		$BarraVida/vida1.hide()
		$BarraVida/vida2.hide()
		$BarraVida/vida4.hide()
	if ScriptGlobal.vida_personagem == 1:
		$BarraVida/vida4.show()
		$BarraVida/vida1.hide()
		$BarraVida/vida2.hide()
		$BarraVida/vida3.hide()
	



func _on_TimerBoss_timeout():
	var cena_boss = preload("res://cena_boss.tscn")
	var boss = cena_boss.instance()
	get_tree().root.add_child(boss)
	$TimerBoss.queue_free()


func _on_TimerAjuda_timeout():
	if (ScriptGlobal.liberar_especial >= 10 or ScriptGlobal.vida_personagem < 4) and ScriptGlobal.coletal:
		var cena_ajuda = preload("res://cena_ajuda.tscn")
		var ajuda =  cena_ajuda.instance()
		ajuda.get_node("Area2D/Timer").wait_time = rand_range(2.0,2.5)
		var altura_tela = (get_viewport_rect().size.y)
		ajuda.global_position.x = -100
		get_tree().root.add_child(ajuda)
		
		if $TimerAjuda.wait_time == 10:
			$TimerAjuda.wait_time = 15
		else:
			$TimerAjuda.wait_time = 10
		
