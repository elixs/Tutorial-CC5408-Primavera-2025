extends Control


@onready var start_button: Button = %StartButton
@onready var credits_button: Button = %CreditsButton
@onready var quit_button: Button = %QuitButton

@export var click_sound: AudioStream


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(func(): get_tree().quit())
	load_config()


func _on_start_pressed():
	LevelManager.go_next_level()
	AudioManager.play_sfx(click_sound)


func _on_credits_pressed():
	LevelManager.go_to_credits()


func load_config() -> void:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		return
	
	var fullscreen = config.get_value("Video", "Fullscreen", false)
	get_window().mode = Window.MODE_FULLSCREEN if fullscreen else Window.MODE_WINDOWED
