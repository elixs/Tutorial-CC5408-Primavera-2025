class_name Hurtbox
extends Area2D

@export var health_component: HealthComponent

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	var hitbox = area as Hitbox
	if hitbox:
		if health_component:
			health_component.health -= hitbox.damage
			hitbox.damage_dealt.emit()
		#if owner.has_method("take_damage"):
			#owner.take_damage(hitbox.damage)
		
