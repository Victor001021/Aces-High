extends Node

var opcao_menu = 1
var status_musica = true
var status_efeitos = true
var status_fullscreen = false
var nave_selecionada = 1
var vida_boss = 0
var vida_boss_padrao = 100
var vida_terra = 0
var vida_terra_padrao = 6
var vida_personagem = 0
var vida_personagem_padrao = 4
var pontuacao = 0
var sumir_boss = false
var sumir_disparo_inimigo = false
var boss_derrotado = false
var inimigos_destruidos = 0
var coletal = true
var sumir_inimigo = false
var especial = 0
var liberar_especial = 0
var nome_jogador = ""
var traduzir = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	


func _process(_delta):
	if status_fullscreen:
		OS.set_window_fullscreen(true)
	
	else:
		OS.set_window_fullscreen(false)
		OS.set_window_size(Vector2(1024, 720))
		
	if traduzir:
		TranslationServer.set_locale("en")
	else:
		TranslationServer.set_locale("pt_BR")
