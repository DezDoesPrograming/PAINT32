extends AcceptDialog

func _ready():
	popup_centered()

func _process(delta):
	if Input.is_action_just_pressed("Info"):
		popup_centered()
