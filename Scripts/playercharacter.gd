extends CharacterBody2D

const speed = 100 #standard movement speed
var current_dir = "none" #direction of movement
var nav_active: bool  = false #is pathfinding active?
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

@onready var tile_map: TileMap = $"../TileMap"

func _ready():
	#default animation
	GlobalUtil.write_mesh(tile_map.get_used_cells(0),get_tree().current_scene.name)
	
	$AnimatedSprite2D.play("idle_down")

func _physics_process(delta):
	if nav_active:
		var next_path_pos := navigation_agent.get_next_path_position()
		var direction := global_position.direction_to(next_path_pos)
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	player_movement(delta)
	
	#handle mouse button inputs
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			navigation_agent.target_position = get_global_mouse_position()
			nav_active = true
			
func _on_navigation_agent_2d_target_reached() -> void:
	print("reached target")
	nav_active = false
	
func _on_navigation_agent_2d_navigation_finished() -> void:
	print("Navigation finished")
	nav_active = false

#Manual arrow key movement
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if dir == "right":
		if movement == 1:
			anim.play("walk_right")
		elif movement == 0:
			anim.play("idle_right")
	if dir == "left":
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("idle_left")
	if dir == "up":
		if movement == 1:
			anim.play("walk_up")
		elif movement == 0:
			anim.play("idle_up")
	if dir == "down":
		if movement == 1:
			anim.play("walk_down")
		elif movement == 0:
			anim.play("idle_down")