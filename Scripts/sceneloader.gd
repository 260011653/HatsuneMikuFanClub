extends Node

@onready var tile_map: TileMap = $"../TileMap"
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalUtil.write_mesh_json(tile_map.get_used_cells(0),get_tree().current_scene.name)
	
	#var bruh = GlobalUtil.load_mesh(get_tree().current_scene.name)
	#print(bruh)

