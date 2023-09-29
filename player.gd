extends Sprite2D
class_name Player

var movement := Vector2.ZERO

func set_movement(new_movement: Vector2) -> void:
	movement = new_movement

func _process(delta: float) -> void:
	global_position += movement * 500 * delta
