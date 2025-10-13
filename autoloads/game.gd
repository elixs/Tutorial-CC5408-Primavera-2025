extends Node

signal coins_changed(value)

var coins = 0:
	set(value):
		coins = value
		coins_changed.emit(coins)

var points = 0
