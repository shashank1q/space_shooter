extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2(0,1) * 1000 * delta)

#when we got out of the screen
func _on_visibility_notifier_screen_exited():
	# delete the bullet
	queue_free()

# when bullet hit something
func _on_area_2d_body_entered(body):
	# if we hit player
	if body.name == "player":
		# change image to explosion image to show an impact
		texture = load("res://images/explosion_enemy.png")
		# stop the process function so, bullet don't move 
		set_process(false)
		# reduce the health of the player. 
		#take body is a function defined in player's script
		body.take_damage()
		# wait for 0.2 seconds
		await  get_tree().create_timer(0.2).timeout
		# delete the bullet
		queue_free()


