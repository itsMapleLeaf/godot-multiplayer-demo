extends Node
class_name Gameplay

const PORT = 42069

@onready var player_manager := $PlayerManager as PlayerManager

var peer := ENetMultiplayerPeer.new()
var self_player: Player

func start_server() -> void:
	peer.create_server(PORT)

func start_client() -> void:
	peer.create_client("127.0.0.1", PORT)

func _ready() -> void:
	peer.peer_connected.connect(_on_peer_connected)
	peer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.multiplayer_peer = peer
	
	self_player = player_manager.add_player(multiplayer.get_unique_id())

func _on_peer_connected(id: int) -> void:
	player_manager.add_player(id)
	
func _on_peer_disconnected(id: int) -> void:
	player_manager.remove_player(id)

func _process(delta: float) -> void:
	var movement := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if is_multiplayer_authority():
		self_player.set_movement(movement)
	else:
		_set_player_movement.rpc_id(1, movement)

@rpc("any_peer", "unreliable")
func _set_player_movement(movement: Vector2) -> void:
	var player := player_manager.get_player(multiplayer.get_remote_sender_id())
	player.set_movement(movement)
