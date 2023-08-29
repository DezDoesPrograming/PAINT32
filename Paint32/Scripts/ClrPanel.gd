extends ColorRect
@onready var button = $ClrButton
@onready var canvas = []
@onready var colortable = [
	"ffffff",
	"000000",
	"653100",
	"ff0000",
	"ff7b00",
	"fff700",
	"10ff00",
	"0084ff",
	"8000ff",
	"ff00f6"
]
@onready var savefile = "res://Scripts/SaveFile.txt"
@onready var coloridx = 0
signal sendclrdata(clr, index)

func _ready():
	get_parent().loadpanel.connect(self.loadpanel)

func _process(delta):
	if color == Color.html(colortable[0]):
		coloridx = 0
	elif color == Color.html(colortable[1]):
		coloridx = 1
	elif color == Color.html(colortable[2]):
		coloridx = 2
	elif color == Color.html(colortable[3]):
		coloridx = 3
	elif color == Color.html(colortable[4]):
		coloridx = 4
	elif color == Color.html(colortable[5]):
		coloridx = 5
	elif color == Color.html(colortable[6]):
		coloridx = 6
	elif color == Color.html(colortable[7]):
		coloridx = 7
	elif color == Color.html(colortable[8]):
		coloridx = 8
	elif color == Color.html(colortable[9]):
		coloridx = 9
	else:
		coloridx = 9

func _on_clr_button_pressed():
	if Input.is_key_pressed(KEY_1) || Input.is_key_pressed(KEY_KP_1):
		coloridx = 0
	elif Input.is_key_pressed(KEY_2) || Input.is_key_pressed(KEY_KP_2):
		coloridx = 1
	elif Input.is_key_pressed(KEY_3) || Input.is_key_pressed(KEY_KP_3):
		coloridx = 2
	elif Input.is_key_pressed(KEY_4) || Input.is_key_pressed(KEY_KP_4):
		coloridx = 3
	elif Input.is_key_pressed(KEY_5) || Input.is_key_pressed(KEY_KP_5):
		coloridx = 4
	elif Input.is_key_pressed(KEY_6) || Input.is_key_pressed(KEY_KP_6):
		coloridx = 5
	elif Input.is_key_pressed(KEY_7) || Input.is_key_pressed(KEY_KP_7):
		coloridx = 6
	elif Input.is_key_pressed(KEY_8) || Input.is_key_pressed(KEY_KP_8):
		coloridx = 7
	elif Input.is_key_pressed(KEY_9) || Input.is_key_pressed(KEY_KP_9):
		coloridx = 8
	elif Input.is_key_pressed(KEY_0) || Input.is_key_pressed(KEY_KP_0):
		coloridx = 9
	elif Input.is_key_pressed(KEY_SHIFT):
		coloridx -= 1
		if coloridx < 0:
			coloridx = 9
	else:
		coloridx += 1
		if coloridx > 9:
			coloridx = 0
	
	color = Color.html(colortable[coloridx])
	emit_signal("sendclrdata", coloridx, str_to_var(name))

func loadpanel():
	canvas = str_to_var(FileAccess.get_file_as_string(savefile))
	coloridx = canvas[str_to_var(name)]
	color = Color.html(colortable[coloridx])
