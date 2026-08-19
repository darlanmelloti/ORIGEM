## Espelho cartográfico exclusivamente de QA.
## Não substitui geometria nem é incluído como elemento visual na versão final.
extends Node3D

const MARKER_RADIUS: float = 1.45
const LINE_HEIGHT: float = 0.50
const LABEL_OFFSET: float = 3.0
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
		label.position = marker.position + Vector3(0.0, LABEL_OFFSET, 0.0)
		label.modulate = material.albedo_color
		label.font_size = 48
		label.pixel_size = 0.012
		label.outline_size = 12
		label.outline_modulate = Color("#09121f")
		label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		label.no_depth_test = true
		mirror_root.add_child(label)
		if index > 0:
			_add_segment(mirror_root, contract[index - 1]["world_position"] as Vector3, marker.position, index)
	var boundary: Dictionary = CartographicAnchors.continuity_6_to_7()
	_add_segment(mirror_root, boundary["handoff_in"] as Vector3, boundary["handoff_out"] as Vector3, 0)
	var boundary_label := Label3D.new()
	boundary_label.name = "MapMirrorBoundary_R06_R07"
	boundary_label.text = "QA  R06 → R07  |  HANDOFF BOUNDARY"
	boundary_label.position = (boundary["handoff_out"] as Vector3) + Vector3(0.0, LABEL_OFFSET + 1.0, 0.0)
	boundary_label.modulate = Color("#f6c453")
	boundary_label.font_size = 52
	boundary_label.pixel_size = 0.012
	boundary_label.outline_size = 12
	boundary_label.outline_modulate = Color("#09121f")
	boundary_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	boundary_label.no_depth_test = true
	mirror_root.add_child(boundary_label)
	print("MAP_MIRROR_BOUNDARY from=6 to=7 state=QA_BOUNDARY_PENDING distance=", boundary["distance"])
	var boundary_7_8: Dictionary = CartographicAnchors.continuity_7_to_8()
	_add_segment(mirror_root, boundary_7_8["handoff_in"] as Vector3, boundary_7_8["handoff_out"] as Vector3, 8)
	var boundary_7_8_label := Label3D.new()
	boundary_7_8_label.name = "MapMirrorBoundary_R07_R08"
	boundary_7_8_label.text = "QA  R07 → R08  |  OBSERVATORIO A NORTE"
	boundary_7_8_label.position = (boundary_7_8["handoff_in"] as Vector3) + Vector3(0.0, LABEL_OFFSET + 1.0, 0.0)
	boundary_7_8_label.modulate = Color("#f6c453")
	boundary_7_8_label.font_size = 52
	boundary_7_8_label.pixel_size = 0.012
	boundary_7_8_label.outline_size = 12
	boundary_7_8_label.outline_modulate = Color("#09121f")
	boundary_7_8_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	boundary_7_8_label.no_depth_test = true
	mirror_root.add_child(boundary_7_8_label)
	print("MAP_MIRROR_BOUNDARY from=7 to=8 state=QA_BOUNDARY_PENDING distance=", boundary_7_8["distance"])
	_add_subject_beacon(boundary_7_8["handoff_out"] as Vector3, "MapMirrorSubject_R08", Color("#27d8ef"), 12.0)
	_add_subject_beacon(boundary_7_8["handoff_in"] as Vector3, "MapMirrorSubject_R07", Color("#f6c453"), 5.0)
	var boundary_8_9: Dictionary = CartographicAnchors.continuity_8_to_9()
	_add_segment(mirror_root, boundary_8_9["handoff_in"] as Vector3, boundary_8_9["handoff_out"] as Vector3, 9)
	var boundary_8_9_label := Label3D.new()
	boundary_8_9_label.name = "MapMirrorBoundary_R08_R09"
	boundary_8_9_label.text = "QA  R08 → R09  |  TRILHA DA MONTANHA"
	boundary_8_9_label.position = (boundary_8_9["handoff_in"] as Vector3) + Vector3(0.0, LABEL_OFFSET + 1.0, 0.0)
	boundary_8_9_label.modulate = Color("#f6c453")
	boundary_8_9_label.font_size = 52
	boundary_8_9_label.pixel_size = 0.012
	boundary_8_9_label.outline_size = 12
	boundary_8_9_label.outline_modulate = Color("#09121f")
	boundary_8_9_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	boundary_8_9_label.no_depth_test = true
	mirror_root.add_child(boundary_8_9_label)
	print("MAP_MIRROR_BOUNDARY from=8 to=9 state=QA_BOUNDARY_PENDING distance=", boundary_8_9["distance"])
	_add_subject_beacon(boundary_8_9["handoff_out"] as Vector3, "MapMirrorSubject_R09", Color("#9b7bff"), 9.0)
	var boundary_9_10: Dictionary = CartographicAnchors.continuity_9_to_10()
	_add_segment(mirror_root, boundary_9_10["handoff_in"] as Vector3, boundary_9_10["handoff_out"] as Vector3, 10)
	var boundary_9_10_label := Label3D.new()
	boundary_9_10_label.name = "MapMirrorBoundary_R09_R10"
	boundary_9_10_label.text = "QA  R09 → R10  |  CAVERNA DO ORION"
	boundary_9_10_label.position = (boundary_9_10["handoff_in"] as Vector3) + Vector3(0.0, LABEL_OFFSET + 1.0, 0.0)
	boundary_9_10_label.modulate = Color("#f6c453")
	boundary_9_10_label.font_size = 52
	boundary_9_10_label.pixel_size = 0.012
	boundary_9_10_label.outline_size = 12
	boundary_9_10_label.outline_modulate = Color("#09121f")
	boundary_9_10_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	boundary_9_10_label.no_depth_test = true
	mirror_root.add_child(boundary_9_10_label)
	print("MAP_MIRROR_BOUNDARY from=9 to=10 state=QA_BOUNDARY_PENDING distance=", boundary_9_10["distance"])
	_add_subject_beacon(boundary_9_10["handoff_out"] as Vector3, "MapMirrorSubject_R10", Color("#27d8ef"), 14.0)
	var boundary_10_11: Dictionary = CartographicAnchors.continuity_10_to_11()
	_add_segment(mirror_root, boundary_10_11["handoff_in"] as Vector3, boundary_10_11["handoff_out"] as Vector3, 11)
	var boundary_10_11_label := Label3D.new()
	boundary_10_11_label.name = "MapMirrorBoundary_R10_R11"
	boundary_10_11_label.text = "QA  R10 → R11  |  CAMARA DO ORION CUBE"
	boundary_10_11_label.position = (boundary_10_11["handoff_in"] as Vector3) + Vector3(0.0, LABEL_OFFSET + 1.0, 0.0)
	boundary_10_11_label.modulate = Color("#f6c453")
	boundary_10_11_label.font_size = 52
	boundary_10_11_label.pixel_size = 0.012
	boundary_10_11_label.outline_size = 12
	boundary_10_11_label.outline_modulate = Color("#09121f")
	boundary_10_11_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	boundary_10_11_label.no_depth_test = true
	mirror_root.add_child(boundary_10_11_label)
	print("MAP_MIRROR_BOUNDARY from=10 to=11 state=QA_BOUNDARY_PENDING distance=", boundary_10_11["distance"])
	_add_subject_beacon(boundary_10_11["handoff_out"] as Vector3, "MapMirrorSubject_R11", Color("#c58cff"), 16.0)
	var boundary_11_12: Dictionary = CartographicAnchors.continuity_11_to_12()
	_add_segment(mirror_root, boundary_11_12["handoff_in"] as Vector3, boundary_11_12["handoff_out"] as Vector3, 12)
	var boundary_11_12_label := Label3D.new()
	boundary_11_12_label.name = "MapMirrorBoundary_R11_R12"
	boundary_11_12_label.text = "QA  R11 → R12  |  CUPULA FINAL"
	boundary_11_12_label.position = (boundary_11_12["handoff_in"] as Vector3) + Vector3(0.0, LABEL_OFFSET + 1.0, 0.0)
	boundary_11_12_label.modulate = Color("#f6c453")
	boundary_11_12_label.font_size = 52
	boundary_11_12_label.pixel_size = 0.012
	boundary_11_12_label.outline_size = 12
	boundary_11_12_label.outline_modulate = Color("#09121f")
	boundary_11_12_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	boundary_11_12_label.no_depth_test = true
	mirror_root.add_child(boundary_11_12_label)
	print("MAP_MIRROR_BOUNDARY from=11 to=12 state=QA_BOUNDARY_PENDING distance=", boundary_11_12["distance"])
	_add_subject_beacon(boundary_11_12["handoff_out"] as Vector3, "MapMirrorSubject_R12", Color("#d7a8ff"), 18.0)
	get_tree().create_timer(3.0).timeout.connect(_add_runtime_start_label)
	get_tree().create_timer(2.0).timeout.connect(_report_integrated_inventory.bind(contract.size()))

