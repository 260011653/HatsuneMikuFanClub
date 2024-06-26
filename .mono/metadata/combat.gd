extends Node
var rng =RandomNumberGenerator.new() #random number generator
var Student = Player.new(40,200,"John")
# Called when the node enters the scene tree for the first time.
const Enem := preload("res://Enemy.gd")
var Player_Mana : int = 40
var Player_Health : int = 200
var Foe = Enem.new("Student",100,"Student throws textbook at you",60,false)

func _ready():
	var assign = rng.randi_range(1,4)
	match assign:
		1: 
			Foe = Enem.new("Student",100,"Student throws textbook at you",60,false)
			$Student.show()
		2:
			Foe = Enem.new("Teacher", 200,"Teacher gives you detention",100, false)
			$Teacher.show()
		3:
			Foe = Enem.new("Rogue Computer", 160,"Rogue Computer sends phishing email",70,false)
			$Printer.show()
		4:
			Foe = Enem.new("Printer",500,"Printer jams",10,true)
			$Computer.show()
	while true:
		$PlayerDisplay.text = "HEALTH: "+str(Player_Health)+"\nMANA: "+str(Player_Mana)
		if Student.Dead():
			get_tree().change_scene("res://game_over.tscn")
		if Foe.Dead():
			get_tree().change_scene("res://win.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_attack_button_down():
	$Attack.hide()
	$Magic.hide()
	var damage = Student.Attack()
	Foe.Damage(damage)
	EnemAttack()


func _on_magic_button_down():
	$Magic.hide()
	$Attack.hide()
	$Heal.show()
	$Sp1.show()
	$Sp2.show()
	EnemAttack()


func _on_heal_button_down():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	Student.Heal()
	EnemAttack()

func _on_sp_1_button_down():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	var damage = Student.Sp1()
	Foe.Damage(damage)
	EnemAttack()

func _on_sp_2_button_down():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	var damage = Student.Sp2()
	Foe.Damage(damage)
	EnemAttack()

func EnemAttack():
	var Move = randi_range(1,2)
	if Foe._Stats_Health < Foe._Stats_Health/2 and Foe._Heal == true:
		Move = rng.randi_range(1,3)
	match Move:
		1:
			var damage = Foe.Attack()
			Student.Damage(damage)
		2:
			var damage = Foe.Sp()
			Student.Damage(damage)
		3:
			Foe.Heal()
