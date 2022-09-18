extends Area2D
var mov = Vector2(0,0.2)
var coletavel


func _ready():
	$Sprite.visible = false
	$Sprite2.visible = false
	$CollisionPolygon2D.disabled = true
	$CollisionPolygon2D2.disabled = true

	
func _process(delta):
	
	if coletavel == 1 or coletavel == 2 or coletavel == 3 :
		$Sprite.visible = true
		$CollisionPolygon2D.disabled = false
	elif coletavel == 4:
		$Sprite2.visible = true
		$CollisionPolygon2D2.disabled = false
	translate(mov)

func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Personagem":
		if coletavel == 1 or coletavel == 2 or coletavel == 3:
			if ScriptGlobal.vida_personagem < 4:
				ScriptGlobal.vida_personagem += 1
		elif coletavel == 4:
			ScriptGlobal.especial += 1
	queue_free()
