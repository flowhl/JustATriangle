extends Node2D
var score = 0

func _ready():
	pass

func setScore(value:int):
	score = value
	scoreUpdate()
	
func getScore():
	return score
	scoreUpdate()
	
func addScore(value:int):
	score += value
	scoreUpdate()
	
func scoreUpdate():
	$ScoreLabel.text = str(score) 

func setWave(value:int):
	$WaveLabel.text = str("wave " + str(value))
