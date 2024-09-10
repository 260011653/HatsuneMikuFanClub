extends CanvasLayer

const transition_conditions = {
	"reception": {
	[8,0]: ["level1.tscn","up"]
	},
	"level1":{
	[16,0]: ["reception.tscn","down"],
	[14,0]: ["level2.tscn","up"]
	},
	"level2": {
	[14,0]: ["level3.tscn","up"],
	[16,0]: ["level1.tscn","down"]
	},
	"level3": {
	[16,0]: ["level2.tscn","down"],
	[20,3]: ["classroom.tscn", "door"],
	[21,3]: ["classroom.tscn", "door"],
	[19,3]: ["classroom.tscn", "door"],
	[20,4]: ["classroom.tscn", "door"]
	},
	"classroom": {
	[1,12]: ["level3.tscn","door"]
	}
	
}

const scene_starting_positions = {
	"reception": {
		"down": Vector2(136,18),
		"fight": Vector2(114,61)
	},
	"level1": {
		"up": Vector2(264,16),
		"down": Vector2(232,16),
		"fight": Vector2(239,58)
	},
	"level2": {
		"up": Vector2(264,16),
		"down": Vector2(232,16),
		"fight": Vector2(332,52)
	},
	"level3": {
		"up": Vector2(264,16),
		"door": Vector2(328,48)
	},
	"classroom": {
		"door": Vector2(24,198),
		"fight": Vector2(61,73)
	}
}

const list_of_quotes = ["Average Calculator!", "Rubber Duckies...", "Good afternoon...", "I like muffins", "ChatGPT", "Pity variable"]


var last_direction = ""

func change_scene(target: String, direction: String, last_player_pos = null) -> void:
	
	var rng = RandomNumberGenerator.new()
	var rando = rng.randi_range(0, list_of_quotes.size()-1)
	$TextureRect/Label.text = '"' + list_of_quotes[rando] + '"'
	SceneTransition.last_direction = direction
	var target_path = "res://Scenes/"+target
	if direction == "fight":
		GlobalUtil.last_player_pos = last_player_pos
		$AnimationPlayer.play('FIGHT')
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file(target_path)
		await get_tree().create_timer(0.5).timeout
		$AnimationPlayer.play_backwards('FIGHT')
		GlobalUtil.disable_movement = false
	else:
		$AnimationPlayer.play('DISSOLVE')
		$TextureRect/AnimatedSprite2D.play("load")
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file(target_path)
		rando = rng.randf_range(0.8,2) 
		await get_tree().create_timer(rando).timeout
		$AnimationPlayer.play_backwards('DISSOLVE')
		GlobalUtil.disable_movement = false
	
