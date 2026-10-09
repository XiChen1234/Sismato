extends CharacterBody2D


@export var move_speed: float = 100.0

var player: CharacterBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(player):
		return

	var direction := global_position.direction_to(player.global_position)
	velocity = direction * move_speed
	move_and_slide()
