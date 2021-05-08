extends Control

var can_touch = false
var have_save = false

func _ready():
	check_save_file()
	reset_icon()
func _process(delta):
	if Input.is_action_just_pressed("player_interact"):
		if can_touch:
			if not have_save:
				_on_btnPlay_released()
			else:
				_on_btnContinue_released()
		else:
			_on_btnSkip_released()
	
	if can_touch:
		$anmMain.playback_speed = 1

func activate_touch():
	can_touch = true

func check_save_file():
	if not GameManeger.check_save_file():
		$Play/txtContinue.visible = false
		$Play/txtNewGame.visible = false
		$Play/txtPlay.visible = true
		
		have_save = false
	else:
		$Play/txtContinue.visible = true
		$Play/txtNewGame.visible = true
		$Play/txtPlay.visible = false
		
		have_save = true

func _on_btnPlay_released():
	if can_touch:
		SceneManeger.change_scene("res://Scenes/Cutscenes/scnIntro.tscn")
		$sfxButton.play()
func _on_btnContinue_released():
	if can_touch:
		SceneManeger.change_scene(GameManeger.info.currect_scene)
		$sfxButton.play()
func _on_btnNewGame_released():
	if can_touch:
		_on_btnPlay_released()
		GameManeger.info.on_tutorial = true

func _on_btnSkip_released():
	$anmMain.playback_speed = 3

func _on_btnTwitter_released():
	if can_touch:
		OS.shell_open("https://twitter.com/ahopness")

func prank():
	if OS.get_datetime(false).hour == 3:
		if not GameManeger.globals.did_prank:
			GameManeger.globals.did_prank = true
			get_tree().change_scene("res://Scenes/Misc/scn3AM.tscn")
		
		$musAveMaria.stream = load("res://Sounds/MUS/musAveMaria2.ogg")
	else:
		$musAveMaria.stream = load("res://Sounds/MUS/musAveMaria.ogg")

func reset_icon():
	OS.set_icon(load("res://Data/Icons/iconMain.png")) 
