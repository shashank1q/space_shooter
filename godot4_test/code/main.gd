extends Control

# reference to the enemy scene
var enemy = preload("res://scene/enemy.tscn")
# to be shown on the UI screen
var score = 0

func _ready():
	# starting initial delay in spawning of the enemy
	$Timer.start(2.0)

func _on_timer_timeout():
	# creating instance of the enemy
	var inst = enemy.instantiate()
	# add our enemy under this node 
	add_child(inst)
	# connect enemy_die signal from enemy instance to _on_enemy_die function
	inst.connect("enemy_die",_on_enemy_die)
	# random number 1 or 0 
	var choice = randi() % 2
	if choice == 1:
		# spawn enemy from the left side 
		inst.position = $left_spawn_pos.position
	else:
		# spawn enemy from the right side 
		inst.position = $right_spawn_pos.position
	# starting the timer for a random duration to make it engaging
	$Timer.start(randi()%4)


# called when player is hit by the enemy bullets
func _on_player_player_hit(value):
	# update the player's life
	$UI/life.text = "Lives: " + str(value)
	# if we ran out of lives
	if value == 0:
		# pause the game 
		get_tree().paused = true
		# making the menu screen visible again
		$UI/background.visible = true

# when enemy dies ( this function is connected to enemy via code above)
func _on_enemy_die():
	# increase the score
	score += 1
	# update the score on the UI
	$UI/score.text = "Score: " + str(score)

# when we die and pressed restart button
func _on_restart_pressed():
	# unpause the screen
	get_tree().paused = false
	# reload the game
	get_tree().reload_current_scene()

# when we die and pressed exit button
func _on_exit_pressed():
	# close the game
	get_tree().quit()


func _on_pause_btn_pressed():
	# pause the game 
	get_tree().paused = true
	# making the menu screen visible again
	$UI/background.visible = true
	# change lable to Paused
	$UI/background/Label.text = "Paused"
	# make resume button visible
	$UI/background/resume.visible = true

func _on_resume_pressed():
	# pause the game 
	get_tree().paused = false
	# making the menu screen visible again
	$UI/background.visible = false
	# change lable to Paused
	$UI/background/Label.text = "Game Over"
	# make resume button visible
	$UI/background/resume.visible = false
