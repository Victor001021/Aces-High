extends Area2D

var mov = Vector2(1,0)
var tipo_ajuda
var random = RandomNumberGenerator.new()


func _ready():
	if ScriptGlobal.status_efeitos:
		$AudioStreamPlayer2D.play()
	

func _process(delta):
	random.randomize()
	tipo_ajuda = random.randi_range(1, 4)
#	print(tipo_ajuda)
	
	if ScriptGlobal.coletal == false:
		queue_free()
	translate(mov)


func _on_Timer_timeout():
	var cena_coletaveis = preload("res://cena_coletaveis.tscn")
	var coletavel = cena_coletaveis.instance()
	
	if ScriptGlobal.inimigos_destruidos < 40 and ScriptGlobal.vida_personagem < 4:
		coletavel.get_node("Area2D").coletavel = tipo_ajuda	
	elif ScriptGlobal.liberar_especial >= 10:
		coletavel.get_node("Area2D").coletavel = 4
	elif ScriptGlobal.inimigos_destruidos >= 40 and ScriptGlobal.vida_personagem < 4:
		coletavel.get_node("Area2D").coletavel = 1
		
	get_tree().root.add_child(coletavel)
	coletavel.global_position = $Position2D.global_position
	
	ScriptGlobal.liberar_especial = 0

func _on_Timer2_timeout():
	queue_free()
