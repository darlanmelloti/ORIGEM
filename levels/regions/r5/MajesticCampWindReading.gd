## MajesticCampWindReading.gd
## DEV5-R5-CAMP-WIND-READING-002
## Movimento visual discreto para lonas de chegada e cordas do suporte de expedição.
## Sem física de pano, partículas, luzes, criação contínua de nós ou alteração de navegação.

class_name R5MajesticCampWindReading
extends Node

const NODE_NAME: String = "R5LeituraDeVentoDoAcampamento"
const TARP_SWAY_RADIANS: float = 0.045
const TARP_PULSE: float = 0.018
const ROPE_SWAY_RADIANS: float = 0.032
const ROPE_LIFT: float = 0.012
const WIND_SPEED: float = 0.72

var _elapsed: float = 0.0
var _tarps: Array[MeshInstance3D] = []
var _ropes: Array[MeshInstance3D] = []
var _base_transforms: Dictionary = {}
var _phases: Dictionary = {}

static func install(camp: Node3D, artifact_trail: Node) -> R5MajesticCampWindReading:
	if camp == null or artifact_trail == null:
		return null
	var existing: R5MajesticCampWindReading = camp.get_node_or_null(NODE_NAME) as R5MajesticCampWindReading
	if existing != null:
		return existing
	var reading: R5MajesticCampWindReading = R5MajesticCampWindReading.new()
	reading.name = NODE_NAME
	camp.add_child(reading)
	reading._bind(camp, artifact_trail)
	return reading

func _bind(camp: Node3D, artifact_trail: Node) -> void:
	for tarp_node: Node in camp.find_children("LonaDeChegadaMajestic_*", "MeshInstance3D", true, false):
		var tarp: MeshInstance3D = tarp_node as MeshInstance3D
		if tarp != null:
			_register_tarp(tarp, 0.63 + float(_tarps.size()) * 1.71)
	for rope_node: Node in artifact_trail.find_children("CordaEnroladaMajestic_*", "MeshInstance3D", true, false):
		var rope: MeshInstance3D = rope_node as MeshInstance3D
		if rope != null:
			_register_rope(rope, 1.18 + float(_ropes.size()) * 1.37)
	set_meta("r5_wind_tarps", _tarps.size())
	set_meta("r5_wind_ropes", _ropes.size())
	set_meta("r5_wind_dynamic_lights", 0)
	set_meta("r5_wind_node_creation_after_ready", false)
	print("[ORIGEM_R5_WIND] lonas=%d cordas=%d luzes=0" % [_tarps.size(), _ropes.size()])

func _register_tarp(target: MeshInstance3D, phase: float) -> void:
	_tarps.append(target)
	_base_transforms[target.get_instance_id()] = target.transform
	_phases[target.get_instance_id()] = phase

func _register_rope(target: MeshInstance3D, phase: float) -> void:
	_ropes.append(target)
	_base_transforms[target.get_instance_id()] = target.transform
	_phases[target.get_instance_id()] = phase

func _process(delta: float) -> void:
	_elapsed += delta
	for tarp: MeshInstance3D in _tarps:
		_apply_tarp_motion(tarp)
	for rope: MeshInstance3D in _ropes:
		_apply_rope_motion(rope)

func _apply_tarp_motion(tarp: MeshInstance3D) -> void:
	if not is_instance_valid(tarp):
		return
	var base: Transform3D = _base_transforms.get(tarp.get_instance_id(), tarp.transform) as Transform3D
	var phase: float = float(_phases.get(tarp.get_instance_id(), 0.0))
	var gust: float = sin(_elapsed * WIND_SPEED + phase)
	var secondary: float = sin(_elapsed * WIND_SPEED * 0.53 + phase * 1.9)
	var local: Transform3D = base
	local.basis = base.basis.rotated(Vector3.UP, gust * TARP_SWAY_RADIANS)
	local.origin = base.origin + Vector3(0.0, 0.0, secondary * TARP_PULSE)
	tarp.transform = local

func _apply_rope_motion(rope: MeshInstance3D) -> void:
	if not is_instance_valid(rope):
		return
	var base: Transform3D = _base_transforms.get(rope.get_instance_id(), rope.transform) as Transform3D
	var phase: float = float(_phases.get(rope.get_instance_id(), 0.0))
	var sway: float = sin(_elapsed * WIND_SPEED * 1.19 + phase)
	var local: Transform3D = base
	local.basis = base.basis.rotated(Vector3.UP, sway * ROPE_SWAY_RADIANS)
	local.origin = base.origin + Vector3(0.0, abs(sway) * ROPE_LIFT, 0.0)
	rope.transform = local
