extends CharacterBody2D
@export var move_speed: float = 50
@export var animator: AnimatedSprite2D
@export var bullet_scene: PackedScene

var is_game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_game_over == false:
		velocity = Input.get_vector("left", "right", "up", "down") * move_speed
		# 如果速度为0，播放待机动画
		if velocity == Vector2.ZERO:
			animator.play("idle")
		# 如果速度不为0，播放跑步动画
		else:
			animator.play("run")
		move_and_slide()

func game_over() -> void:
	is_game_over = true
	animator.play("die")
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over == true:
		return
		
	var bullet = bullet_scene.instantiate()
	bullet.position = position + Vector2(6, 6)
	get_tree().current_scene.add_child(bullet)
