extends Control

func _on_host_button_pressed() -> void:
	var gameplay := preload("res://gameplay.tscn").instantiate() as Gameplay
	gameplay.start_server()
	get_tree().root.add_child(gameplay)
	queue_free()

func _on_join_button_pressed() -> void:
	var gameplay := preload("res://gameplay.tscn").instantiate() as Gameplay
	gameplay.start_client()
	get_tree().root.add_child(gameplay)
	queue_free()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
