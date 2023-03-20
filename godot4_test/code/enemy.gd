extends CharacterBody2D

signal enemy_die

@onready 
var timer = $Timer

var health = 5
var bullet = preload("res://scene/enemy_bullet.tscn")
var width = 0
var can_shoot = false
var direction = -1

func _ready():
	timer.start(2.0)
	width =  get_viewport().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if position.x > width - 52:
		direction = -1
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position:y", position.y + 100,1.0)
	
	elif position.x < 52:
		direction = 1
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position:y", position.y + 100,1.0)
	
	velocity.x = direction * 20000 * delta
	
	if can_shoot:
		shoot()
		can_shoot = false
		timer.start(randi() % 5 +1)

	move_and_slide()

func shoot():
	var inst = bullet.instantiate()
	get_parent().add_child(inst)
	inst.global_position = $bullet_pos.global_position

func _on_timer_timeout():
	can_shoot = true
	timer.stop()

func take_damage():
	health -= 1
	if health == 0:
		emit_signal("enemy_die")
		queue_free()

