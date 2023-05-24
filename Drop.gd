extends Area2D

const SPEED = 100
@onready var speed = SPEED
@export var explosionParticle:PackedScene
var collectSound: AudioStreamPlayer
var explodeSound: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += delta * speed
	
func init(col, exp):
	collectSound = col
	explodeSound = exp


func _on_body_entered(body):
	if body.name == "TileMap":
		speed = 0
		await get_tree().create_timer(1.0).timeout
		explode()
	if body.name == "Player":
		collectSound.play()
		queue_free()

func explode():
	Global.camera.shake(.2, 5)
	var _particle = explosionParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	explodeSound.play()
	queue_free()
