extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.top_speed = 1200
		body.acceleration = 5


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.top_speed = 600
		body.acceleration = 3
