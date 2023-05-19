extends Node2D

@onready var duration_timer = $DurationTimer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_dash(duration):
	if !self.is_dashing():
		duration_timer.wait_time = duration
		duration_timer.start()

func is_dashing():
	return !duration_timer.is_stopped()
