extends Node3D

@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var camera_3d: Camera3D = $Camera3D
@onready var test_sphere: MeshInstance3D = $TestSphere


var _last_mesh_instance

func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	var origin = camera_3d.project_ray_origin(mouse_position)
	var normal = camera_3d.project_local_ray_normal(mouse_position)
	var global_normal = camera_3d.project_ray_normal(mouse_position)
	ray_cast_3d.global_position = origin
	ray_cast_3d.target_position = normal * 100
	ray_cast_3d.force_raycast_update()
	test_sphere.global_position = origin + global_normal * 10
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		var mesh_instance = collider.get_child(0) as MeshInstance3D
		mesh_instance["surface_material_override/0"].stencil_outline_thickness = 0.1
		_last_mesh_instance = mesh_instance
	else:
		if _last_mesh_instance:
			_last_mesh_instance["surface_material_override/0"].stencil_outline_thickness = 0
