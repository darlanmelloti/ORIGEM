extends SceneTree

const INLET_ROOT := "AfluenteCartograficoRioParaBacia"
const INLET_WATER := "LaminaDoAfluenteCartografico"
const R6_LAKE_ROOT := "RuinasSubmersasDoLago"
const R6_LAKE_WATER := "LagoDasRuinasSubmersas"
const EXPECTED_VERTEX_COUNT := 24

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

	var inlet_root := region.get_node_or_null(INLET_ROOT) as Node3D
	var inlet_water := inlet_root.get_node_or_null(INLET_WATER) as MeshInstance3D if inlet_root != null else null
	var r6_lake_root := region.get_node_or_null(R6_LAKE_ROOT) as Node3D
	var r6_lake_water := r6_lake_root.get_node_or_null(R6_LAKE_WATER) as MeshInstance3D if r6_lake_root != null else null
	var inlet_mesh := inlet_water.mesh as ArrayMesh if inlet_water != null else null
	var r6_lake_mesh := r6_lake_water.mesh as ArrayMesh if r6_lake_water != null else null
	if inlet_mesh == null or r6_lake_mesh == null:
		_fail("malha R4 ou R6 indisponível")
		return

	var inlet_material := inlet_mesh.surface_get_material(0) as ShaderMaterial
	var r6_material := r6_lake_mesh.surface_get_material(0) as ShaderMaterial
	var inlet_shader_code := _shader_code(inlet_material)
	var r6_shader_code := _shader_code(r6_material)
	var inlet_arrays := inlet_mesh.surface_get_arrays(0)
	var inlet_vertices: PackedVector3Array = inlet_arrays[Mesh.ARRAY_VERTEX]

	var local_material_ok := inlet_material != null \
		and inlet_water.material_override == null \
		and inlet_shader_code.contains("blend_mix") \
		and inlet_shader_code.contains("depth_prepass_alpha") \
		and inlet_shader_code.contains("ALPHA = 0.68") \
		and not inlet_shader_code.contains("depth_draw_opaque")
	var geometry_ok := inlet_vertices.size() == EXPECTED_VERTEX_COUNT \
		and inlet_water.get_child_count() == 0 \
		and _count_lights(inlet_root) == 0
	var r6_preserved := r6_material != null \
		and r6_lake_water.material_override == null \
		and r6_shader_code.contains("depth_draw_opaque") \
		and r6_shader_code.contains("ALPHA = 1.0")

	region.queue_free()
	if local_material_ok and geometry_ok and r6_preserved:
		print("[ORIGEM_R4_INLET_LOCAL_MATERIAL_OK] lâmina R4 usa material local alpha=0.68; geometria, R6 e orçamento de luzes preservados.")
		quit()
		return
	_fail("local=%s geometria=%s r6=%s" % [local_material_ok, geometry_ok, r6_preserved])

func _shader_code(material: ShaderMaterial) -> String:
	if material == null or material.shader == null:
		return ""
	return material.shader.code

func _count_lights(node: Node) -> int:
	var count := 1 if node is Light3D else 0
	for child in node.get_children():
		count += _count_lights(child)
	return count

func _fail(detail: String) -> void:
	printerr("[ORIGEM_R4_INLET_LOCAL_MATERIAL_ERROR] %s" % detail)
	quit(1)
