extends KinematicBody2D

onready var bullet = preload("res://scenes/Bullet.tscn")
var b
var gravity := 0
var direction := Vector2.ZERO

func _physics_process(delta):
	move()
	shoot()
	direction = move_and_slide(direction, Vector2.UP)
	
func shoot():
	if Input.is_action_just_pressed("shoot"):
		b = bullet.instance()
		get_parent().add_child(b)
		b.global_position = $Position2D.global_position
	
func move():
	gravity += 10
	if Input.is_action_pressed("right"):
		direction.x = 200
		$AnimatedSprite.play("run")
		$AnimatedSprite.scale.x = 1
	elif Input.is_action_pressed("left"):
		direction.x = -200
		$AnimatedSprite.play("run")
		$AnimatedSprite.scale.x = -1
	else:
		direction.x = 0
		$AnimatedSprite.play("stand")
		
	if is_on_floor():  # Verificar se o jogador está no chão
		if Input.is_action_just_pressed("jump"):
			gravity = -250
			$AnimatedSprite.play("jump")
	else:
		$AnimatedSprite.play("jump")  # Reproduzir animação "jump" enquanto estiver no ar
		
	direction.y = gravity
