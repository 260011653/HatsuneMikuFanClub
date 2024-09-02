extends Node

func write_mesh(meshArr,savename):
	
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
	file.close()
