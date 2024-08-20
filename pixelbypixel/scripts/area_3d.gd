extends Area3D

const Player = preload("player.gd")


func _on_body_entered(body: Node3D) -> void:
	var script = body.get_script()
	script.near_shrink_ray = true

func _on_body_exited(body: Node3D) -> void:
	var script = body.get_script()
	script.near_shrink_ray = false
