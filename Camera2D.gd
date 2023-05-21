extends Camera2D

var shake_amount = 0
var default_offset = offset
@onready var timer = $Timer
@onready var tween = create_tween()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	Global.camera = self
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1, 1) * shake_amount)
	
func shake(time, amount):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()



func _on_timer_timeout():
	set_process(false)
	tween.interpolate_value(self, "offset", 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
