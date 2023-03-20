extends Control

var enemy = preload("res://scene/enemy.tscn")
@onready var timer = $Timer
var score = 0

func _ready():
	$player.global_position = $player_pos.global_position
	timer.start(2.0)

func _on_timer_timeout():
	var inst = enemy.instantiate()
	inst.connect("enemy_die",_on_enemy_die)
	add_child(inst)
	var choice = randi() % 2
	if choice == 1:
		inst.position = $left_spawn_pos.position
	else:
		inst.position = $right_spawn_pos.position
	timer.start(randi()%5)

func _on_enemy_die():
	score += 1
	$UI/score.text = "Score: " + str(score)

func _on_player_player_hit(value):
	$UI/life.text = "Lives: " + str(value)
	if value == 0:
		get_tree().paused = true
		$UI/background.visible = true

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().quit()
