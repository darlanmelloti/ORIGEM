## VossAmbientLife.gd
## Incremento R1 — vida doméstica e leitura narrativa na Casa Voss.
## Não adiciona colisores nem altera a rota Casa Voss → Estrada do Rio.

class_name VossAmbientLife
extends Node3D

var lanterns: Array[OmniLight3D] = []
var base_energies: Array[float] = []
var elapsed_time: float = 0.0

func build(house: Node3D) -> void:
	name = "VidaAmbientalCasaVoss"
	_build_interior_story(house)
	_build_porch_story(house)
	_cache_existing_lanterns(house)

func _process(delta: float) -> void:
	elapsed_time += delta
	for index: int in range(lanterns.size()):
		var lantern: OmniLight3D = lanterns[index]
		if not is_instance_valid(lantern):
			continue
		var base_energy: float = base_energies[index]
		var flicker: float = sin(elapsed_time * (2.1 + float(index) * 0.37) + float(index)) * 0.055
		flicker += sin(elapsed_time * (5.7 + float(index)) + 0.4) * 0.025
		lantern.light_energy = maxf(0.05, base_energy + flicker)

func _build_interior_story(house: Node3D) -> void:
	var props: Node3D = Node3D.new()
	props.name = "MemoriasDeCasaVoss"
	house.add_child(props)

	var paper: StandardMaterial3D = _material(Color(0.58, 0.47, 0.28, 1.0), 0.96, 0.0)
	var ink: StandardMaterial3D = _material(Color(0.055, 0.045, 0.032, 1.0), 0.92, 0.0)
	var leather: StandardMaterial3D = _material(Color(0.15, 0.075, 0.030, 1.0), 0.88, 0.0)
	var copper: StandardMaterial3D = _material(Color(0.38, 0.16, 0.045, 1.0), 0.45, 0.64)
	var cloth: StandardMaterial3D = _material(Color(0.12, 0.14, 0.16, 1.0), 0.94, 0.0)

	# Diário e carta interrompida: confirmação visual de que Elias saiu às pressas.
	_add_box(props, "DiarioAbertoDeElias", Vector3(1.82, 1.66, 1.55), Vector3(0.56, 0.035, 0.38), leather, Vector3(0.0, 0.22, 0.0))
	_add_box(props, "PaginaDoDiario", Vector3(1.83, 1.688, 1.55), Vector3(0.48, 0.008, 0.32), paper, Vector3(0.0, 0.22, 0.0))
	_add_box(props, "LinhaDeTintaDoDiario", Vector3(1.83, 1.695, 1.55), Vector3(0.34, 0.006, 0.018), ink, Vector3(0.0, 0.22, 0.0))
	_add_box(props, "CartaDeTomas", Vector3(2.18, 1.665, 1.22), Vector3(0.38, 0.010, 0.25), paper, Vector3(0.0, -0.16, 0.0))
	_add_box(props, "SeloDeCobreDaCarta", Vector3(2.34, 1.679, 1.10), Vector3(0.075, 0.018, 0.075), copper, Vector3.ZERO)

	# Mochila de Elias e mapa enrolado junto ao limiar; são visuais, sem bloquear o corredor de 3,9 m.
	_add_box(props, "MochilaDeElias", Vector3(2.62, 0.52, -2.80), Vector3(0.56, 0.78, 0.34), leather, Vector3(0.08, -0.22, 0.06))
	_add_box(props, "AlcaDaMochila", Vector3(2.62, 0.88, -2.78), Vector3(0.34, 0.08, 0.09), cloth, Vector3(0.0, -0.22, 0.0))
	_add_cylinder(props, "MapaEnroladoDeElias", Vector3(2.17, 0.42, -2.92), 0.075, 0.56, paper, Vector3(0.0, 0.0, PI * 0.5))
	_add_box(props, "PunhalDeViagem", Vector3(1.85, 0.43, -2.88), Vector3(0.42, 0.045, 0.075), copper, Vector3(0.0, -0.32, 0.0))

	# Dois retratos discretos reforçam a linhagem Voss sem introduzir nova interação.
	_add_box(props, "RetratoDeTomas", Vector3(-2.84, 2.58, 2.90), Vector3(0.68, 0.86, 0.055), copper, Vector3(0.0, 0.10, 0.0))
	_add_box(props, "ImagemRetratoDeTomas", Vector3(-2.84, 2.58, 2.865), Vector3(0.53, 0.70, 0.012), cloth, Vector3(0.0, 0.10, 0.0))
	_add_box(props, "RetratoDaMae", Vector3(-2.10, 2.44, 2.90), Vector3(0.46, 0.62, 0.055), copper, Vector3(0.0, -0.09, 0.0))
	_add_box(props, "ImagemRetratoDaMae", Vector3(-2.10, 2.44, 2.865), Vector3(0.34, 0.49, 0.012), paper, Vector3(0.0, -0.09, 0.0))

