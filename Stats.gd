class_name Stats extends Node2D

@export var _Stats_Health : int
@export var _Stats_Name : String

var dead: bool = false
var Max_Health : int

#initialise
func _init(name,health):
	_Stats_Name = name
	_Stats_Health = health
	Max_Health = health

func Dead(): #returns true if dead
	if _Stats_Health <= 0:
		return true
	else:
		return false

func Damage(damage):
	_Stats_Health -= damage
