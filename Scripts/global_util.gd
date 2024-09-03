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
	
class kNode:
	func _init(ipoint):
		var left = null
		var right = null
		var point = ipoint #[x,y]
		
func newkNode(point) -> kNode:
	return kNode.new(point)

func insertRec(root, point, depth):
	if not root:
		return newkNode(point)
	var cd = depth % 2 #current dimension of comparison with root node as x-aligned
	
	if point[cd] < root.point[cd]: #if equal, go right (treat as greater)
		root.left = insertRec(root.left, point, depth+1)
	else:
		root.right = insertRec(root.right, point, depth+1)
	return root
	
func insertk(root,point):
	return insertRec(root,point,0)
	
func points_equal(point1,point2) -> bool:
	if point1[0] == point2[0] and point1[1] == point2[1]:
		return true
	else: return false
	
func find_closest_node(point) -> Array:
	return [69,69] #stud
	
	
	
	
	

