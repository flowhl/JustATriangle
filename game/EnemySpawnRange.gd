extends Node2D
var enemy = preload("res://game/Enemy.tscn")

func _ready():
	spawnloop()
	
func spawnloop():
	while true:		
		var enemy_instance = enemy.instance()
		enemy_instance.position = get_global_position()
		get_tree().get_root().get_node("World").call_deferred("add_child", enemy_instance)
		yield(get_tree().create_timer(60.0), "timeout")
