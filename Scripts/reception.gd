extends Node


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
