## ArchMarginSilence.gd
## DEV3-R3-ARCH-MARGIN-SILENCE-016
## Reduz competição visual apenas em pátina lateral existente, sem criar geometria, texto, UI, luz, emissão, VFX, áudio ou colisão.

class_name R3ArchMarginSilence
extends Node

const TARGETS: PackedStringArray = ["GrupoDeBaseArco_01", "GrupoDeBaseArco_04"]

static func install(arch: Node3D) -> R3ArchMarginSilence:
	if arch == null:
		return null
	var existing: R3ArchMarginSilence = arch.get_node_or_null("R3SilencioDeMargem") as R3ArchMarginSilence
	if existing != null:
		return existing
	var layer := R3ArchMarginSilence.new()
	layer.name = "R3SilencioDeMargem"
	arch.add_child(layer)
	return layer

func _ready() -> void:
	var arch := get_parent() as Node3D
	if arch == null:
		return
	for target_name in TARGETS:
		var target := arch.get_node_or_null(target_name) as Node3D
		if target == null:
			continue
		for mesh_node in target.find_children("*", "MeshInstance3D", true, false):
			var mesh := mesh_node as MeshInstance3D
			var material := mesh.material_override as StandardMaterial3D if mesh != null else null
			if material != null and mesh.has_meta("r3_arch_patina"):
				material.roughness = maxf(material.roughness, 0.96)
				material.emission_enabled = false
				mesh.set_meta("r3_margin_silence", true)

func get_contract() -> Dictionary:
	return {"adds_geometry": false, "adds_text": false, "adds_ui": false, "adds_lights": false, "adds_emission": false, "adds_vfx": false, "adds_audio": false, "adds_collision": false}
