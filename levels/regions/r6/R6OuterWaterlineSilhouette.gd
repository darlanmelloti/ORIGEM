## R6OuterWaterlineSilhouette.gd
## DEV6-R6-OUTER-WATERLINE-SILHOUETTE-006
## Ajuste estático apenas nos acentos rochosos já existentes da margem exterior.

class_name R6OuterWaterlineSilhouette
extends RefCounted

static func apply(margin: Node3D) -> int:
	if margin == null:
		return 0
	if bool(margin.get_meta("r6_outer_waterline_silhouette_applied", false)):
		return int(margin.get_meta("r6_outer_waterline_silhouette_adjusted", 0))
	var adjusted: int = 0
	for child: Node in margin.get_children():
		if not child is Node3D or not String(child.name).begins_with("AcentoRochosoMargem_"):
			continue
		var rock: Node3D = child as Node3D
		var suffix: String = String(rock.name).replace("AcentoRochosoMargem_", "")
		var index: int = int(suffix)
		# Mantém a base e a margem navegável; a alteração é apenas de leitura lateral e profundidade da silhueta.
		rock.scale = Vector3(rock.scale.x * (1.03 + 0.012 * float(index)), rock.scale.y * 1.04, rock.scale.z * (0.97 + 0.010 * float(index)))
		rock.rotation.y += -0.075 + 0.038 * float(index)
		rock.set_meta("r6_outer_waterline_silhouette_static", true)
		adjusted += 1
	margin.set_meta("r6_outer_waterline_silhouette_applied", true)
	margin.set_meta("r6_outer_waterline_silhouette_adjusted", adjusted)
	margin.set_meta("r6_outer_waterline_silhouette_dynamic_lights", 0)
	print("[ORIGEM_R6_OUTER_WATERLINE] acentos_existentes_ajustados=%d luzes=0" % adjusted)
	return adjusted
