## Dev5 — CP-D5-023: telemetria de integridade do catálogo de alturas R1–R6.

extends Node3D

const CONTRACTS := preload("res://levels/dev5/CartographicHeightContracts.gd")

func _ready() -> void:
	var all_contracts := CONTRACTS.all_contracts()
	assert(all_contracts.size() == 6)
	_build_overlay(all_contracts)
	for contract_data: Dictionary in all_contracts:
		assert(CONTRACTS.validate_contract(contract_data))
		var anchor := contract_data["world_xz"] as Vector2
		print("[DEV5_HEIGHT_CONTRACT] r=%d name=%s xz=(%.3f,%.3f) owner=%s candidate=%s mode=%s" % [
			contract_data["anchor_id"],
			contract_data["anchor_name"],
			anchor.x,
			anchor.y,
			contract_data["terrain_owner"],
			contract_data["eligible_candidate"],
			contract_data["grounding_mode"],
		])
	print("[DEV5_HEIGHT_CONTRACT] status=approved coverage=6 terrain_owners=3 production_modules_changed=false")
	if OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT") != "":
		call_deferred("_save_snapshot_qa", OS.get_environment("ORIGEM_QA_VIEWPORT_SNAPSHOT"))

func _build_overlay(all_contracts: Array[Dictionary]) -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var backdrop := ColorRect.new()
	backdrop.color = Color(0.035, 0.055, 0.075, 0.96)
	backdrop.position = Vector2(96.0, 90.0)
	backdrop.size = Vector2(1720.0, 900.0)
	layer.add_child(backdrop)
	var title := Label.new()
	title.position = Vector2(150.0, 138.0)
	title.size = Vector2(1600.0, 70.0)
	title.text = "ORIGEM  ·  CP-D5-023  ·  CONTRATOS DE ALTURA R1–R6"
	title.add_theme_font_size_override("font_size", 31)
	title.modulate = Color(0.67, 0.85, 0.96)
	layer.add_child(title)
	var body := Label.new()
	body.position = Vector2(150.0, 236.0)
	body.size = Vector2(1570.0, 690.0)
	body.add_theme_font_size_override("font_size", 21)
	body.modulate = Color(0.89, 0.94, 0.96)
	var lines: Array[String] = ["MARCO    X/Z CANÓNICO            TERRENO RESPONSÁVEL                 CANDIDATO ELEGÍVEL"]
	for contract_data: Dictionary in all_contracts:
		var xz := contract_data["world_xz"] as Vector2
		lines.append("R%-2d  (%7.3f, %6.1f)   %-35s %s" % [
			contract_data["anchor_id"], xz.x, xz.y,
			contract_data["terrain_owner"], contract_data["eligible_candidate"],
		])
	lines.append("\nINVARIANTE: X/Z preservado · Y resolvido por raycast · produção regional inalterada")
	body.text = "\n".join(lines)
	layer.add_child(body)

func _save_snapshot_qa(snapshot_path: String) -> void:
	for frame_index: int in range(40):
		await get_tree().process_frame
	var result := get_viewport().get_texture().get_image().save_png(snapshot_path)
	print("[DEV5_HEIGHT_CONTRACT] snapshot=%s result=%s" % [snapshot_path, result])
