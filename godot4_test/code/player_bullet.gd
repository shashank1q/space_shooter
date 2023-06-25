extends Sprite2D

# This function is called at every frame
func _process(delta):
	# translate is used to move any node using a vector as an input
	translate(Vector2(0,-1) * 1000 * delta)

# triggered when our bullet get out of the screen 
func _on_visible_on_screen_notifier_2d_screen_exited():
	# deleting the bullet from the game
	queue_free()

# detetcting what our bullet collide with
func _on_area_2d_body_entered(body):
	if body.name != "player":
		# changing our bullet image into explosion 
		texture = load("res://images/player_explosion.png")
		# stoping the process function so that, it doesn't move.
		set_process(false)
		# reducing the health of the body ( enemy )
		body.take_damage()
		# waiting for 0.2 seconds 
		await  get_tree().create_timer(0.2).timeout
		# deleting the bullet
		queue_free()
