## r6_archaeology_material_probe.gd
## Simula materiais QA para a auditoria de silhueta arqueológica R6 sem escrever na produção.
## Parte do módulo: qa/dev7
extends SceneTree

const TERRAIN_ALBEDO: Color = Color(0.28, 0.36, 0.23, 1.0)
const EXISTING_RUIN_ALBEDO: Color = Color(0.48, 0.52, 0.45, 1.0)
const PROPOSED_RUIN_ALBEDO: Color = Color(0.56, 0.55, 0.47, 1.0)
const EXISTING_ROUGHNESS: float = 0.95
const PROPOSED_ROUGHNESS: float = 0.88

func _init() -> void:
	var existing_material: StandardMaterial3D = _make_material(EXISTING_RUIN_ALBEDO, EXISTING_ROUGHNESS)
	var proposed_material: StandardMaterial3D = _make_material(PROPOSED_RUIN_ALBEDO, PROPOSED_ROUGHNESS)
	var probe_mesh: MeshInstance3D = MeshInstance3D.new()
	probe_mesh.name = "QAOnlyR6ArchaeologyMaterialOverride"
	probe_mesh.material_override = proposed_material
	var existing_contrast: Dictionary = _contrast_against_terrain(existing_material.albedo_color)
	var proposed_contrast: Dictionary = _contrast_against_terrain(proposed_material.albedo_color)
	var result: Dictionary = {
		"probe": "QA-R6-ARCHAEOLOGY-MATERIAL-002",
		"production_writes": 0,
		"created_light3d": false,
		"created_collision": false,
		"route": "forest_to_ruins",
		"existing": existing_contrast,
		"proposed_override": proposed_contrast,
		"proposed_roughness": PROPOSED_ROUGHNESS,
		"existing_roughness": EXISTING_ROUGHNESS,
		"override_target": probe_mesh.name,
		"recommendation": "candidate_only_owner_r6_decision_required",
	}
	print("[QA-R6-ARCHAEOLOGY-MATERIAL-PROBE] %s" % JSON.stringify(result))
	probe_mesh.free()
	quit(0)

func _make_material(albedo: Color, roughness_value: float) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = albedo
	material.roughness = roughness_value
	material.emission_enabled = false
	return material

func _contrast_against_terrain(albedo: Color) -> Dictionary:
	var terrain_luminance: float = _luminance(TERRAIN_ALBEDO)
	var subject_luminance: float = _luminance(albedo)
	var luminance_delta: float = absf(subject_luminance - terrain_luminance)
	var chroma_distance: float = sqrt(
		pow(albedo.r - TERRAIN_ALBEDO.r, 2.0)
		+ pow(albedo.g - TERRAIN_ALBEDO.g, 2.0)
		+ pow(albedo.b - TERRAIN_ALBEDO.b, 2.0)
	)
	return {
		"albedo": [albedo.r, albedo.g, albedo.b],
		"terrain_luminance": terrain_luminance,
		"subject_luminance": subject_luminance,
		"luminance_delta": luminance_delta,
		"chroma_distance": chroma_distance,
	}

func _luminance(color: Color) -> float:
	return color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722
