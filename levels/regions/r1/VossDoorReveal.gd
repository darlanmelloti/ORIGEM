## VossDoorReveal.gd
## Incremento R1 — revelação breve e não intrusiva ao abrir a porta E.
## Não desloca Elias, não altera colisões e não assume controlo da câmara.

class_name VossDoorReveal
extends Node

var has_played: bool = false

func play(house: Node3D) -> void:
	if has_played:
		return
	has_played = true
	_play_camera_breath()
	_create_route_marker(house)
	_show_route_card()

func _play_camera_breath() -> void:
	var player: Node = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	var camera: Camera3D = player.get_node_or_null("Head/Camera3D") as Camera3D
	if camera == null or not camera.is_current():
		return
	var original_fov: float = camera.fov
	var tween: Tween = create_tween()
	tween.tween_property(camera, "fov", maxf(52.0, original_fov - 5.0), 0.32).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.42)
	tween.tween_property(camera, "fov", original_fov, 0.55).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _create_route_marker(house: Node3D) -> void:
	var marker_root: Node3D = Node3D.new()
	marker_root.name = "PulsoDeOrientacaoEstradaDoRio"
	house.add_child(marker_root)
	var marker: MeshInstance3D = MeshInstance3D.new()
	marker.name = "MarcaTransitóriaDeOrion"
	var mesh: CylinderMesh = CylinderMesh.new()
	mesh.top_radius = 0.32
	mesh.bottom_radius = 0.32
	mesh.height = 0.018
	mesh.radial_segments = 20
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(0.06, 0.20, 0.44, 1.0)
	material.emission_enabled = true
	material.emission = Color(0.025, 0.16, 0.76, 1.0)
	material.emission_energy_multiplier = 1.05
	material.roughness = 0.36
	mesh.material = material
	marker.mesh = mesh
	# Fica ao lado do limiar, fora do corredor central, e dura apenas a revelação.
	marker.position = Vector3(2.62, 0.045, -5.28)
	marker_root.add_child(marker)
	var tween: Tween = create_tween()
	tween.tween_property(marker, "scale", Vector3(2.8, 1.0, 2.8), 1.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(marker_root.queue_free)

func _show_route_card() -> void:
	var scene_root: Node = get_tree().current_scene
	if scene_root == null:
		return
	var layer: CanvasLayer = CanvasLayer.new()
	layer.name = "RevelacaoEstradaDoRio"
	layer.layer = 9
	var panel: ColorRect = ColorRect.new()
	panel.color = Color(0.025, 0.038, 0.060, 0.86)
	panel.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	panel.position = Vector2(-220.0, -122.0)
	panel.size = Vector2(440.0, 74.0)
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(panel)
	var title: Label = Label.new()
	title.text = "ESTRADA DO RIO"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.position = Vector2(24.0, 10.0)
	title.size = Vector2(392.0, 28.0)
	title.add_theme_font_size_override("font_size", 19)
	title.add_theme_color_override("font_color", Color(0.71, 0.83, 1.0, 1.0))
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_child(title)
	var description: Label = Label.new()
	description.text = "Siga as lajes. O Arco das Ruínas espera a norte."
	description.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	description.position = Vector2(20.0, 39.0)
	description.size = Vector2(400.0, 25.0)
	description.add_theme_font_size_override("font_size", 14)
	description.add_theme_color_override("font_color", Color(0.88, 0.90, 0.94, 1.0))
	description.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_child(description)
	scene_root.add_child(layer)
	panel.modulate.a = 0.0
	var tween: Tween = create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 0.24)
	tween.tween_interval(3.1)
	tween.tween_property(panel, "modulate:a", 0.0, 0.55)
	tween.tween_callback(layer.queue_free)
