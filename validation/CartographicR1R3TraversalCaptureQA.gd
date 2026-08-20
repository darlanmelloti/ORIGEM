extends "res://validation/CartographicR1R3CaptureQA.gd"
## CP-D2-R1R6-005 — captura dinâmica QA-only do corredor R1→R2→R3.
## A câmara move-se sobre as âncoras existentes; nenhuma coordenada nova é criada.

func _initialize() -> void:
	qa_root = Node3D.new()
	qa_root.name = "CPD2R1R3TraversalCaptureQA"
	root_ready()
	get_root().add_child(qa_root)
	await process_frame
	var camera := qa_root.get_node_or_null("DedicatedR1R3Camera") as Camera3D
	if camera == null:
		push_error("DYNAMIC_CAPTURE_CAMERA_MISSING")
		quit(1)
		return
	var start := Anchors.world_position(Anchors.CASA_VOSS, 0.0, 9.0)
	var finish := Anchors.world_position(Anchors.ARCO_RUINAS, 0.0, 9.0)
	var direction := (finish - start).normalized()
	var stable_target := start.lerp(finish, 0.5)
	var duration := 30.0
	var override_seconds := OS.get_environment("QA_CAPTURE_SECONDS")
	if not override_seconds.is_empty():
		duration = maxf(float(override_seconds), 1.0)
	var frame_count := maxi(30, ceili(duration * 10.0))
	for frame: int in range(frame_count):
		var progress := float(frame) / float(frame_count - 1)
		var target := start.lerp(finish, progress)
		camera.look_at_from_position(target + Vector3(-26.0, 22.0, -38.0), stable_target + Vector3(0.0, 1.5, 0.0), Vector3.UP)
		if frame % 30 == 0:
			print("DYNAMIC_TRAVERSAL progress=%0.2f region_hint=%s" % [progress, _region_hint(progress)])
		await create_timer(duration / float(frame_count)).timeout
	print("CP-D2-R1R6-005_DYNAMIC_CAPTURE=PASS")
	quit(0)

func _region_hint(progress: float) -> String:
	if progress < 0.10:
		return "R1"
	if progress < 0.25:
		return "R1->R2"
	if progress < 0.92:
		return "R2"
	return "R2->R3"
