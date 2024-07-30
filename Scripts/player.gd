
@onready var character_body_2d = $"."

@export var Player_Mana : int = Max_Mana


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass




var Max_Mana : int
var Stats_Name : String
var Stats_Health : int
var Max_Health : int
#initialise
func _init(mana,health,name):
	Player_Mana = mana
	Max_Mana = mana
	Stats_Name = name
	Stats_Health = health
	Max_Health = health
	
func Attack():
	var Damage:int = randi_range(35,50)
	return Damage

func Sp1():
	if Player_Mana >= 5:
		var Damage :int = randi_range(50,65)
		Player_Mana -= 5
		return Damage
	else:
		return false

func Sp2():
	if Player_Mana >= 10:
		var Damage : int= randi_range(80,95)
		Player_Mana -= 10
		return Damage
	else:
		return false

func Heal():
	if Player_Mana >= 5:
		var Health : int = randi_range(100,150)
		Player_Mana -= 5
		if Stats_Health + Health >=Max_Health:
			Health = Max_Health-Stats_Health
			Stats_Health = Max_Health
		else:
			Stats_Health += Health
		return Health
	else:
		return false


func Get_Health():
	return Stats_Health
func Get_Mana():
	return Player_Mana
