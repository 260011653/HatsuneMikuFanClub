class_name Enemy extends Stats
var rng =RandomNumberGenerator.new()

@export var _Message : String
@export var _Heal : bool
var _Damage : int


func _init(name,health,unimes,damage,heal):
	_Stats_Name = name
	_Stats_Health = health
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

func Heal():
	var Gain:int = rng.randi_range(10,Max_Health/6)
	if Gain + _Stats_Health >= Max_Health:
		_Stats_Health = Max_Health
	else:
		_Stats_Health += Gain
		
