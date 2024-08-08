extends CharacterBody2D

@export var speed = 500
var ball
# Executado uma única vez, assim que o programa é executado
func _ready():
	ball = get_parent().get_node("Ball")

# Executado a cada frame do jogo
func _process(delta):
	pass

# Executado a cada quadro físico do jogo
func _physics_process(delta):
	
	velocity.x = 0
	
	if Input.is_action_pressed("ui_left") and ball.started == true:
		velocity.x -= speed
	if Input.is_action_pressed("ui_right") and ball.started == true:
		velocity.x += speed
		
	move_and_collide(velocity * delta)
