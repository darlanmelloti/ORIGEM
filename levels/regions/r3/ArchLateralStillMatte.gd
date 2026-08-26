## ArchLateralStillMatte.gd
## DEV3-R3-ARCH-LATERAL-STILL-057
## Imobilidade material lateral de superfícies existentes, sem criar geometria, texto, UI, luz, emissão, VFX, áudio ou colisão.
class_name R3ArchLateralStillMatte
extends Node

static func install(arch: Node3D) -> R3ArchLateralStillMatte:
	if arch == null:
		return null
	var existing: R3ArchLateralStillMatte = arch.get_node_or_null("R3ImobilidadeMateLateral") as R3ArchLateralStillMatte
	if existing != null:
		return existing
	var layer := R3ArchLateralStillMatte.new()
	layer.name = "R3ImobilidadeMateLateral"
	arch.add_child(layer)
	return layer

func _ready() -> void:
	var arch := get_parent() as Node3D
	if arch == null:
		return
	for mesh_node in arch.find_children("*", "MeshInstance3D", true, false):
		var mesh := mesh_node as MeshInstance3D
		var material := mesh.material_override as StandardMaterial3D if mesh != null else null
		if material != null and mesh.has_meta("r3_margin_calm_matte"):
			material.roughness = 1.0
			material.metallic = 0.0
			material.emission_enabled = false
			mesh.set_meta("r3_lateral_still_matte", true)

func get_contract() -> Dictionary:
	return {"adds_geometry": false, "adds_text": false, "adds_ui": false, "adds_lights": false, "adds_emission": false, "adds_vfx": false, "adds_audio": false, "adds_collision": false}
