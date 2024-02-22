class_name Player extends npc
var rng =RandomNumberGenerator.new()



@export var _Player_Mana : int = Max_Mana

var Max_Mana : int
#initialise
func _init(mana):
	_Player_Mana = mana
	Max_Mana = mana
	
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
		if _Npc_Health + Health >=Max_Health:
			_Npc_Health = Max_Health
		else:
			_Npc_Health += Health
