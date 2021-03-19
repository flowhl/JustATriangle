extends KinematicBody2D
var movespeed = 500
var movespeed_old
var dashspeed = 2000
var bulletspeed = 1000
var bullet = preload("res://game/bullet.tscn")
var fire_rate = 0.1
var dash_ready = true
var dash_counter_temp = 0;
var dash_status = 5
func _ready():
	pass
func _physics_process(delta):
	var motion = Vector2()
	if dash_counter_temp >= 10:
		dash_counter_temp = 0
		dash_ready = false
		dash_status = 0
		reload_dash()
	if Input.is_action_pressed("dash") && dash_ready:
		movespeed_old = movespeed
		movespeed = dashspeed
		dash_counter_temp = dash_counter_temp + 1 
		
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y +=1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1	
	if Input.is_action_pressed("shoot"):
		fire()		
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
	if movespeed == dashspeed:
		movespeed = movespeed_old		
	look_at(get_global_mouse_position())
	
	
	
func fire():	
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position() 
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bulletspeed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	
func reload_dash():
	for n in range(1,6):
		yield(get_tree().create_timer(1.0), "timeout")
		dash_status = n	
	dash_counter_temp = 0
	dash_ready = true
	
	
