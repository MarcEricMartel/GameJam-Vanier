extends Area2D

@export var DAMAGE = 10;
@export var SPEED = 700;
@export var LIFETIME = 1.0;
@export var HANG_TIME = 0.0;
@export var FRICTION = 0.0;
@export var SIZE_MOD = 0.0;

@onready var sprite = $Sprite2D;

var rng = RandomNumberGenerator.new();
var is_hanging = false;
var velocity = Vector2.ZERO;
var time = 0.0;

func _ready():
	var size_mod = rng.randf() * SIZE_MOD;
	sprite.scale.x -= size_mod;
	sprite.scale.y -= size_mod;
	
	

func _process(delta):
	
	if is_hanging :
		velocity = velocity * FRICTION;
	if velocity != Vector2.ZERO:
		transform.origin += velocity * delta;
	
	time += delta;
	
	if time >= LIFETIME:
		end_of_life();
	if time >= LIFETIME + HANG_TIME:
		explode();

func launch(direction, based_velocity):
	velocity = based_velocity + direction * SPEED;

func _on_body_entered(body):
	if body.name != "Player":
		if body.is_in_group("enemies"):
			body.take_damage(DAMAGE);
		explode();

func end_of_life():
	is_hanging = true;

func explode():
	velocity = Vector2.ZERO;
	sprite.play("explosion");

func _on_sprite_2d_animation_finished():
	queue_free();
