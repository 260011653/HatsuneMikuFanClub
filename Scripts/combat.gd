extends Node
var rng =RandomNumberGenerator.new() #random number generator
#var Student = Player.new(40,200,"John")
# Called when the node enters the scene tree for the first time.
const Enem := preload("res://Scripts/Enemy.gd")
var Foe = Enem.new("Student",100,"Student throws textbook at you",20,false)


func _ready():
	var assign = rng.randi_range(1,3)
	match assign:
		1: 
			Foe = Enem.new("Student",100,"Student throws textbook at you",20,false)
			$Student.show()
		2:
			Foe = Enem.new("Teacher", 200,"Teacher gives you detention",35, false)
			$Teacher.show()
		3:
			Foe = Enem.new("Rogue Computer", 160,"Rogue Computer sends phishing email",25,false)
			$Printer.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PlayerDisplay.text = "HEALTH: "+str(Student.Get_Health())+"\nMANA: "+str(Student.Get_Mana())
	$EnemyDisplay.text = Foe.Get_Name()+": "+str(Foe.Get_Health())
	if Student.Dead():
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	if Foe.Dead() == true:
		get_tree().change_scene_to_file("res://Scenes/win.tscn")






func EnemAttack():
	var Move = randi_range(1,2)
	if Foe.Get_Health() < Foe.Get_Max_Health()/2 and Foe.Get_Heal() == true:
		Move = rng.randi_range(1,3)
	match Move:
		1:
			var damage = Foe.Attack()
			$ELog.text = Foe.Get_Name()+" swings dealing \n"+str(damage)+" damage"
			Student.Damage(damage)
		2:
			var damage = Foe.Sp()
			$ELog.text = Foe.Get_Message()+"\n"+str(damage)+" damage"
			Student.Damage(damage)
		3:
			Foe.Heal()
	$Attack.show()
	$Magic.show()

func _on_attack_pressed():
	$Attack.hide()
	$Magic.hide()
	var damage = Student.Attack()
	$Log.text = "You punch dealing: \n"+str(damage)+" Damage"
	Foe.Damage(damage)
	EnemAttack()


func _on_magic_pressed():
	$Magic.hide()
	$Attack.hide()
	$Heal.show()
	$Sp1.show()
	$Sp2.show()
	$Back.show()



func _on_heal_pressed():
	var check = Student.Heal()
	if str(check) != "false":
		$Heal.hide()
		$Sp1.hide()
		$Sp2.hide()
		$Back.hide()
		EnemAttack()
		$Log.text = "You heal for:\n"+str(check)
	else:
		$Log.text = "You don't have the\nmana for that"


func _on_sp_1_pressed():
	var damage = Student.Sp1()
	if str(damage) != "false":
		$Heal.hide()
		$Sp1.hide()
		$Sp2.hide()
		$Back.hide()
		$Log.text = "You throw your computer: \n"+str(damage)+" Damage"
		Foe.Damage(damage)
		EnemAttack()
	else:
		$Log.text = "You don't have the\nmana for that"


func _on_sp_2_pressed():
	var damage = Student.Sp2()
	if str(damage) != "false":
		$Heal.hide()
		$Sp1.hide()
		$Sp2.hide()
		$Back.hide()
		$Log.text = "You punch dealing: \n"+str(damage)+" Damage"
		Foe.Damage(damage)
		EnemAttack()
	else:
		$Log.text = "You don't have the\nmana for that"

func _on_back_pressed():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	$Back.hide()
	$Attack.show()
	$Magic.show()
	