func _build_porch_story(house: Node3D) -> void:
	var porch: Node3D = Node3D.new()
	porch.name = "VestigiosNoAlpendre"
	house.add_child(porch)

	var wood: StandardMaterial3D = _material(Color(0.18, 0.09, 0.035, 1.0), 0.94, 0.0)
	var iron: StandardMaterial3D = _material(Color(0.10, 0.115, 0.12, 1.0), 0.52, 0.72)
	var rope: StandardMaterial3D = _material(Color(0.39, 0.27, 0.12, 1.0), 0.98, 0.0)
	var paper: StandardMaterial3D = _material(Color(0.55, 0.44, 0.25, 1.0), 0.95, 0.0)

	# Banco e balde criam a sensação de uma casa habitada sem acrescentar barreiras à saída.
	_add_box(porch, "BancoDeTrabalhoDoAlpendre", Vector3(-2.72, 0.60, -4.80), Vector3(1.38, 0.15, 0.42), wood, Vector3(0.0, 0.12, 0.0))
	_add_box(porch, "PeDoBancoOeste", Vector3(-3.22, 0.30, -4.80), Vector3(0.13, 0.54, 0.13), wood, Vector3.ZERO)
	_add_box(porch, "PeDoBancoEste", Vector3(-2.22, 0.30, -4.80), Vector3(0.13, 0.54, 0.13), wood, Vector3.ZERO)
	_add_cylinder(porch, "BaldeDoAlpendre", Vector3(-3.12, 0.36, -3.86), 0.24, 0.42, iron, Vector3.ZERO)
	_add_cylinder(porch, "CordaDoBalde", Vector3(-3.12, 0.64, -3.86), 0.18, 0.028, rope, Vector3.ZERO)

	# Placa de orientação na lateral: a porta abre para uma estrada real e para Orion, nunca para uma caixa fechada.
	_add_box(porch, "PosteDoCaminhoDeOrion", Vector3(3.45, 1.18, -5.25), Vector3(0.14, 1.68, 0.14), wood, Vector3(0.0, 0.04, 0.0))
	_add_box(porch, "SetaEstradaDoRio", Vector3(3.10, 1.63, -5.25), Vector3(0.76, 0.28, 0.075), wood, Vector3(0.0, -0.12, 0.0))
	_add_box(porch, "MarcaAzulDaSeta", Vector3(3.10, 1.63, -5.202), Vector3(0.17, 0.075, 0.010), _material(Color(0.06, 0.24, 0.58, 1.0), 0.45, 0.15), Vector3(0.0, -0.12, 0.0))
	_add_box(porch, "BilheteNoPoste", Vector3(3.43, 1.21, -5.178), Vector3(0.20, 0.26, 0.010), paper, Vector3(0.0, 0.04, 0.0))

func _cache_existing_lanterns(house: Node3D) -> void:
	var candidate_names: PackedStringArray = PackedStringArray(["LanternaDaPorta", "LuzDaLareira", "LuzDaMesaDeTomas"])
	for candidate_name: String in candidate_names:
		var lantern: OmniLight3D = house.get_node_or_null(candidate_name) as OmniLight3D
		if lantern == null:
			continue
		lanterns.append(lantern)
		base_energies.append(lantern.light_energy)

func _add_box(parent: Node3D, node_name: String, position_value: Vector3, size_value: Vector3, material: StandardMaterial3D, rotation_value: Vector3) -> void:
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = size_value
	mesh.material = material
	var visual: MeshInstance3D = MeshInstance3D.new()
	visual.name = node_name
	visual.mesh = mesh
	visual.position = position_value
	visual.rotation = rotation_value
	visual.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(visual)

func _add_cylinder(parent: Node3D, node_name: String, position_value: Vector3, radius: float, height_value: float, material: StandardMaterial3D, rotation_value: Vector3) -> void:
	var mesh: CylinderMesh = CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = height_value
	mesh.radial_segments = 12
	mesh.material = material
	var visual: MeshInstance3D = MeshInstance3D.new()
	visual.name = node_name
	visual.mesh = mesh
	visual.position = position_value
	visual.rotation = rotation_value
	visual.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(visual)

func _material(color_value: Color, roughness_value: float, metallic_value: float) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color_value
	material.roughness = roughness_value
	material.metallic = metallic_value
	return material
