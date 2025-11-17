extends CanvasLayer

enum Fade {
	TYPE_1,
	TYPE_2
}

@export var type: Fade = Fade.TYPE_1


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect
@onready var color_rect_2: ColorRect = $ColorRect2


func fade(callable: Callable) -> void:
	color_rect.visible = type == Fade.TYPE_1
	color_rect_2.visible = type == Fade.TYPE_2
	
	
	get_tree().paused = true
	animation_player.play("fade_out")
	await animation_player.animation_finished
	await callable.call()
	animation_player.play("fade_in")
	await animation_player.animation_finished
	get_tree().paused = false
