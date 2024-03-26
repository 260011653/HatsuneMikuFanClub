class_name Stats extends Node2D
var rng =RandomNumberGenerator.new()

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

func Heal():
	var Gain:int = rng.randi_range(10,Max_Health/6)
	if Gain + _Stats_Health >= Max_Health:
		_Stats_Health = Max_Health
	else:
		_Stats_Health += Gain
		
