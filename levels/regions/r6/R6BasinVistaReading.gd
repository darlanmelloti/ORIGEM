## R6BasinVistaReading.gd
## DEV6-R6-BASIN-VISTA-READING-005
## Ajuste de leitura exclusivamente nas rochas existentes do promontório oriental da bacia.

class_name R6BasinVistaReading
extends RefCounted

const MIN_SCALE: float = 0.10

static func apply(silhouette: Node3D) -> int:
	if silhouette == null:
		return 0
	if bool(silhouette.get_meta("r6_basin_vista_applied", false)):
		return int(silhouette.get_meta("r6_basin_vista_adjusted", 0))
	var adjusted: int = 0
	for child: Node in silhouette.get_children():
		if not child is Node3D or not String(child.name).begins_with("PromontorioOrientalDaBacia_"):
			continue
		var rock: Node3D = child as Node3D
		var suffix: String = String(rock.name).replace("PromontorioOrientalDaBacia_", "")
		var index: int = int(suffix)
		# A escala e o ângulo reforçam a leitura em profundidade, sem deslocar a base, água, cascata ou margem navegável.
		var horizontal_factor: float = 1.0 + 0.035 * float(index + 1)
		rock.scale = Vector3(rock.scale.x * horizontal_factor, rock.scale.y * (1.0 - 0.018 * float(index)), rock.scale.z * horizontal_factor)
		rock.rotation.y += -0.065 + 0.070 * float(index)
		rock.set_meta("r6_basin_vista_static", true)
		adjusted += 1
	silhouette.set_meta("r6_basin_vista_applied", true)
	silhouette.set_meta("r6_basin_vista_adjusted", adjusted)
	silhouette.set_meta("r6_basin_vista_dynamic_lights", 0)
	print("[ORIGEM_R6_BASIN_VISTA] rochas_existentes_ajustadas=%d luzes=0" % adjusted)
	return adjusted
