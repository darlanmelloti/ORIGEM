## RegionalCinematicDirector.gd
## Realização reutilizável para os sete takes do mapa regional.
## Os takes são apresentados como introduções curtas de regiões reais; não definem a escala total do mundo.

extends Node

const TAKE_DURATION_SECONDS: float = 4.5

var active_camera: Camera3D
var saved_camera: Camera3D
var playing: bool = false

# Cada entrada traduz o vídeo cinematográfico para um ponto físico do mapa regional.
const TAKE_FRAMES: Dictionary = {
	1: {"position": Vector3(-33.0, 5.5, 3.0), "target": Vector3(-7.0, 1.5, 47.0), "fov": 52.0},
	2: {"position": Vector3(-13.0, 3.4, 29.0), "target": Vector3(-8.0, 3.0, 48.0), "fov": 48.0},
	3: {"position": Vector3(-2.0, 5.0, 60.0), "target": Vector3(-12.0, 2.5, 92.0), "fov": 50.0},
	4: {"position": Vector3(-12.0, 3.0, 112.0), "target": Vector3(-4.0, 2.0, 164.0), "fov": 54.0},
	5: {"position": Vector3(86.0, 24.0, 310.0), "target": Vector3(140.0, 10.0, 354.0), "fov": 56.0},
	6: {"position": Vector3(22.0, 37.0, 462.0), "target": Vector3(-98.0, 47.0, 535.0), "fov": 51.0},
	7: {"position": Vector3(-112.0, 53.0, 543.0), "target": Vector3(-116.0, 48.0, 562.0), "fov": 47.0}
}

func play_region_take(take_id: int, duration: float = TAKE_DURATION_SECONDS) -> void:
	if playing or not TAKE_FRAMES.has(take_id):
		return
	var frame: Dictionary = TAKE_FRAMES[take_id] as Dictionary
	var player: Node = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	var player_camera: Camera3D = player.get_node_or_null("Head/Camera3D") as Camera3D
	if player_camera == null:
		return
	playing = true
	saved_camera = player_camera
	active_camera = Camera3D.new()
	active_camera.name = "TakeCinematografico_%02d" % take_id
	get_tree().current_scene.add_child(active_camera)
	active_camera.global_position = frame["position"] as Vector3
	active_camera.fov = float(frame["fov"])
	active_camera.look_at(frame["target"] as Vector3, Vector3.UP)
	active_camera.current = true
	await get_tree().create_timer(duration).timeout
	_finish_take()

func _finish_take() -> void:
	if saved_camera != null:
		saved_camera.current = true
	if active_camera != null and is_instance_valid(active_camera):
		active_camera.queue_free()
	active_camera = null
	saved_camera = null
	playing = false
