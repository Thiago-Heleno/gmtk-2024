extends CharacterBody2D

@export var speed: float = 50.0
@export var detection_range: float = 200.0
@export var stop_distance: float = 0.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player: Node2D = null

func _ready():
	# Find the player node, assuming it's in the same scene
	player = get_tree().root.get_node("Node2D/SubViewportContainer/Player")

func _process(delta: float) -> void:
	if player:
		follow_player(delta)

func follow_player(delta: float) -> void:
	var distance_to_player = position.distance_to(player.position)

	if distance_to_player < detection_range and distance_to_player > stop_distance:
		var direction = (player.position - position).normalized()

		# Disable diagonal movement by zeroing out the smaller axis
		if abs(direction.x) > abs(direction.y):
			direction.y = 0  # Only move horizontally
		else:
			direction.x = 0  # Only move vertically

		# Update animation based on the new direction
		if direction.x < 0:
			animated_sprite_2d.play("walk_horizontal")
			animated_sprite_2d.flip_h = true
		elif direction.x > 0:
			animated_sprite_2d.play("walk_horizontal")
			animated_sprite_2d.flip_h = false
		elif direction.y < 0:
			animated_sprite_2d.play("walk_up")
		elif direction.y > 0:
			animated_sprite_2d.play("walk_down")

		velocity = direction * speed
	else:
		velocity = Vector2.ZERO  # Stop moving if out of range or too close

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.play_restart_sound()
		#get_tree().reload_current_scene()
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	pass # Replace with function body.
