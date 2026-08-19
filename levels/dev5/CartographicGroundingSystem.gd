## Dev5 — CP-D5-022: aterramento cartográfico por raycast.
## Preserva X/Z da âncora e ajusta exclusivamente a altura Y sobre colisão física.

class_name CartographicGroundingSystem
extends RefCounted

static func snap_to_ground(world: World3D, candidate: Node3D, desired_world_position: Vector3, collision_mask: int = 1) -> Dictionary:
	candidate.global_position = desired_world_position
	var ray_start := desired_world_position + Vector3.UP * 60.0
	var ray_end := desired_world_position + Vector3.DOWN * 140.0
	var query := PhysicsRayQueryParameters3D.create(ray_start, ray_end, collision_mask)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	var hit := world.direct_space_state.intersect_ray(query)
	if hit.is_empty():
		return {
			"grounded": false,
			"desired_y": desired_world_position.y,
			"impact_y": desired_world_position.y,
			"world_xz": Vector2(desired_world_position.x, desired_world_position.z),
		}
	var impact := hit["position"] as Vector3
	candidate.global_position = Vector3(desired_world_position.x, impact.y, desired_world_position.z)
	return {
		"grounded": true,
		"desired_y": desired_world_position.y,
		"impact_y": impact.y,
		"world_xz": Vector2(candidate.global_position.x, candidate.global_position.z),
		"collider": str((hit["collider"] as Object).name),
	}
