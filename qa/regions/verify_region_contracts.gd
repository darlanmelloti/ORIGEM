## verify_region_contracts.gd
## Executar com:
## godot --headless --path . --script res://qa/regions/verify_region_contracts.gd

extends SceneTree

const REGION_REGISTRY: Script = preload("res://levels/contracts/RegionRegistry.gd")

func _init() -> void:
	var contracts: Array = REGION_REGISTRY.create_r1_r6_contracts()
	var issues: PackedStringArray = REGION_REGISTRY.validate_r1_r6_contracts(contracts)
	if not issues.is_empty():
		for issue: String in issues:
			printerr("[ORIGEM_REGION_CONTRACT_ERROR] %s" % issue)
		quit(1)
		return
	REGION_REGISTRY.emit_summary(contracts)
	print("[ORIGEM_REGION_CONTRACT_OK] contratos R1–R6 válidos e prontos para integração paralela.")
	quit(0)
