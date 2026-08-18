## Espelho cartográfico exclusivamente de QA.
## Não substitui geometria nem é incluído como elemento visual na versão final.
extends Node3D

const MARKER_RADIUS: float = 0.85
const LINE_HEIGHT: float = 0.35
const STATE_COLORS: Dictionary = {
	"UNBUILT": Color("#ef5350"),
	"BLOCKOUT_VALIDATED": Color("#f6c453"),
	"PHYSICAL_VALIDATED": Color("#4fc3f7"),
	"VISUAL_PASS": Color("#9b7bff"),
	"INTEGRATED": Color("#66d18f")
}

func _ready() -> void:
	if OS.get_environment("MAP_MIRROR_VALIDATION") != "1":
		queue_free()
		return
	_build_mirror()

func _build_mirror() -> void:
	var contract := CartographicAnchors.dev2_contract()
	var mirror_root := Node3D.new()
	mirror_root.name = "MAP_MIRROR_VALIDATION_R7_R12"
	add_child(mirror_root)
	for index: int in range(contract.size()):
		var item: Dictionary = contract[index]
		var marker := MeshInstance3D.new()
		marker.name = "MapMirrorMarker_R%02d" % int(item["region_id"])
		var sphere := SphereMesh.new()
		sphere.radius = MARKER_RADIUS
		sphere.height = MARKER_RADIUS * 2.0
		marker.mesh = sphere
		var material := StandardMaterial3D.new()
		var state := str(item["validation_state"])
		material.albedo_color = STATE_COLORS.get(state, Color.WHITE)
		material.emission_enabled = true
		material.emission = material.albedo_color
		material.emission_energy_multiplier = 1.4
		marker.material_override = material
		marker.position = item["world_position"] as Vector3
		mirror_root.add_child(marker)
		var label := Label3D.new()
		label.name = "MapMirrorLabel_R%02d" % int(item["region_id"])
		label.text = "R%02d  %s  [%s]" % [int(item["region_id"]), str(item["subject_visual"]), state]
		label.position = marker.position + Vector3(0.0, 1.8, 0.0)
		label.modulate = material.albedo_color
		label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		label.no_depth_test = true
		mirror_root.add_child(label)
		if index > 0:
			_add_segment(mirror_root, contract[index - 1]["world_position"] as Vector3, marker.position, index)
	get_tree().create_timer(2.0).timeout.connect(_report_integrated_inventory.bind(contract.size()))

func _report_integrated_inventory(marker_count: int) -> void:
	var scene_root: Node = get_tree().current_scene if get_tree().current_scene != null else self
	var mesh_count: int = scene_root.find_children("*", "GeometryInstance3D", true, false).size()
	var light_count: int = scene_root.find_children("*", "OmniLight3D", true, false).size()
	var collider_count: int = scene_root.find_children("*", "StaticBody3D", true, false).size()
	print("MAP_MIRROR_VALIDATION=ACTIVE regions=7-12 markers=", marker_count, " source=CartographicAnchors.gd")
	print("MAP_MIRROR_INVENTORY meshes=", mesh_count, " omni_lights=", light_count, " static_bodies=", collider_count)
	var physical_handoffs: Array[Node] = []
	for candidate in scene_root.find_children("*", "StaticBody3D", true, false):
		if str(candidate.name).begins_with("ColliderCPD2007_") or bool(candidate.get_meta("physical_handoff", false)):
			physical_handoffs.append(candidate)
	for handoff_name: String in ["R9_R10", "R10_R11", "R11_R12"]:
		print("MAP_MIRROR_HANDOFF name=", handoff_name, " present=", physical_handoffs.size() > 0)
	print("MAP_MIRROR_HANDOFF_COLLIDERS count=", physical_handoffs.size())

func _add_segment(parent: Node3D, start: Vector3, finish: Vector3, index: int) -> void:
	var segment := MeshInstance3D.new()
	segment.name = "MapMirrorHandoff_%02d" % index
	var cylinder := CylinderMesh.new()
	cylinder.top_radius = 0.16
	cylinder.bottom_radius = 0.16
	cylinder.height = start.distance_to(finish)
	segment.mesh = cylinder
	var material := StandardMaterial3D.new()
	material.albedo_color = Color("#4fc3f7")
	material.emission_enabled = true
	material.emission = Color("#4fc3f7")
	material.emission_energy_multiplier = 0.85
	segment.material_override = material
	parent.add_child(segment)
	segment.position = (start + finish) * 0.5 + Vector3.UP * LINE_HEIGHT
	segment.look_at(finish, Vector3.UP)
