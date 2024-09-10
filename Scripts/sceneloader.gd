extends Node

@onready var tile_map: TileMap = $"../TileMap"
# Called when the node enters the scene tree for the first time.
@onready var player: CharacterBody2D = $"../playercharacter"

		
func create_balanced_ktree(tree,pointsAr) -> GlobalUtil.kTree: #pointsAr should be already X-sorted
	#print(pointsAr)
	#print(pointsAr.size())
	if pointsAr.size() == 0:
		return tree
	if pointsAr.size() < 2:
		tree.insertNode(pointsAr[0])
		return tree
		
	#print(pointsAr)
		#
	tree.insertNode(pointsAr[int(pointsAr.size()/2)])
	var leftHalf = pointsAr.slice(0,int(pointsAr.size()/2)) #split in half around median
	var rightHalf = pointsAr.slice(int(pointsAr.size()/2),pointsAr.size())
	
	#print("left:", leftHalf)
	#print("right:", rightHalf)
	
	tree = create_balanced_ktree(tree, leftHalf)
	tree = create_balanced_ktree(tree, rightHalf)
	return tree

func _ready():
	
	if SceneTransition.last_direction == "up":
		player.position = SceneTransition.scene_starting_positions[get_tree().current_scene.name]["up"] 
	elif SceneTransition.last_direction == "down":
		player.position = SceneTransition.scene_starting_positions[get_tree().current_scene.name]["down"] 
	elif SceneTransition.last_direction == "fight":
		player.position = SceneTransition.scene_starting_positions[get_tree().current_scene.name]["fight"] 
	elif SceneTransition.last_direction == "door":
		player.position = SceneTransition.scene_starting_positions[get_tree().current_scene.name]["door"] 
	
	if GlobalUtil.first_spawn:
		$"../playercharacter/RichTextLabel".text = "Right Click to move"
		$"../playercharacter/RichTextLabel/AnimationPlayer2".play("popup")
		player.position = Vector2(10,66)
		GlobalUtil.disable_movement = true
		GlobalUtil.first_spawn = false
		await get_tree().create_timer(3).timeout
		$"../playercharacter/RichTextLabel/AnimationPlayer2".play_backwards("popup")
		GlobalUtil.disable_movement = false
	
	if GlobalUtil.delete_wheely and get_tree().current_scene.name == "level1":
		var collision_shape_2d = $"../FightWheely/CollisionShape2D"
		collision_shape_2d.disabled = PROCESS_MODE_DISABLED
		$"../wheeliebagkid".visible = false
		$"../wheeliebag".global_position = Vector2(211,59)
		$"../wheeliebag".rotation = 90
		
	if GlobalUtil.delete_fight_area:
		var delete_path = "../"+str(GlobalUtil.delete_fight_area_name) + "/" + "CollisionShape2D"
		var fight_area = get_node(delete_path)
		fight_area.disabled = PROCESS_MODE_DISABLED
		GlobalUtil.delete_fight_area = false
	
		
	#get cells and create balanced K-tree
	var cell_points = tile_map.get_used_cells(0)
	cell_points = GlobalUtil.vector_to_array(cell_points)
	
	
	GlobalUtil.write_mesh_json(cell_points,get_tree().current_scene.name)
	var tree = GlobalUtil.kTree.new()
	
	tree = create_balanced_ktree(tree,cell_points)
	
	#for x in cell_points:
		#print(x)
		#
	#print("#######")
	#tree.traverse(tree.root)
	
	GlobalUtil.setCurrentSceneCoords(cell_points)
	GlobalUtil.setCurrentSceneTree(tree)
	
	if get_tree().current_scene.name == "reception":
		var rng = RandomNumberGenerator.new()
		while(1):
			await get_tree().create_timer(rng.randf_range(0.2,0.5)).timeout
			$"../TileMap/Label".visible = false
			await get_tree().create_timer(rng.randf_range(0.2,0.5)).timeout
			$"../TileMap/Label".visible = true
			$"../TileMap/Label".global_position = Vector2(rng.randi_range(50,80),rng.randi_range(25,10))
			
	if get_tree().current_scene.name == "level2":
		var rng = RandomNumberGenerator.new()
		while(1):
			await get_tree().create_timer(rng.randf_range(0.1,0.2)).timeout
			$"../PrinterGoesHere".global_position = Vector2(313,42)
			await get_tree().create_timer(rng.randf_range(0.1,0.2)).timeout
			$"../PrinterGoesHere".global_position = Vector2(312,42)
		
	print("scene load done")
	
	#var bruh = GlobalUtil.load_mesh(get_tree().current_scene.name)
	#print(bruh)



