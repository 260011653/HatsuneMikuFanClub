class_name Stats extends Node2D
var rng =RandomNumberGenerator.new()

@export var Stats_Health : int
@export var Stats_Name : String

var dead: bool = false
var Max_Health : int

#initialise
@warning_ignore("shadowed_variable_base_class")
func _init(p_name,health):
	Stats_Name = p_name
	Stats_Health = health
	Max_Health = health

func Dead(): #returns true if dead
	if Stats_Health <= 0:
		return true
	else:
		return false

func Damage(damage):
	Stats_Health -= damage

func Heal():
	@warning_ignore("integer_division")
	var Gain:int = rng.randi_range(10,Max_Health/6)
	if Gain + Stats_Health >= Max_Health:
		Stats_Health = Max_Health
	else:
		Stats_Health += Gain
