extends RichTextLabel
var minutes = 0
var seconds = 0
var minutesTemp = "0"
var secondsTemp = "0"
func _ready():
	pass

func _process(delta):
	if seconds > 59:
		minutes += 1
		seconds = 0
	secondsTemp = seconds
	minutesTemp = minutes
	if minutes < 10:
		minutesTemp = "0" + str(minutes) 
	if seconds < 10:
		secondsTemp = "0" + str(seconds)
	
	bbcode_text = ("[center]" +  str(minutesTemp + ":" + str(secondsTemp)) + "[/center]")
	


func _on_Timer_timeout():
	seconds += 1
