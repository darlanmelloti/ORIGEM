extends Node

@export var master_volume: float = 1.0
@export var music_volume: float = 0.7
@export var sfx_volume: float = 1.0

var current_music: String = ""

var music_player: AudioStreamPlayer
var ambient_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer


func _ready() -> void:
    music_player = AudioStreamPlayer.new()
    music_player.name = "MusicPlayer"
    music_player.bus = "Master"
    music_player.volume_db = linear_to_db(music_volume * master_volume)
    add_child(music_player)

    ambient_player = AudioStreamPlayer.new()
    ambient_player.name = "AmbientPlayer"
    ambient_player.bus = "Master"
    ambient_player.volume_db = linear_to_db(0.35 * music_volume * master_volume)
    ambient_player.stream = null
    ambient_player.stream_paused = false
    add_child(ambient_player)

    sfx_player = AudioStreamPlayer.new()
    sfx_player.name = "SfxPlayer"
    sfx_player.bus = "Master"
    sfx_player.volume_db = linear_to_db(sfx_volume * master_volume)
    add_child(sfx_player)

    if EventBus and EventBus.has_signal("world_event_triggered"):
        EventBus.world_event_triggered.connect(_on_world_event)

    if EventBus and EventBus.has_signal("timeline_era_changed"):
        EventBus.timeline_era_changed.connect(_on_era_changed)


func play_music(path: String, fade_in: float = 1.0) -> void:
    if path.is_empty():
        return

    if not FileAccess.file_exists(path):
        return

    current_music = path
    if music_player.stream != null and music_player.stream.resource_path == path:
        _fade_volume(music_player, linear_to_db(music_volume * master_volume), fade_in)
        return

    var stream: AudioStream = load(path)
    if stream == null:
        return

    music_player.stream = stream
    music_player.volume_db = -80.0
    music_player.play()
    _fade_volume(music_player, linear_to_db(music_volume * master_volume), fade_in)


func stop_music(fade_out: float = 1.0) -> void:
    if music_player.stream == null:
        return

    _fade_volume(music_player, -80.0, fade_out)
    await get_tree().create_timer(fade_out).timeout
    if music_player.volume_db <= -79.0:
        music_player.stop()
        music_player.stream = null
        current_music = ""


func play_sfx(path: String) -> void:
    if path.is_empty() or not FileAccess.file_exists(path):
        return

    var stream: AudioStream = load(path)
    if stream == null:
        return

    sfx_player.stream = stream
    sfx_player.play()


func play_ambient(path: String) -> void:
    if path.is_empty() or not FileAccess.file_exists(path):
        return

    var stream: AudioStream = load(path)
    if stream == null:
        return

    ambient_player.stream = stream
    ambient_player.play()
    ambient_player.stream_paused = false


func set_music_volume(value: float) -> void:
    music_volume = clamp(value, 0.0, 1.0)
    if music_player:
        music_player.volume_db = linear_to_db(music_volume * master_volume)


func set_sfx_volume(value: float) -> void:
    sfx_volume = clamp(value, 0.0, 1.0)
    if sfx_player:
        sfx_player.volume_db = linear_to_db(sfx_volume * master_volume)


func _on_world_event(event_id: String) -> void:
    match event_id:
        "tablet_1_found":
            play_sfx("res://audio/sfx/discovery.ogg")
        "all_tablets_found":
            play_sfx("res://audio/sfx/power_up.ogg")
        "game_ending_reached":
            stop_music(2.0)


func _on_era_changed(from_era: String, to_era: String) -> void:
    var era_music_path: String = _get_era_music_path(to_era)
    if era_music_path.is_empty():
        stop_music(1.0)
        return

    if current_music == era_music_path:
        return

    var fade_out_time: float = 0.8
    var fade_in_time: float = 1.2

    if music_player.stream != null:
        await stop_music(fade_out_time)

    play_music(era_music_path, fade_in_time)


func _get_era_music_path(era_name: String) -> String:
    match era_name.to_upper():
        "MODERN":
            return "res://audio/music/modern.ogg"
        "ANCIENT":
            return "res://audio/music/ancient.ogg"
        "PREHISTORIC":
            return "res://audio/music/prehistoric.ogg"
        "FUTURE_47K":
            return "res://audio/music/future_47k.ogg"
        _:
            return ""


func _fade_volume(player: AudioStreamPlayer, target_db: float, duration: float) -> void:
    if player == null:
        return

    var tween := create_tween()
    tween.tween_property(player, "volume_db", target_db, duration)


func save_data() -> Dictionary:
    return {
        "music_volume": music_volume,
        "sfx_volume": sfx_volume
    }


func load_data(data: Dictionary) -> void:
    if data.has("music_volume"):
        set_music_volume(float(data["music_volume"]))
    if data.has("sfx_volume"):
        set_sfx_volume(float(data["sfx_volume"]))
