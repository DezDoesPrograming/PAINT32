extends Node2D
@onready var savefile = "res://Scripts/SaveFile.txt"
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
@onready var isBusy = false
signal loadpanel

func _ready():
	canvas = str_to_var(FileAccess.get_file_as_string(savefile))
	
	var names = 0
	for i in range(32):
		for o in range(32):
			var newpanel = $ClrPanel.duplicate()
			add_child(newpanel)
			newpanel.name = str(names)
			newpanel.color = Color.html(colortable[canvas[names]])
			names += 1
			$ClrPanel.position.x += 20
		$ClrPanel.position.y += 20
		$ClrPanel.position.x -= 640
	$ClrPanel.free()

func _on_clr_panel_sendclrdata(clr, index):
	canvas[index] = clr
	FileAccess.open(savefile, FileAccess.WRITE).store_string(str(canvas))

func _process(delta):
	if Input.is_action_just_pressed("Save") && isBusy == false:
		isBusy = true
		var savestring = ""
		$GUI/ConfrimSave.popup()
		await $GUI/ConfrimSave.confirmed || $GUI/ConfrimSave.canceled || $GUI/ConfrimSave.close_requested
		if $GUI/ConfrimSave.confirmed:
			for i in range(1200):
				savestring = savestring + str(canvas[i])
				DisplayServer.clipboard_set(savestring)
		isBusy = false
	
	if Input.is_action_pressed("Load") && isBusy == false:
		isBusy = true
		$GUI/ConfirmLoad.popup()
		await $GUI/ConfirmLoad.confirmed || $GUI/ConfirmLoad.canceled || $GUI/ConfirmLoad.close_requested
		if $GUI/ConfirmLoad.confirmed:
			var loadstring = $GUI/ConfirmLoad/LineEdit.text
			for i in range(1200):
				canvas[i] = str_to_var(loadstring.substr(i, 1))
			for i in range(1200):
				if canvas[i] == null:
					canvas[i] = 9
			FileAccess.open(savefile, FileAccess.WRITE).store_string(str(canvas))
			$GUI/ConfirmLoad/LineEdit.clear()
			emit_signal("loadpanel")
		isBusy = false
