extends KinematicBody2D
var movespeed = 500
var movespeed_old
var dashspeed = 2000
var bulletspeed = 2000
var Playerbullet = preload("res://game/PlayerBullet.tscn")
var dash_ready = true
var dash_counter_temp = 0;
var dash_status = 5
func _ready():
	pass
	
	
var fire_rate : float = 10 #Fire rate 10 bullets per second
onready var update_delta : float = 1 / fire_rate
var current_time : float = 0

func _process(delta):
	SkillLoop(delta)
func _physics_process(delta):
	MovementLoop()
		
func MovementLoop():
	var motion = Vector2()
	if dash_counter_temp >= 10:
		dash_counter_temp = 0
		dash_ready = false
		dash_status = 0		
		reload_dash()
	if Input.is_action_pressed("dash") && dash_ready:
		if !$dashSound.playing && dash_counter_temp == 0:
			$dashSound.play()
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
	
		
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
	if movespeed == dashspeed:
		movespeed = movespeed_old		
	look_at(get_global_mouse_position())
func SkillLoop(var delta):
	current_time += delta
	if (current_time < update_delta):
		return
	if Input.is_action_pressed("shoot"):
		current_time = 0
		fire()		
		
func death():
	$deathSound.play()
	$Sprite.hide()
	$Particles2D.hide()
	$deathExplosion.emitting = true
	yield(get_tree().create_timer(1.0), "timeout")
	$deathExplosion.emitting = false
	yield(get_tree().create_timer(4.0), "timeout")
	get_tree().reload_current_scene()
	
func _on_Area2D_body_entered(body):
	if "Enemybullet" in body.name:
		death()
	if "Enemy" in body.name:
		death()
	
func fire():	
	var Playerbullet_instance = Playerbullet.instance()
	Playerbullet_instance.position = get_global_position() 
	Playerbullet_instance.rotation_degrees = rotation_degrees
	Playerbullet_instance.apply_impulse(Vector2(), Vector2(bulletspeed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", Playerbullet_instance)
	$shootSound.play()
	
func reload_dash():
	for n in range(1,6):
		yield(get_tree().create_timer(1.0), "timeout")
		dash_status = n	
	dash_counter_temp = 0
	dash_ready = true
	$dashreload.play()




