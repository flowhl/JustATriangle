extends Node2D


func _ready():
	pass

func setScore(score:int):
	$FinalScore.text = str(score)
