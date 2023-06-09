extends CharacterBody2D

# reference to the bullet scene
var bullet = preload("res://scene/player_bullet.tscn")
# to track when we can shoot
var can_shoot = true
#health of the player
var health = 5
# emit signal when player recieve damage ( for updaing UI )
signal player_hit(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	# player movement 
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 50
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 50
	else:
		velocity.x = lerp(velocity.x,0.0,0.1)
	
	# when we press spacebar
	if Input.is_action_pressed("ui_accept"):
		if can_shoot:
			shoot()
			$Timer.start(0.1)
			can_shoot = false

	velocity.x = clamp(velocity.x,-500,500)
	move_and_slide()

func shoot():
	var b = bullet.instantiate()
	get_parent().add_child(b)
	b.global_position = $shoot_pos.global_position
	
func _on_timer_timeout():
	$Timer.stop()
	can_shoot = true

func take_damage():
	health -= 1
	emit_signal("player_hit",health)
	if health == 0:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		health = 1
		take_damage()
