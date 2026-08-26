## R6BasinArrivalReading.gd
## DEV6-R6-BASIN-ARRIVAL-READING-004
## Ajusta apenas a leitura dos vestígios físicos existentes na chegada à bacia; não cria nós, luzes ou colisores.

class_name R6BasinArrivalReading
extends Node

const NODE_NAME: String = "R6LeituraDaChegadaDaBacia"
const FRAME_NAME: String = "LimiarDasRuinasSubmersas"
const LEFT_PILLAR: String = "VestigioDaEntradaDaBacia_00"
const RIGHT_PILLAR: String = "VestigioDaEntradaDaBacia_01"

static func install(region: Node3D) -> R6BasinArrivalReading:
	if region == null:
		return null
	var existing: R6BasinArrivalReading = region.get_node_or_null(NODE_NAME) as R6BasinArrivalReading
	if existing != null:
		return existing
	var reading: R6BasinArrivalReading = R6BasinArrivalReading.new()
	reading.name = NODE_NAME
	region.add_child(reading)
	reading._apply(region)
	return reading

func _apply(region: Node3D) -> void:
	var frame: Node3D = region.get_node_or_null(FRAME_NAME) as Node3D
	if frame == null:
		push_warning("[ORIGEM_R6_ARRIVAL] Limiar físico da bacia indisponível.")
		return
	var left: Node3D = frame.get_node_or_null(LEFT_PILLAR) as Node3D
	var right: Node3D = frame.get_node_or_null(RIGHT_PILLAR) as Node3D
	if left == null or right == null:
		push_warning("[ORIGEM_R6_ARRIVAL] Vestígios de chegada incompletos.")
		return
	# A assimetria é aplicada aos dois pilares existentes: o ocidental abre a vista; o oriental aponta o olhar para a bacia.
	left.rotation.y -= 0.075
	right.rotation.y += 0.055
	left.set_meta("r6_basin_arrival_role", "abre_vista")
	right.set_meta("r6_basin_arrival_role", "conduz_para_bacia")
	left.set_meta("r6_basin_arrival_static", true)
	right.set_meta("r6_basin_arrival_static", true)
	set_meta("r6_basin_arrival_pillars", 2)
	set_meta("r6_basin_arrival_dynamic_lights", 0)
	set_meta("r6_basin_arrival_added_nodes", 0)
	print("[ORIGEM_R6_ARRIVAL] pilares_existentes=2 luzes=0 nos_novos=0")
