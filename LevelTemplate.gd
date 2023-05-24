extends Node2D

@export var drop_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$DropTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_drop_timer_timeout():
	var drop = drop_scene.instantiate()
	drop.init($CollectSound, $ExplodeSound)
	
	var drop_spawn_location = get_node("DropPath/DropSpawnLocation")
	drop_spawn_location.progress_ratio = randf()
	
	var direction = drop_spawn_location.rotation + PI / 2
	
	drop.position = drop_spawn_location.position
	
	add_child(drop)
