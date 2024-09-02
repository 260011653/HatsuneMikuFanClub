extends Node

func write_mesh(meshArr,savename):
	
	var file = FileAccess.open("res://Scripts/meshes.gd", FileAccess.READ_WRITE)
	file.seek_end()
	var dat = "var "+savename+" := ["
	for coordinate in meshArr:
		dat+="["
		dat+=str(coordinate[0]*16)
		dat+=","
		dat+=str(coordinate[1]*16)
		dat+="],"
	dat = dat.left(dat.length()-1)
	dat+="]\n\n"
	file.store_string(dat)
	file.close()
