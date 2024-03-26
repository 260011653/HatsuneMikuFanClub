class_name Player extends Stats

@export var _Player_Mana : int = Max_Mana

var Max_Mana : int
#initialise
func _init(mana,health,name):
	_Player_Mana = mana
	Max_Mana = mana
	_Stats_Name = name
	_Stats_Health = health
	Max_Health = health
	
func Attack():
	var Damage:int = rng.randi_range(40,60)
	return Damage

func Sp1():
	if _Player_Mana >= 5:
		var Damage :int = randi_range(60,90)
		_Player_Mana -= 5
		return Damage

func Sp2():
	if _Player_Mana >= 10:
		var Damage : int= randi_range(100,140)
		_Player_Mana -= 5
		return Damage

func Heal():
	if _Player_Mana >= 5:
		var Health : int = randi_range(20,50)
		if _Stats_Health + Health >=Max_Health:
			_Stats_Health = Max_Health
		else:
			_Stats_Health += Health

