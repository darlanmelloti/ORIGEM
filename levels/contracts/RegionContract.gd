## RegionContract.gd
## Contrato de integração para as Regiões 1–6 do vale de ORIGEM.
## Cada dono regional declara limites, âncoras, rotas QA e orçamento
## sem alterar diretamente o orquestrador, o jogador ou a UI cartográfica.

class_name RegionContract
extends RefCounted

var region_id: int = 0
var display_name: String = ""
var owner: String = ""
var entry_anchor: Vector2 = Vector2.ZERO
var exit_anchor: Vector2 = Vector2.ZERO
var bounds: AABB = AABB()
var allowed_dynamic_lights: int = 0
var qa_routes: PackedStringArray = PackedStringArray()
var source_module: String = ""
var notes: String = ""

func configure(
	id: int,
	region_name: String,
	region_owner: String,
	entry: Vector2,
	exit: Vector2,
	region_bounds: AABB,
	light_budget: int,
	routes: PackedStringArray,
	module_path: String,
	region_notes: String
) -> void:
	region_id = id
	display_name = region_name
	owner = region_owner
	entry_anchor = entry
	exit_anchor = exit
	bounds = region_bounds
	allowed_dynamic_lights = light_budget
	qa_routes = routes
	source_module = module_path
	notes = region_notes

func is_world_position_inside(world_position: Vector3) -> bool:
	return bounds.has_point(world_position)

func validate() -> PackedStringArray:
	var issues: PackedStringArray = PackedStringArray()
	if region_id < 1 or region_id > 6:
		issues.append("region_id fora do intervalo R1–R6")
	if display_name.is_empty():
		issues.append("nome de região ausente")
	if owner.is_empty():
		issues.append("dono da região ausente")
	if bounds.size.x <= 0.0 or bounds.size.z <= 0.0:
		issues.append("AABB regional inválido")
	if allowed_dynamic_lights < 0 or allowed_dynamic_lights > 16:
		issues.append("orçamento de luzes inválido")
	if qa_routes.is_empty():
		issues.append("sem rota QA declarada")
	if source_module.is_empty():
		issues.append("módulo de origem ausente")
	return issues

func to_dictionary() -> Dictionary:
	return {
		"id": region_id,
		"name": display_name,
		"owner": owner,
		"entry_anchor": entry_anchor,
		"exit_anchor": exit_anchor,
		"bounds": bounds,
		"allowed_dynamic_lights": allowed_dynamic_lights,
		"qa_routes": qa_routes,
		"source_module": source_module,
		"notes": notes
	}

func summary() -> String:
	return "R%d %s | owner=%s | lights=%d | qa=%s" % [
		region_id,
		display_name,
		owner,
		allowed_dynamic_lights,
		", ".join(qa_routes)
	]
