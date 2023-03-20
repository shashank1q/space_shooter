extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2(0,1) * 1000 * delta)

func _on_visibility_notifier_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if !body.is_in_group("enemy"):
		texture = load("res://images/explosion_enemy.png")
		set_process(false)
		body.take_damage()
		await  get_tree().create_timer(0.2).timeout
		queue_free()


