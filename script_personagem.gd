extends KinematicBody2D

var mov = Vector2(0,0)
var velocidade = 545
var mudar = false

func _ready():
	$nave1.hide() 
	$nave2.hide()
	$nave3.hide() 
	$nave4.hide()
	$nave1Collision.disabled = true
	$nave2Collision.disabled = true
	$nave3Collision.disabled = true
	$nave4Collision.disabled = true

	
	
	if ScriptGlobal.nave_selecionada == 1:
		$nave1.show() 
		$nave1Collision.disabled = false
		$Position2D.position.x = -59.323
		$Position2D.position.y = -48.009
		$Position2D2.position.x = 72.047
		$Position2D2.position.y = -48.009
	elif ScriptGlobal.nave_selecionada == 2:
		$nave2.show()
		$nave2Collision.disabled = false
		
	elif ScriptGlobal.nave_selecionada == 3:
		$nave3.show()
		$nave3Collision.disabled = false
		$Position2D.position.x = -95.66
		$Position2D.position.y = -56.357
		$Position2D2.position.x = 94.144
		$Position2D2.position.y = -56.357
		
	elif ScriptGlobal.nave_selecionada == 4:
		$nave4.show()
		$nave4Collision.disabled = false
		$Position2D.position.x = -34.962
		$Position2D.position.y = -57.702
		$Position2D2.position.x = 35.984
		$Position2D2.position.y = -57.702
		
func _process(_delta):
	var largura = get_viewport_rect().size.x #pega a largura da tela
	var altura = get_viewport_rect().size.y #pega a altura da tela
	
	var x_atual = global_position.x
	var y_atual = global_position.y
	
	global_position.x = clamp(x_atual,0,largura) #mantem a nave na tela 
	global_position.y = clamp(y_atual,0,altura)
	
	mov.x = 0
	mov.y = 0
	
	$nave1.play("nave1Voando")
	$nave2.play("nave2voando")
	$nave3.play("nave3voando")
	$nave4.play("nave4voando")
	if Input.is_action_pressed("ui_up"):
			mov.y = -velocidade
			
	if Input.is_action_pressed("ui_down"):
		mov.y = velocidade
		
	if Input.is_action_pressed("ui_left"):
		mov.x = -velocidade
		$nave1.play("nave1esquerda")
		$nave2.play("nave2esquerda")
		$nave3.play("nave3esquerda")
		$nave4.play("nave4esquerda")
		
	if Input.is_action_pressed("ui_right"):
		mov.x = velocidade
		$nave1.play("nave1direita")
		$nave2.play("nave2direita")
		$nave3.play("nave3direita")
		$nave4.play("nave4direita")


	move_and_slide(mov.normalized() * velocidade)
	
	if Input.is_action_just_pressed("espaco"):
		mudar = !mudar
		var cena_disparo = preload("res://cena_disparo.tscn")
		var disparo = cena_disparo.instance()
		
		if mudar:
			disparo.global_position = $Position2D.global_position
		else:
			disparo.global_position = $Position2D2.global_position
		get_tree().root.add_child(disparo)
		if ScriptGlobal.status_efeitos:
			$AudioStreamPlayer2.play()
			
func _input(event):
	if Input.is_action_just_pressed("M") and ScriptGlobal.especial > 0:
		var cena_disparo = preload("res://cena_disparo.tscn")
		ScriptGlobal.especial -= 1
		var ultima_pos = 5
		
		for i in range(0,21):
			var missel = cena_disparo.instance()
			get_tree().root.add_child(missel)
			missel.get_node("Disparo").tipo_disparo = 2
			missel.global_position.y = get_viewport().size.y
			missel.global_position.x = ultima_pos
			ultima_pos += 50
			
func dano():
	$AnimationPlayer.play("dano")
