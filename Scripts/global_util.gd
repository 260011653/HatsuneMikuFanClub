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
		newcoordinate = [coordinate[0] + 1, coordinate[1]]
		if shelf.has(newcoordinate):
			print(coordinate, newcoordinate)
			adj[coordinate].append([newcoordinate[0], newcoordinate[1]])
		newcoordinate = [coordinate[0] - 1, coordinate[1]]
		if shelf.has(newcoordinate):
			adj[coordinate].append([newcoordinate[0], newcoordinate[1]])
		newcoordinate = [coordinate[0], coordinate[1]+ 1]
		if shelf.has(newcoordinate):
			adj[coordinate].append([newcoordinate[0], newcoordinate[1]])
		newcoordinate = [coordinate[0], coordinate[1]- 1]
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
	
func vector_to_array(pointsAr):
	var ret = []
	for point in pointsAr:
		ret.append([point[0],point[1]])
	return ret

class kTree:
	
	class kNode:
		var left
		var right
		var point
		func _init(ipoint):
			self.left = null
			self.right = null
			self.point = ipoint #[x,y]
			
	var root: kNode = null
			
	func newkNode(point) -> kNode:
		return kNode.new(point)

	#insert point into tree
	func insertRec(root, point, depth): #root = null if adding root
		if root == null:
			#print("hi")
			return newkNode(point)
		var cd = depth % 2 #current dimension of comparison with root node as x-aligned
		
		#print(root.point)
		
		if point[cd] < root.point[cd]: #if equal, go right (treat as greater)
			root.left = insertRec(root.left, point, depth+1)
		else:
			root.right = insertRec(root.right, point, depth+1)
		return root
		
	func insertNode(point: Array):
		if root == null:
			self.root = newkNode(point)
			return 1
		#print(point)
		#if root != null:
			#print(root.point)
		return insertRec(root,point,0)
		
	func points_equal(point1: Array,point2: Array) -> bool:
		if point1[0] == point2[0] and point1[1] == point2[1]:
			return true
		else: return false
		
	func closest_node_to_target(target: Array, node1: kNode, node2: kNode) -> kNode: #returns the closest node to target pos
		if node1 == null:
			return node2
		if node2 == null:
			return node1
		var d1 = ((target[0] - node1.point[0])**2 + (target[1] - node1.point[1])**2)**0.5
		var d2 = ((target[0] - node2.point[0])**2 + (target[1] - node2.point[1])**2)**0.5
		if d1 >= d2:
			return node2
		else: return node1
		
	func hypotSquared(point1: Array, point2: Array) -> float: #returns distance between points squared
		return (point1[0] - point2[0])**2 + (point1[1] - point2[1])**2
			
	func nearestNeighbour(root, target, depth):
		if root == null:
			return null
		var nextBranch: kNode
		var otherBranch: kNode
		if (target[depth%2] < root.point[depth%2]):
			nextBranch = root.left
			otherBranch = root.right
		else:
			nextBranch = root.right
			otherBranch = root.left
		
		var temp : kNode = nearestNeighbour(nextBranch, target, depth+1)
		var best : kNode = closest_node_to_target(target, temp, root)
		
		var radiusSquared = hypotSquared(target, best.point) #r, dist from best to target
		var dist = target[depth%2] - root.point[depth%2] #r' dist to the root axis divider
		
		if (radiusSquared >= dist * dist):
			temp = nearestNeighbour(otherBranch, target, depth+1)
			best = closest_node_to_target(target, temp, best)
		
		return best
		
	func findNearestNeighbour(target):
		#print(self.root.point)
		var ret = nearestNeighbour(self.root, target, 0)
		if ret == null: return null
		else: return ret.point
	
	func traverse(node):
		if node != null:
			print(node.point)
			traverse(node.left)
			traverse(node.right)

var currentSceneTree: kTree = null
var currentSceneActiveCoords = null

func setCurrentSceneTree(tree):
	GlobalUtil.currentSceneTree = tree
	
func setCurrentSceneCoords(coords):
	GlobalUtil.currentSceneActiveCoords = coords
	
func hypot(point1: Array, point2: Array) -> float: #returns distance between points 
		return ((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2)**0.5

func snap_to_whole(num: float, margin):
	if abs(num - roundf(num)) < margin:
		return roundf(num)
	else: return num
