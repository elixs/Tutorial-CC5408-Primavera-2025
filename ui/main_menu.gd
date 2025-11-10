extends Control


@onready var start_button: Button = %StartButton
@onready var credits_button: Button = %CreditsButton
@onready var quit_button: Button = %QuitButton
@onready var http_request: HTTPRequest = $HTTPRequest
@onready var joke: Label = %Joke
@onready var window_quit_button: Button = %WindowQuitButton

@export var click_sound: AudioStream


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(func(): get_tree().quit())
	window_quit_button.pressed.connect(func(): get_tree().quit())
	load_config()
	http_request.request_completed.connect(_on_request_completed)
	var result = http_request.request("https://official-joke-api.appspot.com/random_joke")
	if result != OK:
		Debug.log("Api failed")


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


func _on_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	joke.text = response.setup + "\n" + response.punchline
