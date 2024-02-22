class_name npc extends Node2D

@export var _Npc_Health : int
@export var _Npc_Name : String

var dead: bool = false
var Max_Health : int

#initialise
func _init(name,health):
	_Npc_Name = name
	_Npc_Health = health
	Max_Health = health

func Dead():
	if _Npc_Health <= 0:
		return true
	else:
		return false
