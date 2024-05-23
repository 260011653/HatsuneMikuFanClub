class_name Player extends Stats

@export var Player_Mana : int = Max_Mana

var Max_Mana : int
#initialise
func _init(mana,health,name):
	Player_Mana = mana
	Max_Mana = mana
	Stats_Name = name
	Stats_Health = health
	Max_Health = health
	
func Attack():
	var Damage:int = rng.randi_range(40,60)
	return Damage

func Sp1():
	if Player_Mana >= 5:
		var Damage :int = randi_range(60,90)
		Player_Mana -= 5
		return Damage

func Sp2():
	if Player_Mana >= 10:
		var Damage : int= randi_range(100,140)
		Player_Mana -= 5
		return Damage

func Heal():
	if Player_Mana >= 5:
		var Health : int = randi_range(20,50)
		Player_Mana -= 5
		if Stats_Health + Health >=Max_Health:
			Stats_Health = Max_Health
		else:
			Stats_Health += Health

