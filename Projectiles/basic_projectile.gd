extends Area2D

@export var DAMAGE = 10;
@export var SPEED = 700;
@export var LIFETIME = 1;

@onready var life_timer = $LifeTimer;

var velocity = Vector2.ZERO;

func _process(delta):
	if velocity != Vector2.ZERO:
		transform.origin += velocity * delta;

func launch(direction, based_velocity):
	life_timer.start(LIFETIME);
	velocity = based_velocity + direction * SPEED;

func _on_life_timer_timeout():
	queue_free();

func _on_body_entered(body):
	if body.name != "Player":
		if body.is_in_group("enemies"):
			body.take_damage(DAMAGE);
		explode();

func explode():
	#animation and stuff 
	queue_free();
