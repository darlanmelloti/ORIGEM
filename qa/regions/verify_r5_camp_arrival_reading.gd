## verify_r5_camp_arrival_reading.gd
## DEV5-R5-CAMP-ARRIVAL-READING-004

extends SceneTree

const FOREST_LAKE_SCRIPT: Script = preload("res://levels/ForestLakeRegion.gd")
const EXPECTED_BASES: int = 2
var _issues: PackedStringArray = PackedStringArray()

class TerrainPatchStub:
	extends Node3D

	func height_at(_world_x: float, _world_z: float) -> float:
		return 0.0

func _initialize() -> void:
	var world: Node3D = Node3D.new()
	world.name = "HarnessR5ArrivalReading"
	root.add_child(world)
	var terrain: Node3D = TerrainPatchStub.new()
	terrain.name = "TerrainPatch"
	world.add_child(terrain)
	var forest: Node3D = FOREST_LAKE_SCRIPT.new() as Node3D
	forest.name = "FlorestaELagoHarnessR5Arrival"
	world.add_child(forest)
	await process_frame
	await process_frame
	var camp: Node3D = forest.get_node_or_null("AcampamentoMajestic") as Node3D
	if camp == null:
		_fail("Acampamento Majestic ausente.")
	else:
		_validate_arrival_reading(camp)
	if _issues.is_empty():
		print("[ORIGEM_R5_ARRIVAL_READING_OK] duas bases existentes ajustadas, quatro luzes e zero física nova.")
		quit(0)
		return
	for issue: String in _issues:
		printerr("[ORIGEM_R5_ARRIVAL_READING_ERROR] %s" % issue)
	quit(1)

func _validate_arrival_reading(camp: Node3D) -> void:
	if not bool(camp.get_meta("r5_arrival_reading_applied", false)):
		_fail("Leitura estática da chegada não foi aplicada.")
	if int(camp.get_meta("r5_arrival_reading_dynamic_lights", -1)) != 0:
		_fail("Leitura de chegada R5 não pode criar luzes.")
	var arrival_markers: Node3D = camp.get_node_or_null("SilhuetasDeChegadaMajestic") as Node3D
	if arrival_markers == null:
		_fail("Silhuetas de chegada Majestic ausentes.")
		return
	var adjusted: int = 0
	for index: int in range(EXPECTED_BASES):
		var base_rock: Node3D = arrival_markers.get_node_or_null("BaseMastroMajestic_%02d" % (index + 1)) as Node3D
		if base_rock == null:
			_fail("Base de mastro ausente: %d." % (index + 1))
			continue
		if not bool(base_rock.get_meta("r5_arrival_reading_static", false)):
			_fail("Base não marcada como leitura estática: %s." % base_rock.name)
			continue
		adjusted += 1
		if not is_equal_approx(base_rock.position.x, 10.2) or not is_equal_approx(abs(base_rock.position.z), 5.6):
			_fail("Base de mastro deslocada da posição de chegada: %s." % base_rock.name)
		if base_rock.scale.x <= 0.0 or base_rock.scale.y <= 0.0 or base_rock.scale.z <= 0.0:
			_fail("Escala inválida na base de mastro: %s." % base_rock.name)
	if adjusted != EXPECTED_BASES:
		_fail("Leitura da chegada deve ajustar %d bases existentes; encontrou %d." % [EXPECTED_BASES, adjusted])
	if not arrival_markers.find_children("*", "Light3D", true, false).is_empty() or not arrival_markers.find_children("*", "StaticBody3D", true, false).is_empty():
		_fail("Silhuetas de chegada receberam luz ou física nova.")
	var r5_light_names: PackedStringArray = PackedStringArray([
		"LuzPrincipalDaFogueira",
		"LuzDeBrasaDoSolo",
		"PreenchimentoDoAcampamentoMajestic",
		"LuarFrioDoAcampamento"
	])
	var r5_lights: int = 0
	for light_name: String in r5_light_names:
		var light: Light3D = camp.get_node_or_null(light_name) as Light3D
		if light == null:
			_fail("Luz R5 esperada ausente: %s." % light_name)
		else:
			r5_lights += 1
	if r5_lights != 4:
		_fail("Orçamento R5 deve permanecer em quatro luzes; encontrou %d." % r5_lights)

func _fail(issue: String) -> void:
	_issues.append(issue)
