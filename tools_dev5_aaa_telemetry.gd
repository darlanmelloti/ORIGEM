extends SceneTree

const SAMPLE_SECONDS := 36.0
const SAMPLE_INTERVAL := 1.0

var elapsed := 0.0
var next_sample := 0.0
var samples: Array[Dictionary] = []
var root_scene: Node

func _initialize() -> void:
    var scene_path := OS.get_environment("CP_AAA_SCENE")
    if scene_path.is_empty():
        scene_path = "res://levels/dev5/CartographicGroundingPreview.tscn"
    root_scene = load(scene_path).instantiate()
    root_scene.name = "CPAAA04_IsolatedTelemetryRoot"
    root.add_child(root_scene)
    print("[CP_AAA_04] mode=%s" % scene_path)
    print("[CP_AAA_04] production_modules_changed=false")
    print("[CP_AAA_04] promotion_automatic=false")

func _process(delta: float) -> bool:
    elapsed += delta
    if elapsed >= next_sample:
        var light_count := _count_lights(root_scene)
        var fps := Engine.get_frames_per_second()
        var frame_time_ms := (1000.0 / fps) if fps > 0.0 else 0.0
        var sample := {"t": elapsed, "fps": fps, "frame_time_ms": frame_time_ms, "lights": light_count}
        samples.append(sample)
        print("[CP_AAA_04_SAMPLE] t=%.2f fps=%.2f frame_time_ms=%.3f lights=%d" % [elapsed, fps, frame_time_ms, light_count])
        next_sample += SAMPLE_INTERVAL
    if elapsed >= SAMPLE_SECONDS:
        _emit_summary()
        quit(0)
        return true
    return false

func _count_lights(node: Node) -> int:
    var total := 0
    if node is Light3D and node.visible:
        total += 1
    for child in node.get_children():
        total += _count_lights(child)
    return total

func _emit_summary() -> void:
    var measured: Array[Dictionary] = samples.slice(1) if samples.size() > 1 else []
    var fps_values: Array[float] = []
    var frame_values: Array[float] = []
    var max_lights := 0
    for sample in measured:
        fps_values.append(float(sample["fps"]))
        frame_values.append(float(sample["frame_time_ms"]))
        max_lights = max(max_lights, int(sample["lights"]))
    fps_values.sort()
    frame_values.sort()
    var p05_fps := fps_values[max(0, int(fps_values.size() * 0.05))] if not fps_values.is_empty() else 0.0
    var p95_frame_ms := frame_values[min(frame_values.size() - 1, int(frame_values.size() * 0.95))] if not frame_values.is_empty() else 0.0
    print("[CP_AAA_04_SUMMARY] samples=%d measured=%d p05_fps=%.2f p95_frame_time_ms=%.3f max_dynamic_lights=%d first_frame_excluded=true" % [samples.size(), measured.size(), p05_fps, p95_frame_ms, max_lights])
