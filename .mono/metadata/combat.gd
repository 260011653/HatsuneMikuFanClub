extends Node
var rng =RandomNumberGenerator.new() #random number generator
const Player := preload("res://player.gd")
var Student = Player.new("John")
# Called when the node enters the scene tree for the first time.


func _ready():
	while true:
		if Student.Dead():
			get_tree().change_scene("res://game_over.tscn")
		if Enemy.Dead():
			get_tree().change_scene("res://win.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Attack_button_down():
	$Attack.hide()
	$Magic.hide()
	var damage = Student.Attack()
	Enemy.Damage(damage)




func _on_magic_button_down():
	$Magic.hide()
	$Attack.hide()
	$Heal.show()
	$Sp1.show()
	$Sp2.show()


func _on_heal_button_down():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	Student.Heal()

func _on_sp_1_button_down():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	var damage = Student.Sp1()
	Enemy.Damage(damage)

func _on_sp_2_button_down():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	var damage = Student.Sp2()
	Enemy.Damage(damage)
