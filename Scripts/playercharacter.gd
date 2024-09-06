extends CharacterBody2D

const speed = 100 #standard movement speed
var current_dir = "none" #direction of movement
var nav_active: bool  = false #is pathfinding active? #RETIRED
var current_scene_name : String = ""
var current_path_to_move = []
#@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	#default animation
	current_scene_name = get_tree().current_scene.name
	$AnimatedSprite2D.play("idle_down")

func _physics_process(delta):
	movement_control(delta)
	play_anim(nav_active)
	
	move_and_slide()
	#player_movement(delta)
	
	#handle mouse button inputs
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			bfs_move(get_global_mouse_position())
			#navigation_agent.target_position = get_global_mouse_position()
			nav_active = true
			
func movement_control(delta):
	
	print(current_path_to_move)
	if current_path_to_move.size() < 1:
		nav_active = false
	if nav_active:
		var current_pos = [GlobalUtil.snap_to_whole(global_position.x/16 - 0.5, 0.1) + 0.5, GlobalUtil.snap_to_whole(global_position.y/16, 0.1)]
		#print(current_pos)
		if GlobalUtil.hypot(current_pos, current_path_to_move.back()) == 0:
			current_path_to_move.pop_back()
		var next_path_pos = current_path_to_move.back()
		if next_path_pos == null:
			pass
			nav_active = false
		else:
			next_path_pos = Vector2(next_path_pos[0]*16,next_path_pos[1]*16)
			var direction = global_position.direction_to(next_path_pos)
			velocity = direction * speed
		
	else:
		velocity = Vector2.ZERO
		
func bfs_move(mouse_pos) -> void: #breadth first search guarantees shortest path in unweighted graph!
	var adj = GlobalUtil.load_mesh(current_scene_name)
	
	print(adj)
	#TESTED OK (it wasnt ok)
	#///////////////////
	var source = [int(roundf(global_position.x/16 - 0.5)), int(roundf(global_position.y)/16)] #round player pos to whole number
	var target = [mouse_pos.x / 16 - 0.5, mouse_pos.y / 16 - 0.5]
	
	var q = [] #queue
	var vis = {} #dict of visited nodes
	var dist = {} #dict of distance from source
	var prev = {} #dict of the previous node in the path from a node
	
	if GlobalUtil.currentSceneActiveCoords == null:
		OS.alert("Fatal Error has occured", "ALERT")
	
	for coord in GlobalUtil.currentSceneActiveCoords: #init visited, dist, prev dicts
		vis[coord] = false
		dist[coord] = INF
		prev[coord] = null
		
	#print(vis)
		
	q.push_back(source)
	vis[source] = true
	dist[source] = 0
	
	while q.size() != 0: #while queue not empty
		var curr = q.pop_front()
		#print(curr)
		for adjnode in adj[current_scene_name][curr]:
			if (vis[adjnode] == false):
				#print("Aha")
				vis[adjnode] = true
				dist[adjnode] = dist[curr] + 1
				prev[adjnode] = curr
				
				q.push_back(adjnode)
	
	#print(target)
	
	target = GlobalUtil.currentSceneTree.findNearestNeighbour(target)
	
	#Backtrack along prev array
	var path = [] #REVERSED (mouse to character instead of character to mouse)
	var node = target
	while node != source:
		path.append([node[0]+0.5,node[1]])
		node = prev[node]
	
	current_path_to_move = path
	
	#print(path)
	
	
	
	#print(target)
	
	
	
	
	
			#
#func _on_navigation_agent_2d_target_reached() -> void:
	#print("reached target")
	#nav_active = false
	#
#func _on_navigation_agent_2d_navigation_finished() -> void:
	#print("Navigation finished")
	#nav_active = false

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
	
	print(velocity.x,", ", velocity.y)
	
	if abs(velocity.y) > abs(velocity.x):
		if velocity.y > 0: current_dir = "down"
		elif velocity.y < 0: current_dir = "up"
	elif abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0: current_dir = "right"
		elif velocity.x < 0: current_dir = "left"
	

	var dir = current_dir
	var anim = $AnimatedSprite2D
	if dir == "right":
		if movement == true:
			anim.play("walk_right")
		elif movement == false:
			anim.play("idle_right")
	elif dir == "left":
		if movement == true:
			anim.play("walk_left")
		elif movement == false:
			anim.play("idle_left")
	elif dir == "up":
		if movement == true:
			anim.play("walk_up")
		elif movement == false:
			anim.play("idle_up")
	elif dir == "down":
		if movement == true:
			anim.play("walk_down")
		elif movement == false:
			anim.play("idle_down")
