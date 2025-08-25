extends Control


@onready var rich_text_label: RichTextLabel = $RichTextLabel

var started = false
var speed = 100
var last_scroll_value = 0

func _ready() -> void:
	start()

func _process(delta: float) -> void:
	if started:
		var scroll_bar = rich_text_label.get_v_scroll_bar()
		scroll_bar.value += speed * delta
		if last_scroll_value == scroll_bar.value:
			stop()
		last_scroll_value = scroll_bar.value

func start():
	await get_tree().create_timer(1.2).timeout
	started = true

func stop():
	await get_tree().create_timer(1).timeout
	LevelManager.go_to_main_menu()
	
