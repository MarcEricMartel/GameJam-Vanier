extends Area2D

@export var DAMAGE = 1;
@export var SPEED = 800;
@export var LIFETIME = 3;

@onready var life_timer = $LifeTimer;

var velocity = Vector2.ZERO;

func _process(delta):
	if velocity != Vector2.ZERO:
		transform.origin += velocity * delta;

func launch(direction):
	life_timer.start(LIFETIME);
	velocity = direction * SPEED;

func _on_life_timer_timeout():
	queue_free();
