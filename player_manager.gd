extends Node
class_name PlayerManager

var players := {}

func add_player(id: int) -> Player:
	var player := preload("res://player.tscn").instantiate() as Player
	players[id] = player
	player.name = "Player" + str(id)
	player.global_position = Vector2(100, 100)
	add_child(player)
	return player

func get_player(id: int) -> Player:
	return players[id]

func remove_player(id: int) -> void:
	players.erase(id)
