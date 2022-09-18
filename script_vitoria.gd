extends Node2D


var opcao = 1
func _ready():
	$Label2.text = "Pontuação\n" + str(int(ScriptGlobal.pontuacao))

	var url = "http://uni9jogosdigitais.freevar.com/cadastro/ranking.php?"
	var data = "nome=" +  ScriptGlobal.nome_jogador + "&pontuacao=" + String(int(ScriptGlobal.pontuacao))
	var headers = []
	var use_ssl = false
	$HTTPRequest.request(url + data, headers, use_ssl, HTTPClient.METHOD_GET)
func _process(delta):
	if opcao == 1:
		$AnimationPlayer.play("voltar")
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene("res://cena_menu.tscn")



func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var lista = body.get_string_from_utf8()
	print(lista)
	lista = lista.replace("<br>", "\n")
	lista = lista.replace("\t", "  ")
	
	$Label3.text = lista
