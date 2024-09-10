extends Node

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/reception.tscn")
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
