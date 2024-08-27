extends Node2D

@onready var game_manager: Node2D = $".."	

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	game_manager.add_time()
	animation_player.play("hide_coin")
	pass # Replace with function body.
