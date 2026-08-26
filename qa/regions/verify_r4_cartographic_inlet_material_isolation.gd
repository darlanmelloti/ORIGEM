extends SceneTree

const INLET_NODE_NAME := "AfluenteCartograficoRioParaBacia"
const WATER_NODE_NAME := "LaminaDoAfluenteCartografico"
const EXPECTED_VERTEX_COUNT := 24
const MIN_INLET_SPAN_X := 8.0
const MIN_INLET_SPAN_Z := 55.0

func _init() -> void:
	call_deferred("_verify")

func _verify() -> void:
	var region_script := load("res://levels/ForestLakeRegion.gd") as Script
	if region_script == null:
		_fail("construtor regional indisponível")
		return
	var region := region_script.new() as Node3D
	if region == null:
		_fail("instância regional indisponível")
		return
	root.add_child(region)
	await process_frame
	await process_frame

	var inlet := region.get_node_or_null(INLET_NODE_NAME) as Node3D
	var water := inlet.get_node_or_null(WATER_NODE_NAME) as MeshInstance3D if inlet != null else null
	var water_mesh := water.mesh as ArrayMesh if water != null else null
	if water_mesh == null or water_mesh.get_surface_count() != 1:
		_fail("malha isolável do afluente ausente")
		return

	var arrays := water_mesh.surface_get_arrays(0)
	var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
	var bounds := water_mesh.get_aabb()
	var geometry_isolated := vertices.size() == EXPECTED_VERTEX_COUNT \
		and bounds.size.x >= MIN_INLET_SPAN_X \
		and bounds.size.z >= MIN_INLET_SPAN_Z

	var production_material := water_mesh.surface_get_material(0) as ShaderMaterial
	var shader := production_material.shader as Shader if production_material != null else null
	var shader_code := shader.code if shader != null else ""
	# Antes da correcção 045, a instância usava a variante opaca partilhada.
	# Depois da correcção, esta mesma prova confirma que a origem continua material,
	# agora por uma variante local transparente, sem alterar a geometria.
	var material_contract_isolated := production_material != null \
		and shader != null \
		and ((shader_code.contains("depth_draw_opaque") and shader_code.contains("ALPHA = 1.0")) \
			or (shader_code.contains("depth_prepass_alpha") and shader_code.contains("ALPHA = 0.68")))

	# A malha de controlo é duplicada e recebe material transparente somente no nó QA.
	# A superfície de produção não recebe override, não é movida e conserva o mesmo material.
	var qa_root := Node3D.new()
	qa_root.name = "QAIsolamentoAfluenteCartografico"
	root.add_child(qa_root)
	var isolated_water := MeshInstance3D.new()
	var isolated_mesh := water_mesh.duplicate() as ArrayMesh
	var control_material := StandardMaterial3D.new()
	control_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	control_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	control_material.albedo_color = Color(0.028, 0.115, 0.150, 0.18)
	isolated_water.mesh = isolated_mesh
	isolated_water.material_override = control_material
	qa_root.add_child(isolated_water)

	var control_arrays := isolated_mesh.surface_get_arrays(0)
	var control_vertices: PackedVector3Array = control_arrays[Mesh.ARRAY_VERTEX]
	var control_preserves_geometry := control_vertices.size() == vertices.size() \
		and is_equal_approx(isolated_mesh.get_aabb().size.x, bounds.size.x) \
		and is_equal_approx(isolated_mesh.get_aabb().size.z, bounds.size.z)
	var production_unchanged := water_mesh.surface_get_material(0) == production_material \
		and water.material_override == null \
		and water.get_parent() == inlet

	qa_root.queue_free()
	region.queue_free()
	if geometry_isolated and material_contract_isolated and control_preserves_geometry and production_unchanged:
		print("[ORIGEM_R4_INLET_ISOLATION_OK] geometria=malha afluente 24 vértices/4 segmentos; origem=contrato de material isolado; controlo transparente preserva geometria; produção intacta.")
		quit()
		return
	_fail("geometria=%s material=%s controlo=%s produção=%s" % [geometry_isolated, material_contract_isolated, control_preserves_geometry, production_unchanged])

func _fail(detail: String) -> void:
	printerr("[ORIGEM_R4_INLET_ISOLATION_ERROR] %s" % detail)
	quit(1)
