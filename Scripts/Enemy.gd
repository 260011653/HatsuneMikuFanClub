class_name Enemy extends Stats

@export var _Message : String
@export var _Heal : bool
var _Damage : int


func _init(name,health,unimes,damage,heal):
	Stats_Name = name
	Stats_Health = health
	Max_Health = health
	_Message = unimes
	_Damage = damage
	_Heal = heal

func Attack():
	var dam = rng.randi_range(_Damage-10,_Damage+10)
	return dam

func Sp():
	var dam = rng.randi_range(2*(_Damage-10),2*(_Damage+10))
	return dam

