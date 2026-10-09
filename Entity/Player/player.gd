extends CharacterBody2D


@export var move_speed: float = 300.0
@export var max_health: int = 10

@onready var invincibility_timer: Timer = $Timer/InvincibilityTimer
@onready var hurt_box: Area2D = $HurtBox

var health: int = 10


func _ready() -> void:
	health = max_health


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = direction * move_speed
	move_and_slide()


## 玩家受击触发
func _on_hurt_box_area_entered(area: Area2D) -> void:
	print("Area entered: ", area.name)
	if area.name != "HitBox":
		return
	
	if not invincibility_timer.is_stopped():
		return
	
	health -= 1
	hurt_box.set_deferred("monitoring", false)
	print("Player Health: ", health)
	invincibility_timer.start()


## 无敌计时器结束后重新开启受击box
func _on_invincibility_timer_timeout() -> void:
	hurt_box.set_deferred("monitoring", true)
