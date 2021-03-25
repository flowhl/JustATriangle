extends KinematicBody2D

var movespeed = 500
var movespeed_old
var dashspeed = 2000

var bulletspeed = 2000 
var Playerbullet = preload("res://game/PlayerBullet.tscn") #bullet instance
var fire_rate : float = 10 #Fire rate 10 bullets per second
onready var update_delta : float = 1 / fire_rate
var current_time : float = 0
var ammo = 100

var dash_ready = true #dash usable
var dash_counter_temp = 0; #used for dash timer
var dash_status = 6 #dash charge status

var alive = true 
var HP = 3 #health
var detecthits = true #seems to fix hits being detected twice

func _ready():
	setHealth()
	get_tree().get_root().get_node("World").setAmmoCount(ammo)


func _process(delta):
	SkillLoop(delta)
func _physics_process(delta):
	MovementLoop()

func MovementLoop():
	var motion = Vector2()
	#Dash
	if dash_counter_temp >= 10:
		dash_counter_temp = 0
		dash_ready = false
		dash_status = 0		
		reload_dash()
	#Dash Button
	if Input.is_action_pressed("dash") && dash_ready:
		if !$dashSound.playing && dash_counter_temp == 0:
			$dashSound.play()
		movespeed_old = movespeed
		movespeed = dashspeed
		dash_counter_temp = dash_counter_temp + 1 
	#basic movement
	if Input.is_action_pressed("up") && alive:
		motion.y -= 1
	if Input.is_action_pressed("down") && alive:
		motion.y +=1
	if Input.is_action_pressed("left") && alive:
		motion.x -= 1
	if Input.is_action_pressed("right") && alive:
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
	alive = false
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
		damage()		
	if "Enemy" in body.name:
		damage()
	
func fire():	
	if ammo > 0:
		var Playerbullet_instance = Playerbullet.instance()
		Playerbullet_instance.position = get_global_position() 
		Playerbullet_instance.rotation_degrees = rotation_degrees
		Playerbullet_instance.apply_impulse(Vector2(), Vector2(bulletspeed,0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child", Playerbullet_instance)
		$shootSound.play()
		ammo -= 1
		get_tree().get_root().get_node("World").setAmmoCount(ammo)
func reload_dash():
	get_tree().get_root().get_node("World").setDashOverlay(0)
	for n in range(1,7):
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().get_root().get_node("World").setDashOverlay(n)
		dash_status = n	
	dash_counter_temp = 0
	dash_ready = true
	get_tree().get_root().get_node("World").setDashOverlay(6)
	$dashreload.play()

func setHealth():
	if HP == 0:
		death()	
	get_tree().get_root().get_node("World").setHealth(HP)
	yield(get_tree().create_timer(1.0), "timeout")

func damage(): 
	if detecthits:
		if HP -1 <= 0:
			death()
		if detecthits:
			HP = HP -1
		detecthits = false
	else:
		detecthits = true
	setHealth()

func addHealth():
	if HP + 1 <= 3:
		HP = HP +1
	setHealth()
	
func damageDelay():
	detecthits = false
	yield(get_tree().create_timer(1.0), "timeout")
	detecthits = true
	
func setAmmo(amount:int):
	ammo += amount
	get_tree().get_root().get_node("World").setAmmoCount(ammo)

func IncFirerate():
	fire_rate += 20
	
func IncSpeed():
	movespeed += 100
func addAmmo():
	setAmmo(ammo + 50)
