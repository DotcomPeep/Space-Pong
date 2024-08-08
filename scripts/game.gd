extends Node2D


@onready var ball = $Ball
@onready var label_pongs = $Pongs
@onready var label_Tutorial = $Tutorial
@onready var positions = $Positions
@onready var background = $Background
var last_position 
var asteroid_scene = preload("res://scenes/asteroid.tscn")

""" exemplo de biblioteca para contagem de pontos
var pontos_jogadores = {
	"Alice": 10,
	"Bob": 20,
	"Carol": 30,
	"Hanna": 40
}"""

var resource_asteroids = []
var resource_background = []
var resource_colors_label = []

var new_asteroid_color

func _ready():
	# print("Pontos de Carol: ",  pontos_jogadores["Carol"]) exemplo para contagem de pontos
	preload_resources()

func _process(delta):
	
	if ball.started:
		label_pongs.visible = true
		label_Tutorial.visible = false
	
	label_pongs.text = str(ball.pongs)
	check_pongs(ball.pongs)

# Função para adiar o processamento de física do jogo
func _on_hole_body_entered(body):
	call_deferred("reload_scene")
	
func reload_scene():
	get_tree().reload_current_scene()

func _on_timer_spawner_timeout():
	spawn_asteroid()
	
func spawn_asteroid():
	if ball.started:
		var positions_list = positions.get_children()
		var spawn_position = positions_list.pick_random()
		
		if spawn_position != last_position:
			var asteroid_instance = asteroid_scene.instantiate()
			asteroid_instance.global_position = spawn_position.position
			if new_asteroid_color != null:
				asteroid_instance.get_node("Sprite2D").texture = new_asteroid_color
			add_child(asteroid_instance)
			last_position = spawn_position
		else:
			spawn_asteroid()
	
func preload_resources():
	resource_asteroids = {
		"asteroid1": preload("res://sprites/Asteroide1.png"),
		"asteroid2": preload("res://sprites/Asteroide2.png"),
		"asteroid3": preload("res://sprites/Asteroide3.png"),
		"asteroid4": preload("res://sprites/Asteroide4.png"),
		"asteroid5": preload("res://sprites/Asteroide5.png"),
		"asteroid6": preload("res://sprites/Asteroide6.png")
	}

	resource_background = {
		"background1" = preload("res://sprites/Fundo1.png"),
		"background2" = preload("res://sprites/Fundo2.png"),
		"background3" = preload("res://sprites/Fundo3.png"),
		"background4" = preload("res://sprites/Fundo4.png"),
		"background5" = preload("res://sprites/Fundo5.png"),
		"background6" = preload("res://sprites/Fundo6.png")
	}
	
	resource_colors_label = {
		"color1" = "#5f00c9",
		"color2" = "#1E90FF",
		"color3" = "#008000",
		"color4" = "#D2691E",
		"color5" = "#FF00FF",
		"color6" = "#8B008B"
	}

func check_pongs(pongs):
	match pongs:
		0:
			update_colors("color1", "background1")
		10:
			update_colors("color2", "background2")
			update_asteroids("asteroid2")
		20:
			update_colors("color3", "background3")
			update_asteroids("asteroid3")
		30:
			update_colors("color4", "background4")
			update_asteroids("asteroid4")
		40:
			update_colors("color5", "background5")
			update_asteroids("asteroid5")
		50:
			update_colors("color6", "background6")
			update_asteroids("asteroid6")
			
func update_colors(key_color_label, key_color_bg):
	label_pongs.label_settings.font_color = resource_colors_label[key_color_label]
	background.set_texture(resource_background[key_color_bg])

func update_asteroids(key_asteroid):
	var asteroids = get_tree().get_nodes_in_group("asteroids")
	
	for asteroid in asteroids:
		asteroid.get_node("Sprite2D").texture = resource_asteroids[key_asteroid]
		
	new_asteroid_color = resource_asteroids[key_asteroid]
