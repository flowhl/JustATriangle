extends KinematicBody2D
var HealthPowerup = load("res://game/HealthPowerup.tscn")
var AmmoPowerup = load("res://game/AmmoPowerup.tscn")
var FireratePowerup = load("res://game/FireratePowerup.tscn")
var SpeedPowerup = load("res://game/SpeedPowerup.tscn")
func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "PlayerBullet":
		var randomint = randi() % 5
		if randomint == 0: 
			var HealthPowerup_instance = HealthPowerup.instance()
			HealthPowerup_instance.position = get_global_position() 
			HealthPowerup_instance.rotation_degrees = rotation_degrees
			get_tree().get_root().call_deferred("add_child", HealthPowerup_instance)
		else:if randomint == 1: 
			var FireratePowerup_instance = FireratePowerup.instance()
			FireratePowerup_instance.position = get_global_position() 
			FireratePowerup_instance.rotation_degrees = rotation_degrees
			get_tree().get_root().call_deferred("add_child", FireratePowerup_instance)
		else:if randomint == 2: 
			var SpeedPowerup_instance = SpeedPowerup.instance()
			SpeedPowerup_instance.position = get_global_position() 
			SpeedPowerup_instance.rotation_degrees = rotation_degrees
			get_tree().get_root().call_deferred("add_child", SpeedPowerup_instance)
		else:
			var AmmoPowerup_instance = AmmoPowerup.instance()
			AmmoPowerup_instance.position = get_global_position() 
			AmmoPowerup_instance.rotation_degrees = rotation_degrees
			get_tree().get_root().call_deferred("add_child", AmmoPowerup_instance)		
		queue_free()