func _add_subject_beacon(world_position: Vector3, node_name: String, color: Color, height: float) -> void:
	var beacon := MeshInstance3D.new()
	beacon.name = node_name
	var mesh := CylinderMesh.new()
	mesh.top_radius = 0.42
	mesh.bottom_radius = 0.72
	mesh.height = height
	beacon.mesh = mesh
	beacon.position = world_position + Vector3(0.0, height * 0.5, 0.0)
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = color
	material.emission_energy_multiplier = 3.0
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	beacon.material_override = material
	add_child(beacon)

func _add_runtime_start_label() -> void:
	var player := get_tree().get_first_node_in_group("player") as Node3D
	if player == null:
		return
	var near_label := Label3D.new()
	var active_route := OS.get_environment("QA_VALIDATION_ROUTE")
	if active_route == "MAP_MIRROR_VALIDATION_R11_R12_CHAIN":
		near_label.name = "MapMirrorQAStart_R11_R12"
		near_label.text = "QA START R11 → R12"
	elif active_route == "MAP_MIRROR_VALIDATION_R10_R11_CHAIN":
		near_label.name = "MapMirrorQAStart_R10_R11"
		near_label.text = "QA START R10 → R11"
	else:
		near_label.name = "MapMirrorQAStart_R07_R08"
		near_label.text = "QA START R07 → R08"
	near_label.position = Vector3(164.0, 10.5, 200.0) if active_route == "MAP_MIRROR_VALIDATION_R11_R12_CHAIN" else player.global_position + Vector3(0.0, 3.5, 0.0)
	near_label.modulate = Color("#f6c453")
	near_label.font_size = 64
	near_label.pixel_size = 0.014
	near_label.outline_size = 16
	near_label.outline_modulate = Color("#09121f")
	near_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	near_label.no_depth_test = true
	add_child(near_label)
	print("MAP_MIRROR_QA_START player_position=", player.global_position)

