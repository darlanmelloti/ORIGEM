extends SceneTree

const REGION_SCRIPT_PATH: String = "res://levels/ForestLakeRegion.gd"
const INLET_PATH: NodePath = NodePath("AfluenteCartograficoRioParaBacia/LaminaDoAfluenteCartografico")
const R6_WATER_PATH: NodePath = NodePath("RuinasSubmersasDoLago/LagoDasRuinasSubmersas")
const R6_LIGHT_NAMES: Array[StringName] = [
	&"PreenchimentoMundialDoLago",
	&"PreenchimentoOpostoDoLago",
	&"PreenchimentoAzulDaMargem",
	&"LuzSubaquaticaCentral"
]
const SOURCE_ALPHA: String = "ALPHA = 1.0;"
const CANDIDATE_ALPHA: String = "ALPHA = 0.82;"

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var issues: PackedStringArray = PackedStringArray()
	var region_script: Script = load(REGION_SCRIPT_PATH) as Script
	if region_script == null:
		_fail(PackedStringArray(["módulo regional R4/R6 não foi carregado"]))
		return
	var region: Node3D = region_script.new() as Node3D
	root.add_child(region)
	await process_frame
	await process_frame
	var light_count_before: int = region.find_children("*", "Light3D", true, false).size()
	var inlet_water: MeshInstance3D = region.get_node_or_null(INLET_PATH) as MeshInstance3D
	var r6_water: MeshInstance3D = region.get_node_or_null(R6_WATER_PATH) as MeshInstance3D
	if inlet_water == null:
		issues.append("lâmina do afluente R4 ausente")
	if r6_water == null:
		issues.append("lâmina lacustre R6 ausente")
	if inlet_water != null and r6_water != null:
		var canonical: ShaderMaterial = inlet_water.mesh.surface_get_material(0) as ShaderMaterial
		var r6_canonical: ShaderMaterial = r6_water.mesh.surface_get_material(0) as ShaderMaterial
		if canonical == null or canonical.shader == null:
			issues.append("material canónico do afluente R4 ausente")
		elif r6_canonical == null or r6_canonical.shader == null:
			issues.append("material canónico do lago R6 ausente")
		else:
			if canonical.shader.code != r6_canonical.shader.code:
				issues.append("R4 e R6 não usam a mesma receita canónica de shader")
			if not canonical.shader.code.contains(SOURCE_ALPHA):
				issues.append("alfa canónico R4/R6 não é 1.0")
			var candidate_shader: Shader = Shader.new()
			candidate_shader.code = canonical.shader.code.replace(SOURCE_ALPHA, CANDIDATE_ALPHA)
			var candidate_material: ShaderMaterial = ShaderMaterial.new()
			candidate_material.shader = candidate_shader
			inlet_water.set_surface_override_material(0, candidate_material)
			if inlet_water.get_surface_override_material(0) != candidate_material:
				issues.append("override QA R4 não foi aplicado apenas em memória")
			if candidate_material.shader == null or not candidate_material.shader.code.contains(CANDIDATE_ALPHA):
				issues.append("candidata QA não contém alfa 0.82")
			if r6_water.get_surface_override_material(0) != null:
				issues.append("lago R6 recebeu override durante a prova")
			if r6_water.mesh.surface_get_material(0) != r6_canonical:
				issues.append("material de produção R6 foi substituído")
			if not r6_canonical.shader.code.contains(SOURCE_ALPHA):
				issues.append("alfa de produção R6 mudou durante a prova")
	if region.find_children("*", "Light3D", true, false).size() != light_count_before:
		issues.append("a prova alterou a contagem de luzes existentes")
	var r6_lights: int = 0
	for light_name: StringName in R6_LIGHT_NAMES:
		var light: Light3D = region.find_child(String(light_name), true, false) as Light3D
		if light == null:
			issues.append("luz canónica R6 ausente: %s" % light_name)
		else:
			r6_lights += 1
	var inlet: Node3D = region.get_node_or_null(NodePath("AfluenteCartograficoRioParaBacia")) as Node3D
	if inlet == null:
		issues.append("contentor do afluente R4 ausente")
	elif inlet.find_children("*", "Light3D", true, false).size() != 0:
		issues.append("a prova criou ou encontrou luz dentro do afluente R4")
	elif inlet.find_children("*", "StaticBody3D", true, false).size() != 0:
		issues.append("a prova criou ou encontrou colisor dentro do afluente R4")
	if issues.is_empty():
		print("[ORIGEM_R4_R6_ALPHA_CANDIDATE_OK] target=R4 alpha=0.82 r6_alpha=1.0 r6_lights=%d production_mutations=0" % r6_lights)
		region.queue_free()
		await process_frame
		quit()
		return
	region.queue_free()
	await process_frame
	_fail(issues)

func _fail(issues: PackedStringArray) -> void:
	for issue: String in issues:
		printerr("[ORIGEM_R4_R6_ALPHA_CANDIDATE_ERROR] %s" % issue)
	quit(1)
