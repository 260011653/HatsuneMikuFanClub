extends Node
var rng =RandomNumberGenerator.new()
var Student = Player.new(40,500,"John")
var RHealth = 2000
var Max = 2000
#func _ready():


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PlayerDisplay.text = "HEALTH: "+str(Student.Get_Health())+"\nMANA: "+str(Student.Get_Mana())
	$EnemyDisplay.text = "Printer: "+str(RHealth)
	if Student.Dead():
		await get_tree().create_timer(2).timeout 
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	if RHealth <= 0:
		$EnemyDisplay.text = "Printer: 0"
		await get_tree().create_timer(2).timeout 
		get_tree().change_scene_to_file("res://Scenes/win.tscn")






func EnemAttack():
	await get_tree().create_timer(1).timeout
	var Move = rng.randi_range(1,5)
	if RHealth <= Max/2:
		Move = rng.randi_range(1,6)
	match Move:
		1:
			$ELog.text = "Printer buffers"
		2:
			$ELog.text = "Printer jams"
		3:
			var damage = rng.randi_range(20,30)
			$ELog.text = "Printer spews toner over you \n"+str(damage)+" damage"
			Student.Damage(damage)
		4:
			$ELog.text = "Printer gives you a paper cut\n50 damage"
			Student.Damage(50)
		5:
			$ELog.text = "Printer jams"
		6:
			var Heal = rng.randi_range(50,150)
			if RHealth+Heal >= Max:
				Heal = Max-RHealth
				RHealth = Max
			else:
				RHealth += Heal
			$ELog.text = "Printer downs some toner \n"+str(Heal)+" Health"
	$Attack.show()
	$Magic.show()

func _on_attack_pressed():
	$Attack.hide()
	$Magic.hide()
	var damage = Student.Attack()
	$Log.text = "You punch dealing: \n"+str(damage)+" Damage"
	RHealth -= damage
	EnemAttack()


func _on_magic_pressed():
	$Magic.hide()
	$Attack.hide()
	$Heal.show()
	$Sp1.show()
	$Sp2.show()
	$Run.show()
	$Back.show()



func _on_heal_pressed():
	var check = Student.Heal()
	if str(check) != "false":
		$Heal.hide()
		$Sp1.hide()
		$Sp2.hide()
		$Back.hide()
		$Run.hide()
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
		$Run.hide()
		$Log.text = "You throw your computer: \n"+str(damage)+" Damage"
		RHealth -= damage
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
		$Run.hide()
		$Log.text = "You show your 100% mark\ndealing: "+str(damage)+" Damage"
		RHealth -= damage
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
	$Run.hide()
	


func _on_run_pressed():
	$Log.text = "You cannot run\nfrom this fight"
