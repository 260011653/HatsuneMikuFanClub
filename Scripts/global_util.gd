extends Node

func write_mesh(meshArr,savename) -> void:
	
	var file = FileAccess.open("res://Scripts/meshes.gd", FileAccess.READ_WRITE)
	file.seek_end(-2)
	
	var shelf = {}
	var adj = {}
	
	var dat = "'"+savename+"' : {"
	for coordinate in meshArr:
		
		adj[coordinate] = []
		
		shelf[coordinate] = 1
		
		#
		#dat+="["
		#dat+=str(coordinate[0]*16)
		#dat+=","
		#dat+=str(coordinate[1]*16)
		#dat+="],"
	#dat = dat.left(dat.length()-1)
	#dat+="]\n\n"
	
	for coordinate in meshArr:
		var newcoordinate = coordinate
		newcoordinate[0] += 1
		if shelf.has(newcoordinate):
			adj[coordinate].append(newcoordinate)
		newcoordinate[0] -= 2
		if shelf.has(newcoordinate):
			adj[coordinate].append(newcoordinate)
		newcoordinate[0] += 1
		newcoordinate[1] += 1
		if shelf.has(newcoordinate):
			adj[coordinate].append(newcoordinate)
		newcoordinate[1] -= 1
		if shelf.has(newcoordinate):
			adj[coordinate].append([newcoordinate[0], newcoordinate[1]])
		
	for node in adj:
		dat+="["+str(node[0])+","+str(node[1])+"]"+" : ["
		for adjnode in adj[node]:
			dat+="["+str(adjnode[0])+","+str(adjnode[1])+"],"
		dat = dat.left(dat.length()-1) #remove the extra comma
		dat+="],\n"
	dat = dat.left(dat.length()-1) #remove the extra comma
	dat+="}\n}"
			
	file.store_string(dat)

const MESH_SAVE_PATH: String = "res://Scripts/meshes.bin" #CHANGE TO USER:// WHEN EXPORTING

#!
#!
#!

const MESH_SAVE_PASS: String = "password"
var mesh_dat = {} #GLOBAL RUNTIME INSTANCE OF MESH DICT

func write_mesh_json(meshArr,savename) -> void:
	
	var file = FileAccess.open(MESH_SAVE_PATH, FileAccess.WRITE)
	
	var shelf = {}
	var adj = {}
	
	for coordinate in meshArr:
		adj[coordinate] = []
		shelf[coordinate] = 1
	
	for coordinate in meshArr:
		var newcoordinate = coordinate
		newcoordinate[0] += 1
		if shelf.has(newcoordinate):
			adj[coordinate].append(newcoordinate)
		newcoordinate[0] -= 2
		if shelf.has(newcoordinate):
			adj[coordinate].append(newcoordinate)
		newcoordinate[0] += 1
		newcoordinate[1] += 1
		if shelf.has(newcoordinate):
			adj[coordinate].append(newcoordinate)
		newcoordinate[1] -= 1
		if shelf.has(newcoordinate):
			adj[coordinate].append([newcoordinate[0], newcoordinate[1]])
			
	mesh_dat[savename] = adj
	file.store_var(mesh_dat)

func load_mesh(levelname) -> Dictionary:
	var file = FileAccess.open(MESH_SAVE_PATH, FileAccess.READ)
	if not file:
		return {}
	if file == null:
		return {}
	if FileAccess.file_exists(MESH_SAVE_PATH) == true:
		return file.get_var()
	return {}
	
	
	

