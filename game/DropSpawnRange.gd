extends Node2D
var drop = preload("res://game/LootBox.tscn")

func _ready():
	spawnloop()
	
func spawnloop():
	while true:		
		var drop_instance = drop.instance()
		drop_instance.position = get_global_position()
		get_tree().get_root().get_node("World").call_deferred("add_child", drop_instance)
		yield(get_tree().create_timer(60.0), "timeout")
