## R6MidgroundArchaeologyComposition.gd
## DEV6-R6-MIDGROUND-ARCHAEOLOGY-COMPOSITION-014
## Reorganiza visualmente três vestígios existentes da chegada R6, sem criar nós, física, luz ou materiais.

class_name R6MidgroundArchaeologyComposition
extends RefCounted

const ARRIVAL_READING_NAME: String = "R6_LeituraArqueologicaDaMargem"
const TARGETS: Array[Dictionary] = [
	{
		"name": "FragmentoDeColunaMargemR6",
		"scale_factor": Vector3(1.30, 1.42, 1.24),
		"rotation_delta": Vector3(0.055, -0.180, 0.035)
	},
	{
		"name": "PedraLeituraMargemR6_00",
		"scale_factor": Vector3(1.28, 1.18, 1.34),
		"rotation_delta": Vector3(0.025, 0.220, -0.040)
	},
	{
		"name": "PedraLeituraMargemR6_01",
		"scale_factor": Vector3(1.36, 1.16, 1.30),
		"rotation_delta": Vector3(-0.020, -0.245, 0.050)
	}
]

static func apply(arrival_reading: Node3D) -> int:
	if arrival_reading == null or arrival_reading.name != ARRIVAL_READING_NAME:
		return 0
	var adjusted: int = 0
	for target: Dictionary in TARGETS:
		var residue: Node3D = arrival_reading.get_node_or_null(String(target["name"])) as Node3D
		if residue == null:
			continue
		residue.set_meta("r6_midground_archaeology_base_position", residue.position)
		residue.scale *= target["scale_factor"] as Vector3
		residue.rotation += target["rotation_delta"] as Vector3
		residue.set_meta("r6_midground_archaeology_composition", true)
		adjusted += 1
	arrival_reading.set_meta("r6_midground_archaeology_targets", adjusted)
	arrival_reading.set_meta("r6_midground_archaeology_dynamic_lights", 0)
	arrival_reading.set_meta("r6_midground_archaeology_added_nodes", 0)
	return adjusted
