extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	PlayerActions.move_clockwise()
	var tween: Tween = create_tween()
	tween.tween_property(
		body, "global_position",
		global_position,
		PlayerActions.spin_animation_time
	)
