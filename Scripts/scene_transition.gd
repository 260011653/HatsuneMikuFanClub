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
	[16,0]: ["level2.tscn","down"]
	}
	
}

const scene_starting_positions = {
	"reception": {
		"down": Vector2(136,18)
	},
	"level1": {
		"up": Vector2(264,16),
		"down": Vector2(232,16)
	},
	"level2": {
		"up": Vector2(264,16),
		"down": Vector2(232,16)
	},
	"level3": {
		"up": Vector2(264,16),
	}
}


var last_direction = ""

func change_scene(target: String, direction: String) -> void:
	SceneTransition.last_direction = direction
	var target_path = "res://Scenes/"+target
	$AnimationPlayer.play('DISSOLVE')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target_path)
	$AnimationPlayer.play_backwards('DISSOLVE')
	