func _report_integrated_inventory(marker_count: int) -> void:
	var scene_root: Node = get_tree().current_scene if get_tree().current_scene != null else self
	var mesh_count: int = scene_root.find_children("*", "GeometryInstance3D", true, false).size()
	var light_count: int = scene_root.find_children("*", "OmniLight3D", true, false).size()
	var collider_count: int = scene_root.find_children("*", "StaticBody3D", true, false).size()
	print("MAP_MIRROR_VALIDATION=ACTIVE regions=7-12 markers=", marker_count, " source=CartographicAnchors.gd")
	var anchor_contract := scene_root.find_child("CartographicAnchors_Regioes10a12", true, false)
	if anchor_contract != null:
		print("MAP_MIRROR_ANCHOR_CONTRACT chain=", anchor_contract.get_meta("handoff_chain", "missing"), " count=", anchor_contract.get_meta("anchor_count", 0), " state=", anchor_contract.get_meta("validation_state", "missing"))
	for contract_pair: Dictionary in [CartographicAnchors.continuity_7_to_8(), CartographicAnchors.continuity_8_to_9(), CartographicAnchors.continuity_9_to_10(), CartographicAnchors.continuity_10_to_11(), CartographicAnchors.continuity_11_to_12()]:
		print("MAP_MIRROR_HANDOFF_CONTRACT id=", contract_pair.get("handoff_id", "missing"), " authority=", contract_pair.get("map_authority", "missing"), " state=", contract_pair.get("validation_state", "missing"))
	print("MAP_MIRROR_INVENTORY meshes=", mesh_count, " omni_lights=", light_count, " static_bodies=", collider_count)
	var physical_handoffs: Array[Node] = []
	for candidate in scene_root.find_children("*", "StaticBody3D", true, false):
		if str(candidate.name).begins_with("ColliderCPD2007_") or bool(candidate.get_meta("physical_handoff", false)):
			physical_handoffs.append(candidate)
	for handoff_name: String in ["R9_R10", "R10_R11", "R11_R12"]:
		var handoff_present := false
		for candidate in physical_handoffs:
			var candidate_name := str(candidate.name)
			if candidate_name.contains(handoff_name) or bool(candidate.get_meta("handoff_%s" % handoff_name, false)):
				handoff_present = true
				break
		print("MAP_MIRROR_HANDOFF name=", handoff_name, " present=", handoff_present)
	print("MAP_MIRROR_HANDOFF_COLLIDERS count=", physical_handoffs.size())

func _add_segment(parent: Node3D, start: Vector3, finish: Vector3, index: int) -> void:
	var segment := MeshInstance3D.new()
	segment.name = "MapMirrorHandoff_%02d" % index
	var cylinder := CylinderMesh.new()
	cylinder.top_radius = 0.28
	cylinder.bottom_radius = 0.28
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
