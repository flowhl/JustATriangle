extends Control


func _ready():
	var parts = ["a","b", "c"]
	var text = "Lorem ipsum %s dolor sit amet, consetetur sadipscing elitr, %s diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam %s erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."
	print(text % parts)
