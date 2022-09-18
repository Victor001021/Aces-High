extends Area2D
var mov = Vector2(0,-2.5)
var tipo_disparo = 1

func _ready():
	$CollisionShape2D.disabled = true
	$CollisionShape2D2.disabled = true
func _process(delta):
	if tipo_disparo == 1:
		$Sprite.visible = true
		$CollisionShape2D.disabled = false
	elif tipo_disparo == 2:
		$Sprite2.visible = true
		$CollisionShape2D2.disabled = false
		
	
	translate(mov)
