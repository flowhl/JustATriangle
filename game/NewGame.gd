extends Node2D
var overlays = ["res://icons/overlay gui0.png", "res://icons/overlay gui1.png", "res://icons/overlay gui2.png", "res://icons/overlay gui3.png", "res://icons/overlay gui4.png", "res://icons/overlay gui5.png", "res://icons/overlay gui6.png"]


func _ready():
	pass
	
	
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
