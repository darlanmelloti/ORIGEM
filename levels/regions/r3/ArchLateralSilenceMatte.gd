## ArchLateralSilenceMatte.gd
## DEV3-R3-ARCH-LATERAL-SILENCE-061
## Silêncio material lateral em superfícies existentes, sem criar geometria, texto, UI, luz, emissão, VFX, áudio ou colisão.
class_name R3ArchLateralSilenceMatte
extends Node

static func install(arch: Node3D) -> R3ArchLateralSilenceMatte:
	if arch == null:
		return null
	var existing: R3ArchLateralSilenceMatte = arch.get_node_or_null("R3SilencioMateLateral061") as R3ArchLateralSilenceMatte
	if existing != null:
		return existing
	var layer := R3ArchLateralSilenceMatte.new()
	layer.name = "R3SilencioMateLateral061"
	arch.add_child(layer)
	return layer

func _ready() -> void:
	var arch := get_parent() as Node3D
	if arch == null:
		return
	for mesh_node in arch.find_children("*", "MeshInstance3D", true, false):
		var mesh := mesh_node as MeshInstance3D
		var material := mesh.material_override as StandardMaterial3D if mesh != null else null
		if material != null and mesh.has_meta("r3_margin_still_matte"):
			material.roughness = 1.0
			material.metallic = 0.0
			material.emission_enabled = false
			mesh.set_meta("r3_lateral_silence_matte", true)

func get_contract() -> Dictionary:
	return {"adds_geometry": false, "adds_text": false, "adds_ui": false, "adds_lights": false, "adds_emission": false, "adds_vfx": false, "adds_audio": false, "adds_collision": false}
