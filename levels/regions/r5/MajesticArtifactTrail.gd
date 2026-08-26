## MajesticArtifactTrail.gd
## DEV5-R5-ARTEFACT-TRAIL-001
## Camada funcional do Acampamento: artefacto azul e três pistas de expedição, sem cutscene ou luz dinâmica nova.

class_name R5MajesticArtifactTrail
extends Node3D

const ARTEFACT_EVENT := "majestic_orion_trace_discovered"

static func install(camp: Node3D, pillar_scene: PackedScene) -> R5MajesticArtifactTrail:
	if camp == null:
		return null
	var existing: R5MajesticArtifactTrail = camp.get_node_or_null("R5TrilhoDoArtefacto") as R5MajesticArtifactTrail
	if existing != null:
		return existing
	var trail: R5MajesticArtifactTrail = R5MajesticArtifactTrail.new()
	trail.name = "R5TrilhoDoArtefacto"
	camp.add_child(trail)
	trail._build(pillar_scene)
	return trail

func _build(pillar_scene: PackedScene) -> void:
	_build_orion_artefact(pillar_scene)
	_build_expedition_map_clue()
	_build_exit_tools_clue()

func _build_orion_artefact(pillar_scene: PackedScene) -> void:
	var artefact: StaticBody3D = StaticBody3D.new()
	artefact.name = "ArtefactoAzulMajestic"
	artefact.add_to_group("interactable")
	artefact.collision_layer = 4
	artefact.position = Vector3(-5.35, 0.0, -3.65)
	add_child(artefact)
	var base: Node3D = pillar_scene.instantiate() as Node3D
	if base != null:
		base.name = "BaseDePedraDoArtefacto"
		base.scale = Vector3(0.28, 0.34, 0.28)
		base.rotation.y = 0.42
		artefact.add_child(base)
	var core_mesh: SphereMesh = SphereMesh.new()
	core_mesh.radius = 0.30
	core_mesh.height = 0.60
	core_mesh.radial_segments = 16
	var core_material: StandardMaterial3D = StandardMaterial3D.new()
	core_material.albedo_color = Color(0.045, 0.18, 0.30, 1.0)
	core_material.metallic = 0.48
	core_material.roughness = 0.26
	core_material.emission_enabled = true
	core_material.emission = Color(0.05, 0.34, 0.78, 1.0)
	core_material.emission_energy_multiplier = 0.72
	core_mesh.material = core_material
	var core: MeshInstance3D = MeshInstance3D.new()
	core.name = "NucleoAzulSemLuzDinamica"
	core.mesh = core_mesh
	core.position = Vector3(0.0, 1.30, 0.0)
	artefact.add_child(core)
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: CylinderShape3D = CylinderShape3D.new()
	shape.radius = 0.52
	shape.height = 2.40
	collision.shape = shape
	collision.position = Vector3(0.0, 1.20, 0.0)
	artefact.add_child(collision)

func _build_expedition_map_clue() -> void:
	# A mesa e o mapa visual já existem no acampamento; este volume fino torna a pista jogável sem duplicar o prop.
	var clue: StaticBody3D = StaticBody3D.new()
	clue.name = "PistaMapaExpedicaoMajestic"
	clue.add_to_group("interactable")
	clue.collision_layer = 4
	clue.position = Vector3(2.72, 1.32, -2.78)
	add_child(clue)
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = Vector3(1.62, 0.34, 1.22)
	collision.shape = shape
	clue.add_child(collision)

func _build_exit_tools_clue() -> void:
	# O suporte de expedição existente ganha uma área de leitura junto à saída Majestic→margem, mantendo o corredor livre.
	var clue: StaticBody3D = StaticBody3D.new()
	clue.name = "PistaFerramentasECordasMajestic"
	clue.add_to_group("interactable")
	clue.collision_layer = 4
	clue.position = Vector3(-1.50, 0.72, 3.18)
	add_child(clue)
	var coil_mesh: TorusMesh = TorusMesh.new()
	coil_mesh.inner_radius = 0.28
	coil_mesh.outer_radius = 0.38
	coil_mesh.rings = 12
	coil_mesh.ring_segments = 8
	var rope_material: StandardMaterial3D = StandardMaterial3D.new()
	rope_material.albedo_color = Color(0.25, 0.13, 0.055, 1.0)
	rope_material.roughness = 0.95
	coil_mesh.material = rope_material
	for coil_index: int in range(2):
		var coil: MeshInstance3D = MeshInstance3D.new()
		coil.name = "CordaEnroladaMajestic_%02d" % (coil_index + 1)
		coil.mesh = coil_mesh
		coil.position = Vector3(-0.32 + float(coil_index) * 0.62, 0.10 + float(coil_index) * 0.05, 0.0)
		coil.rotation.x = PI * 0.5
		clue.add_child(coil)
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = Vector3(2.05, 1.45, 0.96)
	collision.shape = shape
	collision.disabled = true
	clue.add_child(collision)
