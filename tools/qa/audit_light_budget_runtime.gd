extends Node

const MAIN_SCENE: PackedScene = preload("res://scenes/main.tscn")
const MAX_SIMULTANEOUS_LIGHTS := 16

func _ready() -> void:
	call_deferred("_run_audit")

func _run_audit() -> void:
	var world_root := MAIN_SCENE.instantiate()
	get_tree().root.add_child(world_root)
	# Executa sob o ciclo normal de cena: autoloads e construtores diferidos já estão activos.
	for frame_index in range(180):
		await get_tree().process_frame
	var camera := get_viewport().get_camera_3d()
	if camera == null:
		push_error("[QA-BUDGET-01] no_active_camera")
		get_tree().quit(2)
		return
	var all_visible: Array[Light3D] = []
	var simultaneous: Array[Light3D] = []
	for node: Node in get_tree().root.find_children("*", "Light3D", true, false):
		var light := node as Light3D
		if light == null or not light.is_visible_in_tree():
			continue
		all_visible.append(light)
		if _affects_active_camera(light, camera):
			simultaneous.append(light)
	print("[QA-BUDGET-01] global_visible_lights=%d simultaneous_camera_lights=%d limit=%d camera=%s" % [all_visible.size(), simultaneous.size(), MAX_SIMULTANEOUS_LIGHTS, camera.get_path()])
	for light: Light3D in simultaneous:
		print("[QA-BUDGET-01] simultaneous=%s class=%s energy=%.3f" % [light.get_path(), light.get_class(), light.light_energy])
	if simultaneous.size() > MAX_SIMULTANEOUS_LIGHTS:
		push_error("[QA-BUDGET-01] simultaneous_budget_exceeded=%d>%d" % [simultaneous.size(), MAX_SIMULTANEOUS_LIGHTS])
		get_tree().quit(2)
		return
	print("[QA-BUDGET-01] result=PASS")
	get_tree().quit(0)

func _affects_active_camera(light: Light3D, camera: Camera3D) -> bool:
	if light is DirectionalLight3D:
		return true
	var influence_range := 0.0
	if light is OmniLight3D:
		influence_range = (light as OmniLight3D).omni_range
	elif light is SpotLight3D:
		influence_range = (light as SpotLight3D).spot_range
	if influence_range <= 0.0:
		return false
	for plane: Plane in camera.get_frustum():
		if plane.distance_to(light.global_position) < -influence_range:
			return false
	return true
