## RegionalCinematicDirector.gd
## Realização reutilizável para os sete takes do mapa regional.
## Os takes são apresentados como introduções curtas de regiões reais; não definem a escala total do mundo.

extends Node

const TAKE_DURATION_SECONDS: float = 4.5

var active_camera: Camera3D
var saved_camera: Camera3D
var playing: bool = false

# Cada entrada traduz o vídeo cinematográfico para um ponto físico do mapa regional.
func _ready() -> void:
	# Modo restrito a QA: permite capturar um take físico do mundo sem introduzir uma cinemática automática no jogo final.
	if OS.has_environment("ORIGEM_CAPTURE_TAKE"):
		var requested_take: int = int(OS.get_environment("ORIGEM_CAPTURE_TAKE"))
		print("[ORIGEM_QA] Take solicitado: %d" % requested_take)
		call_deferred("_play_capture_take", requested_take)

func _play_capture_take(take_id: int) -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	print("[ORIGEM_QA] A iniciar take: %d" % take_id)
	# A cena regional pode levar vários segundos a carregar no renderizador de QA; manter a câmara ativa evita capturar o retorno ao jogador.
	play_region_take(take_id, 35.0)

const TAKE_FRAMES: Dictionary = {
	1: {"position": Vector3(-33.0, 5.5, 3.0), "target": Vector3(-7.0, 1.5, 47.0), "fov": 52.0},
	2: {"position": Vector3(-13.0, 3.4, 29.0), "target": Vector3(-8.0, 3.0, 48.0), "fov": 48.0},
	3: {"position": Vector3(-2.0, 5.0, 60.0), "target": Vector3(-12.0, 2.5, 92.0), "fov": 50.0},
	4: {"position": Vector3(31.5, 5.4, 231.0), "target": Vector3(59.0, 1.7, 251.0), "fov": 43.0},
	5: {"position": Vector3(72.0, 27.5, 313.0), "target": Vector3(168.0, 12.0, 385.0), "fov": 50.0},
	6: {"position": Vector3(22.0, 37.0, 462.0), "target": Vector3(-98.0, 47.0, 535.0), "fov": 51.0},
	7: {"position": Vector3(-112.0, 53.0, 543.0), "target": Vector3(-116.0, 48.0, 562.0), "fov": 47.0}
}

func play_region_take(take_id: int, duration: float = TAKE_DURATION_SECONDS) -> void:
	if playing or not TAKE_FRAMES.has(take_id):
		print("[ORIGEM_QA] Take inválido ou já em execução")
		return
	var frame: Dictionary = TAKE_FRAMES[take_id] as Dictionary
	var player: Node = get_tree().get_first_node_in_group("player")
	if player == null:
		print("[ORIGEM_QA] Player não encontrado")
		return
	var player_camera: Camera3D = player.get_node_or_null("Head/Camera3D") as Camera3D
	if player_camera == null:
		print("[ORIGEM_QA] Câmara do player não encontrada")
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
	print("[ORIGEM_QA] Câmara do take ativa em %s" % [active_camera.global_position])
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
