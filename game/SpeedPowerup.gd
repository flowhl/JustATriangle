extends KinematicBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().get_root().get_node("World").playerIncSpeed()
		queue_free()
