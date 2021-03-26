extends Node2D
var overlays = ["res://icons/overlay gui0.png", "res://icons/overlay gui1.png", "res://icons/overlay gui2.png", "res://icons/overlay gui3.png", "res://icons/overlay gui4.png", "res://icons/overlay gui5.png", "res://icons/overlay gui6.png"]
var enemy1 = preload("res://game/Enemy.tscn")
var wave = 0
var finalscore = 0
var EndScreen = preload("res://game/EndScreen.tscn")
func _ready():
	waves()	
	
func _process(delta):
	if Input.is_action_pressed("esc menu"):
		get_tree().change_scene("res://TitleScreen.tscn")
		
func setDashOverlay(level:int):
	$CanvasLayer/GUI/TextureRect.texture = load(overlays[level])

func setHealth(HP:int):
	$CanvasLayer/GUI/Heart1.hide()
	$CanvasLayer/GUI/Heart2.hide()
	$CanvasLayer/GUI/Heart3.hide()	
	if HP == 1:
		$CanvasLayer/GUI/Heart1.show()
	if HP == 2:
		$CanvasLayer/GUI/Heart1.show()
		$CanvasLayer/GUI/Heart2.show()
	if HP == 3:
		$CanvasLayer/GUI/Heart1.show()
		$CanvasLayer/GUI/Heart2.show()
		$CanvasLayer/GUI/Heart3.show()

func setAmmoCount(amount:int):
	$"CanvasLayer/GUI/Ammo Label".text = str(amount)
	
func playerGetAmmo(amount:int):
	$Player.setAmmo(amount)
func playerAddAmmo():
	$Player.addAmmo()
func playerAddHealth():
	$Player.addHealth()
func playerIncFirerate():
	$Player.IncFirerate()	
func playerIncSpeed():
	$Player.IncSpeed()
func resetGame():
	get_tree().reload_current_scene()
func addScore(value:int):
	$CanvasLayer/GUI.setScore(value)

func setWave():
	$CanvasLayer/GUI.setWave(wave)
	
func waves():#updates waves display
	while true:
		wave += 1
		setWave()		
		yield(get_tree().create_timer(60.0), "timeout") #1 min delay

	
func showEndScreen():		
	var score = $CanvasLayer/GUI.getScore()
	get_tree().change_scene_to(EndScreen)
	#get_tree().get_root().get_node("EndScreen").setScore(score)
	
