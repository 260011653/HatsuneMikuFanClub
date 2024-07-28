class_name Player extends Stats
extends CharacterBody2D

@export var Player_Mana : int = Max_Mana
# -------------- CONSTANTS ----------

const speed = 100

# -------------- PHYSICS --------

func _physics_process(delta):
	pass
	
func player_movement(delta):
	
	# --------- dfs
	
	
	# --------- WASD
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = speed
	else:
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
		
		

var Max_Mana : int
#initialise
func _init(mana,health,name):
	Player_Mana = mana
	Max_Mana = mana
	Stats_Name = name
	Stats_Health = health
	Max_Health = health
	
func Attack():
	var Damage:int = rng.randi_range(35,50)
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
