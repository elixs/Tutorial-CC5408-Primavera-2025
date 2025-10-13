extends CanvasLayer

@onready var continue_button: Button = %ContinueButton
@onready var retry_button: Button = %RetryButton
@onready var main_menu_button: Button = %MainMenuButton
@onready var save_game_button: Button = %SaveGameButton
@onready var load_game_button: Button = %"LoadGameButton"


func _ready() -> void:
	continue_button.pressed.connect(_on_continue_pressed)
	retry_button.pressed.connect(_on_retry_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	save_game_button.pressed.connect(save_game)
	load_game_button.pressed.connect(load_game)
	visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused


func _on_continue_pressed():
	visible = false
	get_tree().paused = false


func _on_retry_pressed():
	visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_main_menu_pressed():
	visible = false
	get_tree().paused = false
	LevelManager.go_to_main_menu()


func save_game():
	var data = {
		"coins": Game.coins,
		"lives": 2,
		"player_name" : "pepito"
	}
	var data_string = JSON.stringify(data)
	
	var file = FileAccess.open_encrypted_with_pass("user://save.data", FileAccess.WRITE, "1234")
	file.store_string(data_string)
	
	var config = ConfigFile.new()
	config.set_value("Video", "Fullscreen", false)
	config.set_value("Video", "Resolution", "1920x1080")
	config.set_value("Audio", "Music", 0.5)
	config.set_value("Audio", "SFX", 0.1)

	config.save("user://settings.cfg")


func load_game():
	var file = FileAccess.open_encrypted_with_pass("user://save.data", FileAccess.READ, "1234")
	var data_string = file.get_as_text()
	var data = JSON.parse_string(data_string)
	Game.coins = int(data["coins"])
	
