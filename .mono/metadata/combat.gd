extends Node
var rng =RandomNumberGenerator.new() #random number generator

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	while true:
		if Player.GetHealth() <= 0:
			get_tree().change_scene("res://game_over.tscn")
		if Enemy.GetHealth() <= 0:
			get_tree().change_scene("res://win.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func 

func _on_Attack_button_down():
	$Attack.hide()
	$Magic.hide()
	var damage = Player.GetDamage()
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
	Miku.AddHealth(rng.randi_range(20,40))

func _on_sp_1_button_down():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	var damage = Miku.GetSp1()
	Enemy.Damage(damage)

func _on_sp_2_button_down():
	$Heal.hide()
	$Sp1.hide()
	$Sp2.hide()
	var damage = Miku.GetSp2()
	Enemy.Damage(damage)
