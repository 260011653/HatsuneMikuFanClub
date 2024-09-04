extends Node

@onready var tile_map: TileMap = $"../TileMap"
# Called when the node enters the scene tree for the first time.

func create_balanced_ktree(tree,pointsAr) -> GlobalUtil.kTree: #pointsAr should be already X-sorted
	#print(pointsAr)
	#print(pointsAr.size())
	if pointsAr.size() == 0:
		return tree
	if pointsAr.size() < 2:
		tree.insertNode(pointsAr[0])
		return tree
	tree.insertNode(pointsAr[int(pointsAr.size()/2)])
	var leftHalf = pointsAr.slice(0,int(pointsAr.size()/2))
	var rightHalf = pointsAr.slice(int(pointsAr.size()/2),pointsAr.size()-1)
	tree = create_balanced_ktree(tree, leftHalf)
	tree = create_balanced_ktree(tree, rightHalf)
	return tree

func _ready():
	#get cells and create balanced K-tree
	var cell_points = tile_map.get_used_cells(0)
	cell_points = GlobalUtil.vector_to_array(cell_points)
	GlobalUtil.write_mesh_json(cell_points,get_tree().current_scene.name)
	var tree = GlobalUtil.kTree.new()
	
	tree = create_balanced_ktree(tree,cell_points)
	GlobalUtil.setCurrentSceneTree(tree)
	print("done")
	
	#var bruh = GlobalUtil.load_mesh(get_tree().current_scene.name)
	#print(bruh)


