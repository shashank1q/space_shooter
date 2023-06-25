extends CharacterBody2D

# size of the screen
var width = 0
# direction of movement( -1 means left direction)
var direction = -1
# references to bullet scene
var bullet = preload("res://scene/enemy_bullet.tscn")
# for checking whether we can shoot or not
var can_shoot = false

func _ready():
	# start shooting after 2 sec
	$Timer.start(2.0)
	# getting the width of the screen
	width =  get_viewport().size.x

func _physics_process(delta):
	# when we reach the right side of the screen
	if position.x > width - 52:
		#setting direction to left
		direction = -1
		# crating tween 
		var tween = get_tree().create_tween()
		# moving enemy down or close to the player
		tween.tween_property(self,"position:y", position.y + 100,1.0)
	
	# when we reach the left side of the screen
	elif position.x < 52:
		# setting direcion to right
		direction = 1
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position:y", position.y + 100,1.0)
	
	if can_shoot:
		shoot()
		# starting timer for a random time from 1 to 5 sec
		$Timer.start(randi() % 5 +1)
		# stops shooting until timmer is running
		can_shoot = false
	
	
	# moving left or right 
	velocity.x = direction * 20000 * delta
	move_and_slide()

func shoot():
	var inst = bullet.instantiate()
	# getting the parent node to add bullet ( main scene in this case )
	get_parent().add_child(inst)
	# setting position of the bullet.
	inst.global_position = $bullet_pos.global_position


func _on_timer_timeout():
	# enabling the enemy to shoot again
	can_shoot = true
	$Timer.stop()
