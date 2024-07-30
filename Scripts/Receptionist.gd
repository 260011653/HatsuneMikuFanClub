extends Node
var Student = Player.new(40,200,"John")
var RHealth = 999
var rng =RandomNumberGenerator.new()
var Move = 0
#func _ready():


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PlayerDisplay.text = "HEALTH: "+str(Student.Get_Health())+"\nMANA: "+str(Student.Get_Mana())
	$EnemyDisplay.text = "Receptionist: "+str(RHealth)
	if Student.Dead():
		await get_tree().create_timer(2).timeout 
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	if RHealth <= 0:
		await get_tree().create_timer(2).timeout 
		get_tree().change_scene_to_file("res://Scenes/win.tscn")


func _ready():
	EnemAttack()



func EnemAttack():
	await get_tree().create_timer(0.5).timeout 
	match Move:
		0:
			var damage = 1
			$ELog.text = "Enemies will attack you, this\nwill display damage\n"+str(damage)+" damage"
			Student.Damage(damage)
			await get_tree().create_timer(3).timeout 
			$ELog.text = "Try pressing attack\nto damage me"
		1:
			var Heal = 999-RHealth
			RHealth = 999
			$ELog.text = "Some enemies can heal\n"+str(Heal)+" Health"
			await get_tree().create_timer(3).timeout
			$ELog.text = "Try pressing magic and try\nusing heal on yourself,\nthis costs mana"
		2:
			var damage = 1
			$ELog.text = "Receptionist swings dealing \n"+str(damage)+" damage"
			Student.Damage(damage)
			await get_tree().create_timer(1).timeout 
			$ELog.text = "Try pressing magic and using\none of your special attacks,\nthese deal more damage than a\nnormal attack but cost mana"
	Move += 1
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
	$Back.show()
	$Run.show()



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
		if Move >= 3:
			$Log.text = "You throw your computer: \n"+str(RHealth)+" Damage"
			RHealth -= RHealth
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
		if Move >= 3:
			$Log.text = "You show your 100% mark\ndealing: "+str(RHealth)+" Damage"
			RHealth -= RHealth
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
	var chance = rng.randi_range(1,100)
	if chance < 31:
		get_tree().change_scene_to_file("res://Scenes/.tscn") #switch out for right scene
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	$Back.hide()
	$Run.hide()
	$Attack.show()
	$Magic.show()
