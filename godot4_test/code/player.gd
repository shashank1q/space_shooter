extends CharacterBody2D

# reference to the bullet scene
var bullet = preload("res://scene/player_bullet.tscn")
# to track when we can shoot
var can_shoot = true

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		velocity.x -= 50
	elif Input.is_action_pressed("right"):
		velocity.x += 50
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.1)
		
	if Input.is_action_pressed("shoot"):
		if can_shoot:
			shoot()
			$Timer.start(0.1)
			can_shoot = false
	
	velocity.x = clamp(velocity.x, -500, 500)
	move_and_slide()

func shoot():
	var b = bullet.instantiate()
	get_parent().add_child(b)
	b.global_position = $Marker2D.global_position

func _on_timer_timeout():
	$Timer.stop()
	can_shoot = true
